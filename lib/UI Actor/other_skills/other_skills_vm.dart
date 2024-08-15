import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/components/app_textfield.dart';
import 'package:nitoons/data/api_layer.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:pmvvm/pmvvm.dart';

class OtherSkillsViewModel extends ViewModel {
  final apiLayer = locator<ApiLayer>();
  final storedValue = locator<SecureStorageHelper>();
  final storedId = locator<SharedPreferencesHelper>();

  OtherSkillsViewModel() {
    _controllers.add(_controller);
  }

  // State variables
  final TextEditingController _controller = TextEditingController();
  final List<TextEditingController> _controllers = [];
  final List<Widget> _textFields = [];

  // Getters to access state variables
  TextEditingController get controller => _controller;

  List<Widget> get textFields => _textFields;

  List<TextEditingController> get controllers => _controllers;

  // Check if all text fields are filled
  bool areAllTextFieldsFilled() =>
      _controllers.any((controller) => controller.text.isNotEmpty) ||
      _controller.text.isNotEmpty;

  // Method to add a new text field
  void addTextField() {
    if (areAllTextFieldsFilled()) {
      final newController = TextEditingController();
      _controllers.add(newController);
      _textFields.add(
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 13.0), // Use .0 for fixed padding value
              child: AppTextField(
                controller: newController,
                hintText: 'e.g Jim Iyke',
                labelText: 'Actor Lookalike',
              ),
            ),
          ],
        ),
      );
      notifyListeners(); // Notify listeners to update the UI
    } else {
      print('Cannot add a new text field until at least one field is filled');
    }
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  // Method to make a POST API call
  Future<void> submitData() async {
    setLoadingState();
    try {
       final homePagePath = await SharedPreferencesHelper.getUserHomePage();
      final accesstoken = await SecureStorageHelper.getAccessToken();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
         body: {
        "updateData": {
          'additional_skills': _controllers.map((controller) => controller.text).toList(),
        },
      },
      userAccessToken: accesstoken,
    );

      // print(userId);

      print(accesstoken);
      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];
        final userId = data['data']['user_id'];
        print(response.code);
        print(response.body);
        print(response);
        Fluttertoast.showToast(msg: message);
        print(Fluttertoast.showToast(msg: message));
        SecureStorageHelper.storeUserId(userId);
        if (homePagePath != null) {
          Navigator.pushReplacementNamed(context, homePagePath);
        }
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        print(response.code);
        print(data);
        print(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);

        print('toast${Fluttertoast.showToast(msg: message)}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e');
      print(Fluttertoast.showToast(msg: 'An error occurred: $e'));
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }
}
