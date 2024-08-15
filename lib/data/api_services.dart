import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mime/mime.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/models/all_applications_response_model.dart';
import 'package:nitoons/models/all_comments_model.dart';
import 'package:nitoons/models/all_endorsements_model.dart';
import 'package:nitoons/models/all_open_roles_model.dart';
import 'package:nitoons/models/application_project_model.dart';
import 'package:nitoons/models/application_role_model.dart';
import 'package:nitoons/models/conversation_message_model.dart';
import 'package:nitoons/models/conversations_model.dart';
import 'package:nitoons/models/endorsement_model.dart';
import 'package:nitoons/models/file_upload_model.dart';
import 'package:nitoons/models/follow_user_model.dart';
import 'package:nitoons/models/get_timeline_posts_model.dart';
import 'package:nitoons/models/invitation_model.dart';
import 'package:nitoons/models/logout_model.dart';
import 'package:nitoons/models/message_model.dart';
import 'package:nitoons/models/post_model.dart';
import 'package:nitoons/models/project_model.dart';
import 'package:nitoons/models/request_password_reset_email.dart';
import 'package:nitoons/models/reset_password_model.dart';
import 'package:nitoons/models/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../models/finalize_signup_model.dart';
import '../models/get_user_profile_model.dart';
import '../models/initiate_signup_model.dart';
import '../models/like_model.dart';
import '../models/login_model.dart';
import '../models/make_comment_model.dart';
import '../models/monologue_script_model.dart';
import '../models/producer_conversation_model.dart';
import '../models/token_model.dart';
import '../models/upload_post_model.dart';
import '../models/validate_signup_otp_model.dart';
import '../utilities/api_status_response.dart';
import '../utilities/api_urls.dart';
import '../utilities/app_util.dart';
import 'api_layer.dart';

final apiServiceProvider = Provider((ref) => ApiServices());

class ApiServices {
  // late String userEmail;
  // late String userPhoneNumber;
  // late String emailConfirmationId;
  // late String phoneConfirmationId;

  // Future<InitiateSignUpModel> getVerificationCode(String email) async {
  //   late InitiateSignUpModel initiateSignUpModel;
  //
  //   final response = await http.post(
  //     Uri.https(baseUrl, '/v1/api/users/onboarding/signup/email/initiate'),
  //     body: ({"email": email}),
  //     headers: {'Accept': 'application/json'},
  //   );
  //
  //   try {
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       final data = json.decode(response.body);
  //       final message = data['message'];
  //       initiateSignUpModel = InitiateSignUpModel.fromJson(data);
  //       Fluttertoast.showToast(msg: message);
  //     }
  //     else {
  //       final data = json.decode(response.body);
  //       final message = data['message'];
  //       Fluttertoast.showToast(msg: message);
  //     }
  //     return initiateSignUpModel;
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception(e);
  //   }
  // }

  Future<InitiateSignUpModel> getVerificationCodeEmail(String email) async {
    late InitiateSignUpModel initiateSignUpModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.initiateSignUpEmail,
        method: HttpMethod.post,
        body: {"email": email},
      );

