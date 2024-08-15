import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/UI%20Actor/role/sign_up_role_view.dart';
import 'package:nitoons/data/api_layer.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/models/get_user_profile_model.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/account_setup.dart';

class LoginEmailAddressViewmodel extends ViewModel {
  final apiLayer = locator<ApiLayer>();
  final storedValue = locator<SecureStorageHelper>();
  bool isLoginButtonActive = false;
  FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  final firebaseMessaging = FirebaseMessaging.instance;

  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  void init() {
    super.init();
    emailController = TextEditingController();
    _initEmailController();
    emailController.addListener(() {
      final newisLoginButtonActive = emailController.text.isNotEmpty;
      if (isLoginButtonActive != newisLoginButtonActive) {
        isLoginButtonActive = newisLoginButtonActive;
        notifyListeners();
      }
      notifyListeners();
    });
    passwordController = TextEditingController();
    passwordController.addListener(() {
      final newisLoginButtonActive = passwordController.text.isNotEmpty;
      if (isLoginButtonActive != newisLoginButtonActive) {
        isLoginButtonActive = newisLoginButtonActive;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
    notifyListeners();
  }

  Future<void> _initEmailController() async {
    final email = await SharedPreferencesHelper.getUserEmail();
    emailController.text = email ?? '';
  }

  void textClear() {
    emailController.clear();
    passwordController.clear();
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

  Future actorEmailSignUserIn() async {
    setLoadingState();

    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        final fcmToken = await firebaseMessaging.getToken();
        print('fcm token: $fcmToken');
        final response = await ApiLayer.makeApiCall(
          ApiUrls.loginEmail,
          method: HttpMethod.post,
          body: {
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
            "fcmDeviceToken": fcmToken.toString(),
          },
        );
        if (response is Success) {
          AppUtils.debug(response.body);
          final data = json.decode(response.body);
          final message = data['message'];
          final user = data['data']['user'];
          final userId = user['_id'];
          final userEmail = user['email'];
          SharedPreferencesHelper.storeUserEmail(userEmail);
          final userState = data['data']['profession'];
          storage(data['data']['profession']);
          final tokens = data['data']['tokens'];
          final accessToken = tokens['accessToken'];
          final refreshToken = tokens['refreshToken'];
          SecureStorageHelper.storeAccessToken(accessToken);
          SecureStorageHelper.storeRefreshToken(refreshToken);
          SecureStorageHelper.storeUserId(userId);
          SecureStorageHelper.storeAuthenticationStatus(true);
          SharedPreferencesHelper.storeUserProfession(userState);
          SecureStorageHelper.getProfileCompletion();
          final make = SharedPreferencesHelper.getUserProfession();
          _checkUserExistsAndNavigate(userId);
          _fetchApiResponse();
          AppUtils.debug(message);
          print(response.body);
          print("accessToken is $accessToken");
          print("refreshToken is $refreshToken");
          print("userId is $userId");
          print(
              "profession is ${SharedPreferencesHelper.storeUserProfession(userState)}");
          print("make prof is $make");
          Fluttertoast.showToast(msg: message);

          //  Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => SignUpRolePage()));

          textClear();
        } else if (response is Failure) {
          final data = json.decode(response.errorResponse);
          final message = data['message'];
          Fluttertoast.showToast(msg: message);
        }
        notifyListeners();
      }
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }

  Future<void> _checkUserExistsAndNavigate(String userId) async {
    try {
      final accesstoken = await SecureStorageHelper.getAccessToken();

      final response = await ApiLayer.makeApiCall(
        ApiUrls.getUserProfile + userId,

        //'${ApiUrls.getUserProfile.trim()}/:$userId}',
        method: HttpMethod.get,
        // body: {"userId":userId},
        requireAccess: true,

        userAccessToken: accesstoken,
      );
      print("${ApiUrls.getUserProfile}");
      print("_checkUserExistsAndNavigate $userId");
      if (response is Success) {
        final data = json.decode(response.body);
        final getUserProfileModel = GetUserProfileModel.fromJson(data);
        final userExists = getUserProfileModel.data;
        print('me');
        if (userExists != null && userExists.profession == 'Actor') {
          await SharedPreferencesHelper.storeUserHomePage('/home_page');
          await SharedPreferencesHelper.storeUserProfession(userExists.profession.toString());
          Navigator.pushReplacementNamed(context, '/home_page');
        } else if (userExists != null && userExists.profession == 'Producer') {
         await SharedPreferencesHelper.storeUserProfession(userExists.profession.toString());
          await SharedPreferencesHelper.storeUserHomePage(
              '/producer_home_page');
          Navigator.pushNamedAndRemoveUntil(context, '/producer_home_page',(route)=>false);
        }
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignUpRolePage()));
      }
    } catch (e) {
      AppUtils.debug(e.toString());
      Fluttertoast.showToast(msg: 'Error checking user existence');
    }
  }

  late AccountSetupModel getUserProfileModel;

  Future<AccountSetupModel> _fetchApiResponse() async {
    try {
      final userId = await SecureStorageHelper.getUserId();
      final accessToken = await SecureStorageHelper.getAccessToken();
      final isAuthenticated = await SecureStorageHelper.isAuthenticated();
      final iscomplete = await SecureStorageHelper.getProfileCompletion();

      final response = await ApiLayer.makeApiCall(
        ApiUrls.completeAccountSetup,
        requireAccess: true,
        method: HttpMethod.get,
        userAccessToken: accessToken,
      );
      if (response is Success) {
        final data = json.decode(response.body);
        final profileModel = AccountSetupModel.fromJson(data);
        getUserProfileModel = profileModel;
        return profileModel;
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        AppUtils.debug(message);
        //  Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      AppUtils.debug(e.toString());
    }
    notifyListeners();
    return getUserProfileModel;
  }

  void storage(
    String professional,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("profession", professional);
  }
}
//SecureStorageHelper.clearAuthenticationStatus();





















