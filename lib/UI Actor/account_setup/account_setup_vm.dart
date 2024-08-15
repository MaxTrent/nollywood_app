// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/data/api_layer.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/models/account_setup.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:pmvvm/view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_colors.dart';
import '../../constants/sizes.dart';
import '../../constants/spacings.dart';
import '../../widgets/base_text.dart';
import '../../widgets/main_button.dart';
import '../SignUp/sign_up.dart';

class AccountSetupViewModel extends ViewModel {
  bool isComplete = false;
  int activeCount = 0;
  final storedValue = locator<SharedPreferencesHelper>();
  final List<Map<String, String>> accountTileList = [
    {
      "indicator": 'preferred_roles',
      'title': 'Add Preferred roles',
      'subtitle': 'Take and upload professional headshots',
      'route': '/preferredRoles'
    },
    {
      "indicator": 'actor_lookalike',
      'title': 'Actor lookalike',
      'subtitle': 'Take and upload professional headshots',
      'route': '/actorlookalikeScreen'
    },
    {
      "indicator": 'background_actor',
      'title': 'Background actor',
      'subtitle': 'Take and upload professional headshots',
      'route': '/backgroundActorPage'
    },
    {
      "indicator": 'additional_skills',
      'title': 'Additional skills',
      'subtitle': 'Take and upload professional headshots',
      'route': '/otherSkills'
    },
     {
      "indicator": 'profile_picture',
      'title': 'Profile picture',
      'subtitle': 'Upload your profile picture',
      'route': '/profilePictureView'
    },
    {
      "indicator": 'recent_projects',
      'title': 'Recent projects',
      'subtitle': 'Take and upload professional headshots',
      'route': '/projectDonePage'
    },
    {
      "indicator": 'address',
      'title': 'Location',
      'subtitle': 'Take and upload professional headshots',
      'route': '/locationView'
    },
    {
      "indicator": 'height',
      'title': 'Height',
      'subtitle': 'Take and upload professional headshots',
      'route': '/heightScreen'
    },
    {
      "indicator": 'other_languages',
      'title': 'Language',
      'subtitle': 'Take and upload professional headshots',
      'route': '/languageScreen'
    },
    {
      "indicator": 'link_to_reels',
      'title': 'Link to reels',
      'subtitle': 'Take and upload professional headshots',
      'route': '/linkToReels'
    },
    {
      "indicator": 'awards',
      'title': 'Awards',
      'subtitle': 'Take and upload professional headshots',
      'route': '/awards'
    },
    {
      "indicator": 'education',
      'title': 'Education',
      'subtitle': 'Take and upload professional headshots',
      'route': '/educationPage'
    },
    {
      "indicator": 'side_headshot',
      'title': 'Headshots',
      'subtitle': 'Take and upload professional headshots',
      'route': '/headshotView'
    },
    {
      "indicator": 'skin_type',
      'title': 'Skin colour',
      'subtitle': 'Take and upload professional headshots',
    },
    {
      "indicator": 'gender',
      'title': 'Gender',
      'subtitle': 'Take and upload professional headshots',
    },
    {
      "indicator": 'actual_age',
      'title': 'Age',
      'subtitle': 'Take and upload professional headshots',
    },
    {
      "indicator": 'first_name',
      'title': 'Name',
      'subtitle': 'Take and upload professional headshots',
    },
  ];
  final List<Map<String, String>> producerTileList = [
    {
      "indicator": 'film_maker_profile',
      'title': 'Film maker Profile',
      'subtitle': 'Take and upload professional headshots',
    },
    {
      "indicator": 'company_name',
      'title': 'Company Info',
      'subtitle': 'Take and upload professional headshots',
      'route': '/actorlookalikeScreen'
    },
    {
      "indicator": 'address',
      'title': 'Company Location',
      'subtitle': 'Take and upload professional headshots',
      'route': '/backgroundActorPage'
    },
    {
      "indicator": 'recent_projects',
      'title': 'Recent projects',
      'subtitle': 'Take and upload professional headshots',
      'route': '/projectDonePage'
    },
    {
      "indicator": 'primary_language',
      'title': 'Language',
      'subtitle': 'Take and upload professional headshots',
      'route': '/languageScreen'
    },
    {
      "indicator": 'awards',
      'title': 'Awards',
      'subtitle': 'Take and upload professional headshots',
      'route': '/awards'
    },
    {
      "indicator": 'education',
      'title': 'Education',
      'subtitle': 'Take and upload professional headshots',
      'route': '/educationPage'
    },
    {
      "indicator": 'profile_picture',
      'title': 'Profile picture',
      'subtitle': 'Take and upload professional headshots',
    },
    {
      "indicator": 'gender',
      'title': 'Gender',
      'subtitle': 'Take and upload professional headshots',
      'route': '/genderUpdate'
    },
    {
      "indicator": 'actual_age',
      'title': 'Age',
      'subtitle': 'Take and upload professional headshots',
      'route': '/ageUpdate'
    },
    {
      "indicator": 'first_name',
      'title': 'Name',
      'subtitle': 'Take and upload professional headshots',
    },
  ];
  List<Map<String, String>> _accountList = [];
  List<Map<String, String>> get accountList => _accountList;

