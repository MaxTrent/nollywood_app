
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../data/api_layer.dart';
import '../../models/get_user_profile_model.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';

class EditActorProfileViewmodel extends ViewModel {
  

    @override
  void init() {
    // TODO: implement init
    super.init();
    fetchActorUserProfile();
  }
  GetUserProfileModel? getUserProfileModel;

  Future<GetUserProfileModel?> fetchActorUserProfile() async {
    try {
      final userId = await SecureStorageHelper.getUserId();
      final accessToken = await SecureStorageHelper.getAccessToken();
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
        AppUtils.debug(message);

        final profileModel = GetUserProfileModel.fromJson(data);
        getUserProfileModel = profileModel;
        Fluttertoast.showToast(msg: message);
        notifyListeners();
        return profileModel;
      } else if (response is Failure) {
        print(response);
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      AppUtils.debug(e.toString());
      Fluttertoast.showToast(msg: 'Error fetching user profile');
    }
    notifyListeners(); // Notify listeners to update the UI
    return getUserProfileModel;
  }

}
