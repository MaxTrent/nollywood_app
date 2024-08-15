import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';
import '../onboarding/onboarding.dart';

class settingsViewmodel extends ViewModel {
  Future logout() async {
    final refreshToken = await SecureStorageHelper.getRefreshToken();

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.logOut,
        method: HttpMethod.post,
        body: {"refreshToken": refreshToken},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        SecureStorageHelper.clearAuthenticationStatus();
        SecureStorageHelper.clearUserId();
        SharedPreferencesHelper.clearUserProfession();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Onboarding()),
          (Route<dynamic> route) => false,
        );
        notifyListeners();
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        AppUtils.debug(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
        //      Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (context) => SignUpPage()),
        //   (Route<dynamic> route) => false,
        // );
      }
    } catch (e) {
      AppUtils.debug(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
