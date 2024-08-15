import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../UI Actor/home_page.dart';
import '../../../data/api_layer.dart';
import '../../../utilities/api_status_response.dart';
import '../../../utilities/api_urls.dart';

class GenderEditViewmodel extends ViewModel{
  bool isButtonActive = false;
  String? _selectGenderIndex;
  String? get selectedGenderActorIndex => _selectGenderIndex;
  void selectGenderIndex(String value) {
    _selectGenderIndex = value;
    notifyListeners();
    updateColorState();
  }

  void updateColorState() {
    final newIsButtonActive =
        _selectGenderIndex != null || _selectGenderIndex != null;
    if (isButtonActive != newIsButtonActive) {
      isButtonActive = newIsButtonActive;
      notifyListeners();
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
            "gender": selectedGenderActorIndex.toString(),
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