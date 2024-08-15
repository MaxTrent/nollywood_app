import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/data/api_layer.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:pmvvm/pmvvm.dart';

import '../email_signup_opt/email_pin_verification.dart';

class EmailAddressSignUpViewmodel extends ViewModel {
  final apiLayer = locator<ApiLayer>();
  final storedValue = locator<SecureStorageHelper>();
  final storedId = locator<SharedPreferencesHelper>();

  bool isButtonActive = false;
  bool isButtonPinVerificationActive = false;
  bool isButtonPasswordControllerActive = false;

  late TextEditingController pinController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late String emailAddress;

  final firebaseMessaging = FirebaseMessaging.instance;

// OTP Timer

  // OTP Timer
  int _seconds = 120;
  Timer? _timer;
  bool get otpExpired => _seconds <= 0;

  String get timerText {
    final minutes = _seconds ~/ 60;
    final seconds = _seconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    notifyListeners();
    _seconds = 120;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        timer.cancel();
        notifyListeners();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void resetTimer() {
    _seconds = 120;
    _timer?.cancel();
    notifyListeners();
  }

// checking Password setup match
  bool passwordsMatch() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

// store user email address
  void setEmailAddress(String email) {
    emailAddress = email;
    SharedPreferencesHelper.storeUserEmail(emailAddress);
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  bool _pinloading = false;
  bool get pinloading => _pinloading;
  setLoadingPinState() {
    _pinloading = !_pinloading;
    notifyListeners();
  }

  bool _passwordloading = false;
  bool get passwordloading => _passwordloading;
  setLoadingPasswordState() {
    _passwordloading = !_passwordloading;
    notifyListeners();
  }

  bool _ResendOtpLoading = false;
  bool get ResendOtpLoading => _ResendOtpLoading;
  setLoadingResendOtpState() {
    _ResendOtpLoading = !_ResendOtpLoading;
    notifyListeners();
  }

  FocusNode focusNode = FocusNode();
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();
  final pinVerificationFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  void init() {
    super.init();
    //email controller
    emailController = TextEditingController();
    emailController.addListener(() {
      final newIsButtonActive = emailController.text.isNotEmpty;
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

  bool isPasswordHidden = true;
  void togglePassword() {
    if (isPasswordHidden == true) {
      isPasswordHidden = false;
    } else {
      isPasswordHidden = true;
    }
    notifyListeners();
  }

  bool isConfirmPasswordHidden = true;
  void toggleConfirmPassword() {
    if (isConfirmPasswordHidden == true) {
      isConfirmPasswordHidden = false;
    } else {
      isConfirmPasswordHidden = true;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    pinController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _timer?.cancel();
    super.dispose();
    notifyListeners();
  }

// resend Otp
  Future resendOtp() async {
    setLoadingResendOtpState();
    try {
      final email = emailController.text.trim().toString();
      print('Sending email for OTP: $email');

      final response = await ApiLayer.makeApiCall(
        ApiUrls.initiateSignUpEmail,
        method: HttpMethod.post,
        body: {"email": email},
      );

      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
        setEmailAddress(email);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        print('API call failed: $message');
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      print('Exception in resendOtp: $e');
    } finally {
      setLoadingResendOtpState();
      notifyListeners();
    }
  }

  // nextPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => EmailPinVericationPage(
  //         emailAddress: emailController.text.toString(),
  //       ),
  //     ),
  //   );
  // }

  Future<bool> getPhoneVerificationCode() async {
    setLoadingState();
    try {
      final email = emailController.text.trim();
      print('Sending email for OTP: $email');

      final response = await ApiLayer.makeApiCall(
        ApiUrls.initiateSignUpEmail,
        method: HttpMethod.post,
        body: {"email": email},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        
        Fluttertoast.showToast(msg: message);
        // Store the email after successful initiation
        setEmailAddress(email);
        return true;
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        print('API call failed: $message');
        Fluttertoast.showToast(msg: message);
        return false;
      }
    } catch (e) {
      AppUtils.debug(e.toString());
      print('Exception in getPhoneVerificationCode: $e');
      return false;
    } finally {
      setLoadingState();
      notifyListeners();
    }
    return false;
  }

  Future validateOtp() async {
    setLoadingPinState();
    try {
      final email = await SharedPreferencesHelper.getUserEmail();
      print('Stored email: $email');

      if (email != null && email.isNotEmpty) {
        final response = await ApiLayer.makeApiCall(
          ApiUrls.validateSignUpOtpEmail,
          method: HttpMethod.post,
          body: {
            "email": email.trim().toString(),
            "otp": pinController.text.trim(),
          },
        );
        print('email for otp: $email');
        print('otp: ${pinController.text.trim()}');

        if (response is Success) {
          AppUtils.debug(response.body);
          final data = json.decode(response.body);
          final confirmationId = data['data']['confirmationId'];
          await SecureStorageHelper.storeConfirmationId(confirmationId);
          final message = data['message'];
         
          Fluttertoast.showToast(msg: message);
          Navigator.pushNamed(context, '/emailPasswordSetUpPage');
        } else if (response is Failure) {
          final data = json.decode(response.errorResponse);
          print('Error response data: $data');
          print('Error code: ${response.code}');
          final message = data['message'];
          Fluttertoast.showToast(msg: message);
        }
      } else {
        print('Email not found');
      }
    } catch (e) {
      AppUtils.debug(e.toString());
      print('Exception in validateOtp: $e');
    } finally {
      setLoadingPinState();
      notifyListeners();
    }
  }

  Future actorEmailSignUserUp() async {
    setLoadingPasswordState();
    try {
      final email = await SharedPreferencesHelper.getUserEmail();
      final confirmationId = await SecureStorageHelper.getConfirmationId();

      print('Stored email: $email');
      print('Stored confirmationId: $confirmationId');

      if (email != null && email.isNotEmpty && confirmationId != null) {
        // final fcmToken = firebaseMessaging.getToken().then((token) {
        //   print('fcm token: $token');
        // });

        final response = await ApiLayer.makeApiCall(
          ApiUrls.finalizeSignUpEmail,
          method: HttpMethod.post,
          body: {
            "email": email.trim().toString(),
            "password": passwordController.text.trim().toString(),
            "confirmationId": confirmationId.trim().toString(),
           // "fcmDeviceToken": fcmToken
          },
        );

        if (response is Success) {
          AppUtils.debug(response.body);
          final data = json.decode(response.body);
          final message = data['message'];
          final user = data['data']['user'];
        final userEmail = user['email'];
        SharedPreferencesHelper.storeUserEmail(userEmail);
          AppUtils.debug(message);
          Fluttertoast.showToast(msg: message);
          Navigator.pushNamed(context, '/loginEmailAddressPage');
        } else if (response is Failure) {
          final data = json.decode(response.errorResponse);
          final message = data['message'];
          Fluttertoast.showToast(msg: message);
        }
      } else {
        if (email == null || email.isEmpty) {
          print('Error: Email is null or empty');
        }
        if (confirmationId == null) {
          print('Error: Confirmation ID is null');
        }
      }
    } catch (e) {
      AppUtils.debug(e.toString());
      print('Exception in actorEmailSignUserUp: $e');
    } finally {
      setLoadingPasswordState();
      notifyListeners();
    }
  }
}
