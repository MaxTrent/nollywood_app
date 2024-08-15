import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../home_page.dart';

class LocationViewmodel extends ViewModel {
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  bool isButtonActive = false;

  late TextEditingController countryNameController;
  late TextEditingController stateNameController;
  late TextEditingController cityNameController;
  @override
  void init() {
    // TODO: implement init
    super.init();

    countryNameController = TextEditingController();
    stateNameController = TextEditingController();
    cityNameController = TextEditingController();

    countryNameController.addListener(() {
      final newIsButtonActive = countryNameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    stateNameController.addListener(() {
      final newIsButtonActive = stateNameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    cityNameController.addListener(() {
      final newIsButtonActive = cityNameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    countryNameController.dispose();
    stateNameController.dispose();
    cityNameController.dispose();
    super.dispose();
    notifyListeners();
  }

  void textClear() {
    countryNameController.clear();
    stateNameController.clear();
    cityNameController.clear();
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
            "country": countryNameController.text.trim().toString(),
            "state": stateNameController.text.trim().toString(),
            "city":cityNameController.text.trim().toString(),
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
        textClear();
        Fluttertoast.showToast(msg: message);
        print(Fluttertoast.showToast(msg: message));
        SecureStorageHelper.storeUserId(userId);
        textClear();
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
      AppUtils.debug(e.toString());
      print(Fluttertoast.showToast(msg: 'An error occurred: $e'));
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }
}
