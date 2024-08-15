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

class EditProfileViewmodel extends ViewModel {
  bool switchValue = false;
   bool switchEmail = false;
    bool switchMessaga = false;
  late TextEditingController reviewController;
  late TextEditingController prefferedRolesOther;
  bool isButtonActive = false;

  @override
  void init() {
    // TODO: implement init
    super.init();
    fetchUserProfile();
    reviewController = TextEditingController();
    prefferedRolesOther = TextEditingController();
    reviewController.addListener(() {
      final newIsButtonActive = reviewController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    prefferedRolesOther.addListener(() {
      final newIsButtonActive = prefferedRolesOther.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    reviewController.dispose();
    prefferedRolesOther.dispose();
    super.dispose();
    notifyListeners();
  }
final List<Map<String, String>> profileEditList = [
      {
        'title': 'Age',
        'subtitle': '29'
      },
      {
        'title': 'Height',
        'subtitle': """6'11"""
      },
      {
        'title': 'Gender',
        'subtitle': 'Male'
      },
      {
        'title': 'Recent Projects',
        'subtitle': 'Mikolo (Niyi Akinmolayan)',
        'subtitleTwo': 'Jagun Jagun (Femi Adebayo)'
      },
      {
        'title': 'Education',
        'subtitle': 'PHD'
      },
      {
        'title': 'Link to reels',
        'subtitle': 'https://www.youtube.com'
      },
      {'title': 'Would you play an extra?', 
      'subtitle': 'yes,I would'
      },
      {
        'title': 'Language',
        'subtitle': 'Take and upload professional headshots'
      },
      {'title': 'Actor Lookalike', 
      'subtitle': 'Ramsey Noah'
      },
      
      {
        'title': 'Location',
        'subtitle': 'Victoria Island, Lagos, Nigeria'
      },
    ];

    GetUserProfileModel? getUserProfileModel;

  Future<GetUserProfileModel?> fetchUserProfile() async {
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
