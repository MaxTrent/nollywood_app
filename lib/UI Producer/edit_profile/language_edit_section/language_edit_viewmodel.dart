import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../UI Actor/home_page.dart';
import '../../../data/api_layer.dart';
import '../../../data/app_storage.dart';
import '../../../utilities/api_urls.dart';

class LanguageEditViewmodel extends ViewModel {
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  bool isButtonActive = false;

  late TextEditingController primaryLanguageController;
  late TextEditingController otherLanguagesController;
  
  @override
  void init() {
    super.init();

    primaryLanguageController = TextEditingController();
    otherLanguagesController = TextEditingController();

    primaryLanguageController.addListener(() {
      final newIsButtonActive = primaryLanguageController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });

    otherLanguagesController.addListener(() {
      final newIsButtonActive = otherLanguagesController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    primaryLanguageController.dispose();
    otherLanguagesController.dispose();
    super.dispose();
    notifyListeners();
  }

  void textClear() {
    primaryLanguageController.clear();
    otherLanguagesController.clear();
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
      
      final accessToken = await SecureStorageHelper.getAccessToken();
      
      // Convert otherLanguagesController text to an array
      final otherLanguagesArray = otherLanguagesController.text.split(',');

      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
        body: {
          "updateData": {
            "primary_language": primaryLanguageController.text.trim().toString(),
            "other_languages": otherLanguagesArray,
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
