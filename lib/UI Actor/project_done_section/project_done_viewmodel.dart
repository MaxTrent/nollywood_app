import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../home_page.dart';

class ProjectDoneViewmodel extends ViewModel {
  Map<String, String> projectProducerMap = {};
  List<TextEditingController> projectControllers = [];
  List<TextEditingController> producerControllers = [];

  bool isButtonActive = false;
  bool _loading = false;

  bool get loading => _loading;

  ProjectDoneViewmodel() {
    // Initialize with one set of controllers
    addMore();
  }

  void addMore() {
    var projectController = TextEditingController();
    var producerController = TextEditingController();

    projectController.addListener(() {
      _updateProjectProducerMap(projectController, producerController);
    });
    producerController.addListener(() {
      _updateProjectProducerMap(projectController, producerController);
    });

    projectControllers.add(projectController);
    producerControllers.add(producerController);
    notifyListeners();
  }

  void _updateProjectProducerMap(TextEditingController projectController,
      TextEditingController producerController) {
    projectProducerMap[projectController.text] = producerController.text;
    _updateButtonState();
  }

  void _updateButtonState() {
    final newIsButtonActive = projectControllers.isNotEmpty &&
        projectControllers.every((controller) => controller.text.isNotEmpty) &&
        producerControllers.every((controller) => controller.text.isNotEmpty);
    if (isButtonActive != newIsButtonActive) {
      isButtonActive = newIsButtonActive;
      notifyListeners();
    }
  }

  void setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

   void textClear() {
    for (var controller in projectControllers) {
      controller.dispose();
    }
    for (var controller in producerControllers) {
      controller.dispose();
    }
    projectControllers.clear();
    producerControllers.clear();
  }

  void resetForm() {
    textClear();
    addMore(); // Add a new default set of controllers
    notifyListeners();
  }

  Future<void> submitData() async {
    setLoadingState(); // Sets loading state, which you handle in UI.

    try {
      final homePagePath = await SharedPreferencesHelper.getUserHomePage();
      final accessToken = await SecureStorageHelper.getAccessToken();

      // Prepare recent projects data
      List<Map<String, String>> recentProjects = [];
      for (int i = 0; i < projectControllers.length; i++) {
        recentProjects.add({
          'project_name': projectControllers[i].text,
          'producer': producerControllers[i].text,
        });
      }

      // Make API call to update user profile with recent projects
      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
        body: {
          "updateData": {
            "recent_projects": recentProjects,
          },
        },
        userAccessToken: accessToken,
      );

      // Handle response based on success or failure
      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];
        final userId = data['data']['user_id'];
        Fluttertoast.showToast(msg: message);
        SecureStorageHelper.storeUserId(userId);
        resetForm();
       if (homePagePath != null) {
          Navigator.pushReplacementNamed(context, homePagePath);
        }
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e');
    } finally {
      setLoadingState(); // Reset loading state
      notifyListeners(); // Notify listeners to update UI
    }
  }
}
