import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../components/app_textfield.dart';
import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';

class LinkToReelsViewModel extends ViewModel {
  final TextEditingController controller = TextEditingController();
  final List<TextEditingController> controllers = [];
  final List<Widget> textFields = [];

  bool areAllTextFieldsFilled() {
    return controllers.any((controller) => controller.text.isNotEmpty) || controller.text.isNotEmpty;
  }

  void addTextField() {
    if (areAllTextFieldsFilled()) {
      final newController = TextEditingController();
      controllers.add(newController);
      textFields.add(
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: AppTextField(
                controller: newController,
                hintText: 'e.g https://www.youtube.com',
                labelText: 'Link',
              ),
            ),
          ],
        ),
      );
      notifyListeners();
    } else {
      print('Cannot add a new text field until at least one field is filled');
    }
  }

  bool _loading = false;
  bool get loading => _loading;

  void setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  // Method to make a POST API call
  Future<void> submitData() async {
    setLoadingState();
    try {
      final homePagePath = await SharedPreferencesHelper.getUserHomePage();
      
      final accessToken = await SecureStorageHelper.getAccessToken();

      // Gather all text values from the text controllers
      final links = [
        controller.text,
        ...controllers.map((controller) => controller.text),
      ].where((text) => text.isNotEmpty).toList();

      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
        body: {
          "updateData": {
            'link_to_reels': links,
          },
        },
        userAccessToken: accessToken,
      );

      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];
        final userId = data['data']['user_id'];
        Fluttertoast.showToast(msg: message);
        SecureStorageHelper.storeUserId(userId);
        
        // Reset form fields after successful submission
        controller.clear();
        for (var controller in controllers) {
          controller.clear();
        }
        controllers.clear();
        textFields.clear();
        notifyListeners();

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