      await SharedPreferencesHelper.storeUserEmail(email);

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        initiateSignUpModel = InitiateSignUpModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return initiateSignUpModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<ValidateOtpModel> validateSignUpOtpEmail(String otp) async {
    late ValidateOtpModel validateOtpModel;
    try {
      final userEmail = await SharedPreferencesHelper.getUserEmail();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.validateSignUpOtpEmail,
        method: HttpMethod.post,
        body: {"email": userEmail, "otp": otp},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        final emailConfirmationId = data['data']['confirmationId'];
        await SecureStorageHelper.storeConfirmationId(emailConfirmationId);
        AppUtils.debug(message);
        validateOtpModel = ValidateOtpModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return validateOtpModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<FinalizeSignUpModel> signUserUpEmail(String password) async {
    late FinalizeSignUpModel finalizeSignUpModel;

    try {
      final userEmail = await SharedPreferencesHelper.getUserEmail();
      final emailConfirmationId = await SecureStorageHelper.getConfirmationId();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.finalizeSignUpEmail,
        method: HttpMethod.post,
        body: {
          "confirmationId": emailConfirmationId,
          "password": password,
          "email": userEmail,
        },
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        finalizeSignUpModel = FinalizeSignUpModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return finalizeSignUpModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<InitiateSignUpModel> getVerificationCodePhone(
      String phoneNumber) async {
    late InitiateSignUpModel initiateSignUpModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.initiateSignUpPhone,
        method: HttpMethod.post,
        body: {"phone_number": phoneNumber},
      );

      await SharedPreferencesHelper.storeUserPhoneNumber(phoneNumber);

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        initiateSignUpModel = InitiateSignUpModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return initiateSignUpModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<ValidateOtpModel> validateSignUpOtpPhone(String otp) async {
    late ValidateOtpModel validateOtpModel;
    try {
      final userPhoneNumber =
          await SharedPreferencesHelper.getUserPhoneNumber();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.validateSignUpOtpEmail,
        method: HttpMethod.post,
        body: {"phone_number": userPhoneNumber, "otp": otp},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        final phoneConfirmationId = data['data']['confirmationId'];
        await SecureStorageHelper.storeConfirmationId(phoneConfirmationId);
        AppUtils.debug(message);
        validateOtpModel = ValidateOtpModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return validateOtpModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<FinalizeSignUpModel> signUserUpPhone(String password) async {
    late FinalizeSignUpModel finalizeSignUpModel;
    try {
      final userPhoneNumber =
          await SharedPreferencesHelper.getUserPhoneNumber();
      final phoneConfirmationId = await SecureStorageHelper.getConfirmationId();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.finalizeSignUpPhone,
        method: HttpMethod.post,
        body: {
          "phone_number": userPhoneNumber,
          "confirmationId": phoneConfirmationId,
          "password": password
        },
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        finalizeSignUpModel = FinalizeSignUpModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return finalizeSignUpModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<LoginModel> loginEmail(
      {required String email, required String password}) async {
    late LoginModel loginModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.loginEmail,
        method: HttpMethod.post,
        body: {"email": email, "password": password},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        final accessToken = data['data']['tokens']['accessToken'];
        await SecureStorageHelper.storeAccessToken(accessToken);
        AppUtils.debug(message);
        loginModel = LoginModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        loginModel = LoginModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return loginModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<LoginModel> loginPhone(
      {required String phone, required String password}) async {
    late LoginModel loginModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.loginPhone,
        method: HttpMethod.post,
        body: {"phone_number": phone, "password": password},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        loginModel = LoginModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return loginModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<LogoutModel> logout() async {
    late LogoutModel logoutModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.logout,
        method: HttpMethod.post,
        body: {"refreshToken": " "}, //TODO: complete refresh token
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        logoutModel = LogoutModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return logoutModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<TokenModel> refreshToken() async {
    late TokenModel tokenModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.refreshToken,
        method: HttpMethod.post,
        body: {"refreshToken": " "}, //TODO: complete refresh token
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        tokenModel = TokenModel.fromJson(data);
      } else if (response is Failure) {
        AppUtils.debug('Something went wrong');
      }
      return tokenModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<RequestPasswordResetModel> requestPasswordResetEmail(
      String email) async {
    late RequestPasswordResetModel requestPasswordResetModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.requestPasswordResetEmail,
        method: HttpMethod.post,
        body: {"email": email},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        requestPasswordResetModel = RequestPasswordResetModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        AppUtils.debug(message);
        Fluttertoast.showToast(msg: message);
        AppUtils.debug('logged error message');
        requestPasswordResetModel = RequestPasswordResetModel.fromJson(data);
      }
      return requestPasswordResetModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<ValidateOtpModel> validatePasswordResetOtpEmail(String otp) async {
    late ValidateOtpModel validateOtpModel;
    try {
      final userEmail = await SharedPreferencesHelper.getUserEmail();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.validatePasswordResetOtpEmail,
        method: HttpMethod.post,
        body: {"email": userEmail, "otp": otp},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        final emailConfirmationId = data['data']['confirmationId'];
        await SecureStorageHelper.storeConfirmationId(emailConfirmationId);
        AppUtils.debug(message);
        validateOtpModel = ValidateOtpModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
        validateOtpModel = ValidateOtpModel.fromJson(data);
      }
      return validateOtpModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<ResetPasswordModel> resetPasswordEmail(String password) async {
    late ResetPasswordModel resetPasswordModel;

    try {
      final userEmail = await SharedPreferencesHelper.getUserEmail();
      final emailConfirmationId = await SecureStorageHelper.getConfirmationId();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.resetPasswordEmail,
        method: HttpMethod.post,
        body: {
          "email": userEmail,
          "password": password,
          "confirmationId": emailConfirmationId
        },
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        final emailConfirmationId = data['data']['confirmationId'];
        await SecureStorageHelper.storeConfirmationId(emailConfirmationId);
        AppUtils.debug(message);
        resetPasswordModel = ResetPasswordModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return resetPasswordModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<RequestPasswordResetModel> requestPasswordResetPhone(
      String phoneNumber) async {
    late RequestPasswordResetModel requestPasswordResetModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.requestPasswordResetPhone,
        method: HttpMethod.post,
        body: {"phone_number": phoneNumber},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        requestPasswordResetModel = RequestPasswordResetModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        AppUtils.debug(message);
        Fluttertoast.showToast(msg: message);
      }
      return requestPasswordResetModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<ValidateOtpModel> validatePasswordResetOtpPhone(String otp) async {
    late ValidateOtpModel validateOtpModel;
    try {
      final userPhoneNumber =
          await SharedPreferencesHelper.getUserPhoneNumber();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.validatePasswordResetOtpEmail,
        method: HttpMethod.post,
        body: {"phone_number": userPhoneNumber, "otp": otp},
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        final phoneConfirmationId = data['data']['confirmationId'];
        await SecureStorageHelper.storeConfirmationId(phoneConfirmationId);
        AppUtils.debug(message);
        validateOtpModel = ValidateOtpModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return validateOtpModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<ResetPasswordModel> resetPasswordPhone(String password) async {
    late ResetPasswordModel resetPasswordModel;

    try {
      final userPhoneNumber =
          await SharedPreferencesHelper.getUserPhoneNumber();
      final emailConfirmationId = await SecureStorageHelper.getConfirmationId();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.resetPasswordPhone,
        method: HttpMethod.post,
        body: {
          "phone_number": userPhoneNumber,
          "password": password,
          "confirmationId": emailConfirmationId
        },
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        final phoneConfirmationId = data['data']['confirmationId'];
        await SecureStorageHelper.storeConfirmationId(phoneConfirmationId);
        AppUtils.debug(message);
        resetPasswordModel = ResetPasswordModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return resetPasswordModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  // Future<CreateUserProfileModel> createUserProfile(String skinType) async {
  //   late CreateUserProfileModel createUserProfileModel;

  //   try {
  //     final userId = await SecureStorageHelper.getUserId();
  //     final profession = await SharedPreferencesHelper.getProfession();
  //     final firstName = await SharedPreferencesHelper.getFirstName();
  //     final lastName = await SharedPreferencesHelper.getLastName();
  //     final actualAge = await SharedPreferencesHelper.getActualAge();
  //     final playableAge = await SharedPreferencesHelper.getPlayableAge();
  //     final gender = await SharedPreferencesHelper.getGender();

  //     final response = await ApiLayer.makeApiCall(
  //       ApiUrls.createUserProfile,
  //       method: HttpMethod.post,
  //       requireAccess: true,
  //       userAccessToken: await SecureStorageHelper.getAccessToken(),
  //       body: {
  //         "user_id": userId,
  //         "profession": profession,
  //         "first_name": firstName,
  //         "last_name": lastName,
  //         "actual_age": actualAge,
  //         "playable_age": playableAge,
  //         "gender": gender,
  //         "skin_type": skinType,
  //       },
  //     );
  //     print(
  //         "user_id: $userId, profession: $profession,  first_name: $firstName, last_name: $lastName, actual_age: $actualAge, playable_age: $playableAge, gender: $gender, skin_type: $skinType,");

  //     if (response is Success) {
  //       AppUtils.debug(response.body);
  //       final data = json.decode(response.body);
  //       final message = data['message'];
  //       final userId = data['data']['userId'];
  //       await SecureStorageHelper.storeUserId(userId);
  //       AppUtils.debug(message);
  //       createUserProfileModel = CreateUserProfileModel.fromJson(data);
  //       // Fluttertoast.showToast(msg: message);
  //     } else if (response is Failure) {
  //       final data = json.decode(response.errorResponse);
  //       final message = data['message'];
  //       createUserProfileModel = CreateUserProfileModel.fromJson(data);
  //       AppUtils.debug(message);
  //     }
  //     return createUserProfileModel;
  //   } catch (e) {
  //     AppUtils.debug(e.toString());
  //     print(e);
  //     throw Exception(e);
  //   }
  // }

  Future<UserProfileModel> updateUserProfile(
      {String? firstName, String? lastName}) async {
    late UserProfileModel userProfileModel;

    try {
      final userId = await SecureStorageHelper.getUserId();
      final response = await ApiLayer.makeApiCall(ApiUrls.updateUserProfile,
          method: HttpMethod.post,
          body: {
            "user_id": userId,
            "updates": {"first_name": firstName, "last_name": lastName}
          });

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        userProfileModel = UserProfileModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return userProfileModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }
Future<UserProfileModel> updatePrefferedRoleProfile(
      {String? firstName, String? lastName}) async {
    late UserProfileModel userProfileModel;

    try {
      final userId = await SecureStorageHelper.getUserId();
      final response = await ApiLayer.makeApiCall(ApiUrls.updateUserProfile,
          method: HttpMethod.post,
          body: {
            "user_id": userId,
            "updates": {
              "preferred_roles": firstName,
               "last_name": lastName
               }
          });

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        userProfileModel = UserProfileModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return userProfileModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<GetUserProfileModel> getUserProfile(String profileId) async {
    late GetUserProfileModel userProfileModel;

    try {
      final accessToken = await SecureStorageHelper.getAccessToken();
      final userId = await SecureStorageHelper.getUserId();
      final response = await ApiLayer.makeApiCall(ApiUrls.getUserProfile+profileId,
      requireAccess: true,
          method: HttpMethod.get,
           userAccessToken: accessToken,
           );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        userProfileModel = GetUserProfileModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return userProfileModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<EndorsementModel> createEndorsement(String review, int rating) async {
    late EndorsementModel endorsementModel;

    try {
      final userId = await SecureStorageHelper.getUserId();

      final response = await ApiLayer.makeApiCall(ApiUrls.createEndorsements,
          method: HttpMethod.post,
          body: {"endorsedUser": userId, "comment": review, "rating": rating},
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken());

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        endorsementModel = EndorsementModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
      return endorsementModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<AllEndorsementsModel> getAllEndorsements() async {
    late AllEndorsementsModel allEndorsementsModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.getAllEndorsements,
          method: HttpMethod.get,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken());

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        allEndorsementsModel = AllEndorsementsModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        allEndorsementsModel = AllEndorsementsModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return allEndorsementsModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<FollowUserModel> followUser() async {
    late FollowUserModel followUserModel;

    try {
      final userId = await SecureStorageHelper.getUserId();
      final response = await ApiLayer.makeApiCall(ApiUrls.followUser,
          method: HttpMethod.post,
          body: {"userId": userId},
          userAccessToken: await SecureStorageHelper.getAccessToken());

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        followUserModel = FollowUserModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        followUserModel = FollowUserModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return followUserModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<FollowUserModel> unfollowUser() async {
    late FollowUserModel followUserModel;

    try {
      final userId = await SecureStorageHelper.getUserId();

      final response = await ApiLayer.makeApiCall(ApiUrls.unfollowUser,
          method: HttpMethod.post,
          body: {"userId": userId},
          userAccessToken: await SecureStorageHelper.getAccessToken());

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        followUserModel = FollowUserModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        followUserModel = FollowUserModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return followUserModel;
    } catch (e) {
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<GetTimePostsModel> getTimelinePosts() async {
    late GetTimePostsModel getTimePostsModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.getTimelinePosts,
          method: HttpMethod.get,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken());

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        getTimePostsModel = GetTimePostsModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        getTimePostsModel = GetTimePostsModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      }
      return getTimePostsModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<PostsModel> createPost(String description, String media) async {
    late PostsModel postsModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.createPosts,
          method: HttpMethod.post,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),
          body: {"description": description, "mediaUpload": media});

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        postsModel = PostsModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        postsModel = PostsModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return postsModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<UploadPostResponse> uploadPostMedia(File file) async {
    late UploadPostResponse uploadPostResponse;

    http.MultipartRequest? request;
    http.StreamedResponse? response;

    try {
      final url = Uri.https(ApiUrls.baseUrl, ApiUrls.uploadMedia);
      request = new http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer ${await SecureStorageHelper.getAccessToken()}';
      final fileStream = file.openRead();
      final fileLength = await file.length();
      final mimeType = lookupMimeType(file.path);
      request.files.add(
        await http.MultipartFile(
          'file',
          fileStream,
          fileLength,
          contentType: MediaType.parse(mimeType!),
          filename: basename(file.path),
        ),
      );

      response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        Fluttertoast.showToast(msg: 'File uploaded successfully. Response code: ${response.statusCode}');

        final data = json.decode(responseString);
        final message = data['message'];
        AppUtils.debug(message);
        uploadPostResponse = UploadPostResponse.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else {
        final data = json.decode(responseString);
        final message = data['message'];
        uploadPostResponse = UploadPostResponse.fromJson(data);
        print('File upload failed with status: ${response.statusCode}');
        print('Response body: $responseString');
        Fluttertoast.showToast(msg: message);
      }
      return uploadPostResponse;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }



  Future<ProducerConversationsModel> getProducerConversations() async {
    late ProducerConversationsModel producerConversationsModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getUserConversations,
        // baseUrl: ApiUrls.testBaseUrl,
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );
      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        print('response ti de oo ${response.body}');
        // final conversationId = data['data']['results']['id'];
        AppUtils.debug(message);
        producerConversationsModel = ProducerConversationsModel.fromJson(data);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        producerConversationsModel = ProducerConversationsModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return producerConversationsModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<ConversationsModel> getConversations() async {
    late ConversationsModel conversationsModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getUserConversations,
        // baseUrl: ApiUrls.testBaseUrl,
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );
      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        // final conversationId = data['data']['results']['id'];
        AppUtils.debug(message);
        conversationsModel = ConversationsModel.fromJson(data);
        // final conversationIds =
        //     conversationsModel.data.results!.map((result) => result.id).toList();
        // await SecureStorageHelper.storeConversationIds(conversationIds);
        // print(conversationIds);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        conversationsModel = ConversationsModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return conversationsModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<ConversationMessageModel> getConversationMessages(
      String conversationId) async {
    late ConversationMessageModel conversationMessageModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getUserConversationMessages(conversationId),
        // baseUrl: ApiUrls.testBaseUrl,
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );
      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        // final conversationId = data['data']['results']['id'];
        AppUtils.debug(message);
        conversationMessageModel = ConversationMessageModel.fromJson(data);

        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        conversationMessageModel = ConversationMessageModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return conversationMessageModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  // Future<MessageModel> sendMessage(
  //     String message, String conversationId) async {
  //   late MessageModel messageModel;
  //
  //   try {
  //     final response = await ApiLayer.makeApiCall(ApiUrls.sendMessage,
  //         method: HttpMethod.post,
  //         requireAccess: true,
  //         userAccessToken: await SecureStorageHelper.getAccessToken(),
  //         body: {"message": message, "conversationId": conversationId});
  //
  //     if (response is Success) {
  //       AppUtils.debug(response.body);
  //       final data = json.decode(response.body);
  //       final message = data['message'];
  //       AppUtils.debug(message);
  //       messageModel = MessageModel.fromJson(data);
  //       // Fluttertoast.showToast(msg: message);
  //     } else if (response is Failure) {
  //       final data = json.decode(response.errorResponse);
  //       final message = data['message'];
  //       messageModel = MessageModel.fromJson(data);
  //       Fluttertoast.showToast(msg: message);
  //     }
  //     return messageModel;
  //   } catch (e) {
  //     print(e);
  //     AppUtils.debug(e.toString());
  //     throw Exception(e);
  //   }
  // }

  Future<Map<String, dynamic>> sendMessage(
      String message, String conversationId) async {
    final fireStore = FirebaseFirestore.instance;
    // late MessageModel messageModel;

    try {
      final docRef = fireStore.collection('conversations/$conversationId/messages').doc();
final userId = await SecureStorageHelper.getUserId();

      Map<String, dynamic> messageData = {
        'text': message,
        'senderId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await docRef.set(messageData);

      // method: HttpMethod.post,
      //     requireAccess: true,
      //     userAccessToken: await SecureStorageHelper.getAccessToken(),
      //     body: {"message": message, "conversationId": conversationId});

      return {
        'success': true,
        'data': {...messageData, 'id': docRef.id},
      };
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      return {'success': false, 'errorMessage': e.toString()};
    }
  }

  Future<bool> createNewApplicationRoleId(
      String roleId, String media) async {
    http.MultipartRequest? request;
    http.StreamedResponse? response;

    try {
      final url = Uri.https(ApiUrls.baseUrl, ApiUrls.createNewApplicationRoleId);
      request = new http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer ${await SecureStorageHelper.getAccessToken()}';
      // request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['role_id'] = roleId;
      final file = File(media);
      final fileStream = file.openRead();
      final fileLength = await file.length();
      final mimeType = lookupMimeType(media);
      request.files.add(
        http.MultipartFile(
          'monologue_post',
          fileStream,
          fileLength,
          contentType: MediaType.parse(mimeType!),
          filename: basename(media),
        ),
      );

      // final response = await ApiLayer.makeApiCall(
      //     ApiUrls.createNewApplicationRoleId,
      //     method: HttpMethod.post,
      //     requireAccess: true,
      //     userAccessToken: await SecureStorageHelper.getAccessToken(),
      //     body: {"project_id": projectId, "monologue_post": media});

     response = await request.send();
      // final responseBody = await response.stream.bytesToString();
      // print('Full response: $responseBody');
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);



      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'File uploaded successfully. Response code: ${response.statusCode}');

        print('File uploaded successfully');
        print('Response code: ${response.statusCode}');
         print(responseString);
         return true;
      } else {
        Fluttertoast.showToast(msg: 'Failed to upload: ${responseString}');
        print("Failed to upload. Status code: ${response.statusCode}");
        print(responseString);
        return false;
        // throw HttpException('Failed to upload. Status code: ${response.statusCode}. Response: $responseString');
      }
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
    // finally {
    //   // request?.finalize();
    //   response?.stream.drain();
    // }
  }

  // Future<ApplicationProjectResponseModel> createNewApplicationProjectId(
  //     String projectId, String media) async {
  //   late ApplicationProjectResponseModel applicationProjectResponseModel;
  //
  //   try {
  //     final url = Uri.https(ApiUrls.baseUrl, ApiUrls.createNewApplicationRoleId);
  //     final request = new http.MultipartRequest('POST', url);
  //     request.headers['Authorization'] = 'Bearer ${await SecureStorageHelper.getAccessToken()}';
  //     request.headers['Content-Type'] = 'multipart/form-data';
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'application_monologue_post',
  //         media, contentType: MediaType('video', 'mp4'),
  //         filename: basename(media),
  //       ),
  //     );
  //
  //     // final response = await ApiLayer.makeApiCall(
  //     //     ApiUrls.createNewApplicationRoleId,
  //     //     method: HttpMethod.post,
  //     //     requireAccess: true,
  //     //     userAccessToken: await SecureStorageHelper.getAccessToken(),
  //     //     body: {"project_id": projectId, "monologue_post": media});
  //
  //
  //
  //     if (response is Success) {
  //       AppUtils.debug(response.body);
  //       final data = json.decode(response.body);
  //       final message = data['message'];
  //       AppUtils.debug(message);
  //       applicationProjectResponseModel =
  //           ApplicationProjectResponseModel.fromJson(data);
  //       Fluttertoast.showToast(msg: message);
  //     } else if (response is Failure) {
  //       final data = json.decode(response.errorResponse);
  //       final message = data['message'];
  //       applicationProjectResponseModel =
  //           ApplicationProjectResponseModel.fromJson(data);
  //       Fluttertoast.showToast(msg: message);
  //     }
  //     return applicationProjectResponseModel;
  //   } catch (e) {
  //     print(e);
  //     AppUtils.debug(e.toString());
  //     throw Exception(e);
  //   }
  // }

  Future<ApplicationRoleResponseModel> createNewApplicationRolesId(
      String roleId, String media) async {
    late ApplicationRoleResponseModel applicationRoleResponseModel;

    try {
      final response = await ApiLayer.makeApiCall(
          ApiUrls.createNewApplicationRoleId,
          method: HttpMethod.post,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),
          body: {"role_id": roleId, "monologue_post": media});

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        applicationRoleResponseModel =
            ApplicationRoleResponseModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        applicationRoleResponseModel =
            ApplicationRoleResponseModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return applicationRoleResponseModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<AllApplicationsResponseModel> getAllApplicationsActorId() async {
    late AllApplicationsResponseModel allApplicationsResponseModel;

    final actorId = await SecureStorageHelper.getUserId();
    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getAllApplicationsActorId(actorId!),
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        allApplicationsResponseModel =
            AllApplicationsResponseModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        allApplicationsResponseModel =
            AllApplicationsResponseModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return allApplicationsResponseModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<AllApplicationsResponseModel> getAllApplicationsProjectId() async {
    late AllApplicationsResponseModel allApplicationsResponseModel;

    final projectId = '';
    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getAllApplicationsProjectId(projectId),
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        allApplicationsResponseModel =
            AllApplicationsResponseModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        allApplicationsResponseModel =
            AllApplicationsResponseModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return allApplicationsResponseModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<AllApplicationsResponseModel> getAllApplicationsRoleId() async {
    late AllApplicationsResponseModel allApplicationsResponseModel;

    final roleId = '';
    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getAllApplicationsRoleId(roleId),
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        allApplicationsResponseModel =
            AllApplicationsResponseModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        allApplicationsResponseModel =
            AllApplicationsResponseModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return allApplicationsResponseModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<AllOpenRolesModel> getAllOpenRoles() async {
    late AllOpenRolesModel allOpenRolesModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getAllOpenRoles,
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        allOpenRolesModel = AllOpenRolesModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        allOpenRolesModel = AllOpenRolesModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      }
      return allOpenRolesModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<ProjectModel> getProject(String projectId) async {
    late ProjectModel projectModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getProject(projectId),
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        projectModel = ProjectModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        projectModel = ProjectModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return projectModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<InvitationModel> getAllInvitations() async {
    late InvitationModel invitationModel;

    final actorId = await SecureStorageHelper.getUserId();

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getAllInvitations(actorId),
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        invitationModel = InvitationModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        invitationModel = InvitationModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return invitationModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<CommentsResponseModel> getAllComments(String postId) async {
    late CommentsResponseModel commentsResponseModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getAllComments(postId),
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        commentsResponseModel = CommentsResponseModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        commentsResponseModel = CommentsResponseModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return commentsResponseModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<MakeCommentModel> makeComment(String postId, String comment) async {
    late MakeCommentModel makeCommentModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.makeComment,
          method: HttpMethod.post,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),
          body: {
            "userId": await SecureStorageHelper.getUserId(),
            "postId": postId,
            "comment": comment,
          });

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        makeCommentModel = MakeCommentModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        makeCommentModel = MakeCommentModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return makeCommentModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }
  Future<LikeModel> likePost(String postId) async {
    late LikeModel likeModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.likePost(postId),
          method: HttpMethod.post,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),);


      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        likeModel = LikeModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        likeModel = LikeModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return likeModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<LikeModel> unlikePost(String postId) async {
    late LikeModel likeModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.unlikePost(postId),
          method: HttpMethod.post,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),);


      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        likeModel = LikeModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        likeModel = LikeModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return likeModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }


  Future<LikeModel> likeComment(String commentId) async {
    late LikeModel likeModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.likeComment,
          method: HttpMethod.put,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),
          body: {
            "commentId": commentId
          });

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        likeModel = LikeModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        likeModel = LikeModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return likeModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }


  Future<LikeModel> unlikeComment(String commentId) async {
    late LikeModel likeModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.unlikeComment,
          method: HttpMethod.put,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),
          body: {
            "commentId": commentId
          });

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        likeModel = LikeModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        likeModel = LikeModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return likeModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }
  Future<LikeModel> likeReply(String commentId, String replyId) async {
    late LikeModel likeModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.likeReply,
          method: HttpMethod.put,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),
          body: {
            "commentId": commentId,
            "replyId": replyId
          });

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        likeModel = LikeModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        likeModel = LikeModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return likeModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

  Future<LikeModel> unlikeReply(String commentId, String replyId) async {
    late LikeModel likeModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.unlikeReply,
          method: HttpMethod.put,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),
          body: {
            "commentId": commentId,
            "replyId": replyId
          });

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        likeModel = LikeModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        likeModel = LikeModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return likeModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }


  Future<MakeCommentModel> addReply(String commentId, String reply) async {
    late MakeCommentModel makeCommentModel;

    try {
      final response = await ApiLayer.makeApiCall(ApiUrls.replyComment,
          method: HttpMethod.post,
          requireAccess: true,
          userAccessToken: await SecureStorageHelper.getAccessToken(),
          body: {
            "userId": await SecureStorageHelper.getUserId(),
            "commentId": commentId,
            "reply": reply,
          });

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        makeCommentModel = MakeCommentModel.fromJson(data);
        // Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        makeCommentModel = MakeCommentModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return makeCommentModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }


  Future<MonologueScriptModel> getMonologueScriptProjectId(String projectId) async {
    late MonologueScriptModel monologueScriptModel;

    try {
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getMonologueScriptProjectId(projectId),
        method: HttpMethod.get,
        requireAccess: true,
        userAccessToken: await SecureStorageHelper.getAccessToken(),
      );

      if (response is Success) {
        AppUtils.debug(response.body);
        final data = json.decode(response.body);
        final message = data['message'];
        AppUtils.debug(message);
        monologueScriptModel =
            MonologueScriptModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        monologueScriptModel =
            MonologueScriptModel.fromJson(data);
        Fluttertoast.showToast(msg: message);
      }
      return monologueScriptModel;
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      throw Exception(e);
    }
  }

}
