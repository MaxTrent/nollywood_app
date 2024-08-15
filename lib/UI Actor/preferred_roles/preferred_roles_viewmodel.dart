import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../models/user_profile_model.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';

class PreferredRolesViewModel extends ViewModel {
  final List<bool> tileSelected = List.generate(14, (index) => false);
  final TextEditingController otherController = TextEditingController();
  final List<String> roleNames = [
    'Step brother',
    'Step sister',
    'Teacher',
    'Student',
    'Doctor',
    'Nurse',
    'Engineer',
    'Artist',
    'Musician',
    'Chef',
    'Police Officer',
    'Firefighter',
    'Pilot',
    'Farmer',
  ];

  bool isTileSelected(int index) => tileSelected[index];

  bool isAnyTileSelected() {
    return tileSelected.any((selected) => selected) ||
        otherController.text.isNotEmpty;
  }

  void toggleTileSelection(int index) {
    tileSelected[index] = !tileSelected[index];
    notifyListeners();
  }

  void clearSelections() {
    for (int i = 0; i < tileSelected.length; i++) {
      tileSelected[i] = false;
    }
    otherController.clear();
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> updatePreferredRoleProfile() async {
    setLoadingState();
    try {
      final homePagePath = await SharedPreferencesHelper.getUserHomePage();
      
      final accesstoken = await SecureStorageHelper.getAccessToken();

      // Gather selected roles into a list
      List<String> selectedRolesList = [];
      for (int i = 0; i < tileSelected.length; i++) {
        if (tileSelected[i]) {
          selectedRolesList.add(roleNames[i]);
        }
      }

      // Add roles from otherController
      if (otherController.text.isNotEmpty) {
        List<String> otherRoles =
            otherController.text.split(',').map((e) => e.trim()).toList();
        selectedRolesList.addAll(otherRoles);
      }

      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
        body: {
          "updateData": {
            "preferred_roles": selectedRolesList,
          }
        },
        userAccessToken: accesstoken,
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        final userId = data['data']['user_id'];
        AppUtils.debug(message);
        Fluttertoast.showToast(msg: message);
        SecureStorageHelper.storeUserId(userId);
        clearSelections();
        otherController.clear();
        if (homePagePath != null) {
          Navigator.pushReplacementNamed(context, homePagePath);
        }
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      AppUtils.debug(e.toString());
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }
}
