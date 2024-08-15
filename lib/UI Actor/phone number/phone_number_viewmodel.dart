import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/data/api_layer.dart';
import 'package:pmvvm/pmvvm.dart';
import "package:flutter/material.dart";

import '../../locator.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';

class PhoneNumberViewmodel extends ViewModel {
  final apiLayer = locator<ApiLayer>();

  bool isButtonActive = false;
  bool isButtonPinVerificationActive = false;
  bool isButtonPasswordControllerActive = false;
  String confirmationId = '';
  late TextEditingController pinController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final firebaseMessaging = FirebaseMessaging.instance;

  bool passwordsMatch() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  FocusNode focusNode = FocusNode();
  late TextEditingController phoneNumberController;
  final formKey = GlobalKey<FormState>();
  final pinVerificationFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  void init() {
    super.init();
    phoneNumberController = TextEditingController();
    phoneNumberController.addListener(() {
      final newIsButtonActive = phoneNumberController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
      notifyListeners();
    });
    // pin verification
    pinController = TextEditingController();
    pinController.addListener(() {
      final newIsPinVerificationButtonActive = pinController.text.isNotEmpty;
      if (isButtonPinVerificationActive != newIsPinVerificationButtonActive) {
        isButtonPinVerificationActive = newIsPinVerificationButtonActive;
        notifyListeners();
      }
      notifyListeners();
    });
    // Password setup
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    passwordController.addListener(() {
      final newIsButtonPasswordControllerActive =
          passwordController.text.isNotEmpty;
      if (isButtonPasswordControllerActive !=
          newIsButtonPasswordControllerActive) {
        isButtonPasswordControllerActive = newIsButtonPasswordControllerActive;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    pinController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
    notifyListeners();
  }

  Future getPhoneVerificationCode() async {
    setLoadingState();
    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.initiateSignUpPhone,
        method: HttpMethod.post,
        body: {"phone_number": phoneNumberController.text.trim()},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        Fluttertoast.showToast(msg: message);
        print(response.body);
        Navigator.pushNamed(context, '/pinVericationPage');
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        print(response.errorResponse);
        Fluttertoast.showToast(msg: message);
        setLoadingState();
        notifyListeners();
      }
      return;
    } catch (e) {
      setLoadingState();
      notifyListeners();
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future validateOtp() async {
    setLoadingState();
    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.validateSignUpOtpPhone,
        method: HttpMethod.post,
        body: {
          "phone_number": phoneNumberController.text.trim(),
          "otp": pinController.text.trim(),
        },
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final confirmationId = data['data']['confirmationId'];
        final message = data['message'];
        AppUtils.debug(message);
        Fluttertoast.showToast(msg: message);
        Navigator.pushNamed(context, '/passwordSetUpPage');
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
        setLoadingState();
        notifyListeners();
      }
      return;
    } catch (e) {
      setLoadingState();
      notifyListeners();
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future actorPhoneNumberSignUserUp() async {
    setLoadingState();
    try {
      final fcmToken = firebaseMessaging.getToken().then((token) {
        print('fcm token: $token');
      });

      final response = await ApiLayer.makeApiCall(
        ApiUrls.finalizeSignUpPhone,
        method: HttpMethod.post,
        body: {
          "phone_number": phoneNumberController.text.trim(),
          "password": passwordController.text.trim().toString(),
          "confirmationId": confirmationId,
          "fcmDeviceToken": fcmToken
        },
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        Fluttertoast.showToast(msg: message);
        Navigator.pushNamed(context, '/loginPhoneNumberPage');
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
        setLoadingState();
        notifyListeners();
      }
      return;
    } catch (e) {
      setLoadingState();
      notifyListeners();
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }
}