  @override
  void init() async {
    super.init();
     fetchApiResponse();
    await accountPages();
    await checkProfileCompletion();
   
  }

  Future<void> accountPages() async {
    final userProfession = await SharedPreferencesHelper.getUserProfession();
    final accessToken = await SecureStorageHelper.getAccessToken();
    final isAuthenticated = await SecureStorageHelper.isAuthenticated();
    if (!isAuthenticated) {
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BaseText(
            'Login',
            color: black,
            fontSize: TextSizes.textSize16SP,
            fontWeight: FontWeight.w600,
          ),
          elevation: 1,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.perm_identity_outlined,
                color: textNotActive,
                size: IconSizes.largestIconSize,
              ),
              BaseText(
                'Login to access this resource',
                fontWeight: FontWeight.w600,
                fontSize: TextSizes.textSize16SP,
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacings.spacing40.w),
                child: MainButton(
                  text: 'Login',
                  buttonColor: black,
                  textColor: white,
                  press: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                      (route) => false,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    }
    if (userProfession == null ||
        userProfession.isEmpty ||
        accessToken == null ||
        accessToken.isEmpty) {
      print('User Profession or accessToken is empty or not set');
      return;
    }

    if (userProfession == "Producer") {
      _accountList = producerTileList;
    } else if (userProfession == "Actor") {
      _accountList = accountTileList;
    } else {
      print('Unexpected user profession: $userProfession');
    }
    notifyListeners();
  }

  Future<void> checkProfileCompletion() async {
    final isAuthenticated = await SecureStorageHelper.isAuthenticated();
    if (!isAuthenticated) {
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BaseText(
            'Login',
            color: black,
            fontSize: TextSizes.textSize16SP,
            fontWeight: FontWeight.w600,
          ),
          elevation: 1,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.perm_identity_outlined,
                color: textNotActive,
                size: IconSizes.largestIconSize,
              ),
              BaseText(
                'Login to access this resource',
                fontWeight: FontWeight.w600,
                fontSize: TextSizes.textSize16SP,
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacings.spacing40.w),
                child: MainButton(
                  text: 'Login',
                  buttonColor: black,
                  textColor: white,
                  press: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                      (route) => false,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    } else {
      final response = await fetchApiResponse();
      final data = response.data;

      activeCount = _accountList.where((item) {
        return data[item['indicator']!.toLowerCase().replaceAll(' ', '_')] ??
            false;
      }).length;

      isComplete = activeCount == _accountList.length;
      notifyListeners();
    }
  }

  late AccountSetupModel getUserProfileModel;

  Future<AccountSetupModel> fetchApiResponse() async {
    
      final isAuthenticated = await SecureStorageHelper.isAuthenticated();
      final accessToken = await SecureStorageHelper.getAccessToken();
      if (!isAuthenticated) {
        // LoginBottomSheetMethod();
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BaseText(
              'Login',
              color: black,
              fontSize: TextSizes.textSize16SP,
              fontWeight: FontWeight.w600,
            ),
            elevation: 1,
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.perm_identity_outlined,
                  color: textNotActive,
                  size: IconSizes.largestIconSize,
                ),
                SizedBox(height: 10.h,),
                BaseText(
                  'Login to access this resource',
                  fontWeight: FontWeight.w600,
                  fontSize: TextSizes.textSize16SP,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Spacings.spacing70.w),
                  child: MainButton(
                    text: 'Login',
                    buttonColor: black,
                    textColor: white,
                    press: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                        (route) => false,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }
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
        Fluttertoast.showToast(msg: message);
      }
    notifyListeners();
    return getUserProfileModel;
  }
}



// final isAuthenticated = await SecureStorageHelper.isAuthenticated();
//       final isSetUpCompleted = await SharedPreferencesHelper.getProfileCompletion();
      
//        if (userId==null) {
//       //   Container(
//       //       child: Column(
//       //   crossAxisAlignment: CrossAxisAlignment.center,
//       //   mainAxisAlignment: MainAxisAlignment.center,
//       //   children: [
//       //     Icon(Icons.perm_identity_outlined,color: textNotActive,size: IconSizes.largestIconSize,),
//       //     BaseText('Login to access this resource',fontWeight: FontWeight.w600,fontSize: TextSizes.textSize16SP,),
//       //     Padding(
//       //       padding: EdgeInsets.symmetric(horizontal: Spacings.spacing40.w),
//       //       child: MainButton(
//       //         text: 'Login',
//       //         buttonColor: black,
//       //         textColor: white,
//       //         press: () {
//       //           Navigator.pushAndRemoveUntil(
//       //             context,
//       //             MaterialPageRoute(builder: (context) => SignUpPage()),
//       //             (route) => false,
//       //           );
//       //         },
//       //       ),
//       //     )
//       //   ],
//       // ),
//       //     );
//         // Padding(
//         //   padding:  EdgeInsets.only(bottom: 57.h),
//         //   child: Container(
//         //     child:LoginPage(),
//         //   ),
//         // );
//       showCustomModalBottomSheet(context);
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => LoginPage()),
//         // );
//         return [];
//       }
//       if (userId.toString().isEmpty) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => LoginPage()), (route) => false,
//         );
//         return []; // Exit early if not authenticated
//       }