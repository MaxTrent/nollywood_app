import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../UI Actor/home_page.dart';
import '../../../data/api_layer.dart';
import '../../../data/app_storage.dart';
import '../../../utilities/api_status_response.dart';
import '../../../utilities/api_urls.dart';

class RecentProjectViewmodel extends ViewModel {
  Map<String, String> projectProducerMap = {};
  List<TextEditingController> projectControllers = [];
  List<TextEditingController> producerControllers = [];

  bool isButtonActive = false;

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

  void _updateProjectProducerMap(
      TextEditingController projectController, TextEditingController producerController) {
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

  void submitForm() {
    List<String> projects = projectControllers.map((c) => c.text).toList();
    List<String> producers = producerControllers.map((c) => c.text).toList();
  }

  bool _loading = false;
  bool get loading => _loading;

  void setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  void textClear() {
    producerControllers.clear();
    projectControllers.clear();
  }

  Future<void> submitData() async {
    setLoadingState();
    try {
      final homePagePath = await SharedPreferencesHelper.getUserHomePage();
      
      final accesstoken = await SecureStorageHelper.getAccessToken();

      List<Map<String, String>> recentProjects = [];
      for (int i = 0; i < projectControllers.length; i++) {
        recentProjects.add({
          'project_name': projectControllers[i].text,
          'producer': producerControllers[i].text,
        });
      }

      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
        body: {
          "updateData": {
            "recent_projects": recentProjects,
          },
        },
        userAccessToken: accesstoken,
      );

      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];
        final userId = data['data']['user_id'];
        Fluttertoast.showToast(msg: message);
        SecureStorageHelper.storeUserId(userId);
        textClear();
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
      setLoadingState();
      notifyListeners();
    }
  }
}
