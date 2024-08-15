import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/UI%20Actor/SignUp/sign_up.dart';
import 'package:nitoons/UI%20Actor/home_page.dart';
import 'package:nitoons/data/api_layer.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/models/get_user_profile_model.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:pmvvm/pmvvm.dart';

import 'onboarding/onboarding.dart';


class ActorProfileViewmodel extends ViewModel {
  @override
  void init() {
    super.init();
    fetchUserProfile();
  }

  // Future<void> logout() async {
  //   try {
  //     await SecureStorageHelper.clearAuthenticationStatus();

  //     Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) => Onboarding()),
  //       (Route<dynamic> route) => false,
  //     );
  //   } catch (error) {
  //     print("Logout failed: $error");
  //   }
  // }

  GetUserProfileModel? getUserProfileModel;

  Future<GetUserProfileModel?> fetchUserProfile() async {
    try {
      final userId = await SecureStorageHelper.getUserId();
      final accessToken = await SecureStorageHelper.getAccessToken();
      final isAuthenticated = await SecureStorageHelper.isAuthenticated();

      // if (!isAuthenticated) {
      //   Scaffold(
      //     body: Container(),
      //   );
      //   // Navigator.pushReplacement(
      //   //   context,
      //   //   MaterialPageRoute(builder: (context) => SignUpPage()),
      //   // );
      //   return null;
      // }

      final response = await ApiLayer.makeApiCall(
        ApiUrls.getUserProfile + userId!,
        requireAccess: true,
        method: HttpMethod.get,
        userAccessToken: accessToken,
      );
      print('${ApiUrls.getUserProfile}/$userId');

      if (response is Success) {
        AppUtils.debug(response.body);
        print(response);
        final data = json.decode(response.body);
        final message = data['message'];
        final profileModel = GetUserProfileModel.fromJson(data);
        getUserProfileModel = profileModel;
        Fluttertoast.showToast(msg: message);
        notifyListeners();
        if (data['code'] == 400) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignUpPage()));
        }
        return profileModel;
      } else if (response is Failure) {
        print(response);
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return getUserProfileModel;
    } catch (e) {
      AppUtils.debug(e.toString());
    }
    notifyListeners();
    return null; // Notify listeners to update the UI
  }
}
