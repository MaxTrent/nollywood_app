// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pmvvm/pmvvm.dart';
// import 'package:nitoons/data/api_layer.dart';
// import 'package:nitoons/data/app_storage.dart';
// import 'package:nitoons/models/get_user_profile_model.dart';
// import 'package:nitoons/models/follow_user_model.dart';
// import 'package:nitoons/utilities/api_status_response.dart';
// import 'package:nitoons/utilities/api_urls.dart';
// import 'package:nitoons/utilities/app_util.dart';

// class ProducerProfileVm extends ViewModel {
//   String? profileId;
//   GetUserProfileModel? getUserProfileModel;
//   bool _isFollowing = false; // Track follow state

//   ProducerProfileVm();

//   void setProfileId(String profileId) {
//     this.profileId = profileId;
//     fetchUserProfile(profileId);
//   }

//   Future<GetUserProfileModel?> fetchUserProfile(String profileId) async {
//     try {
//       final accessToken = await SecureStorageHelper.getAccessToken();
//       final response = await ApiLayer.makeApiCall(
//         ApiUrls.getUserProfile + profileId,
//         requireAccess: true,
//         method: HttpMethod.get,
//         userAccessToken: accessToken,
//       );

//       if (response is Success) {
//         final data = json.decode(response.body);
//         final profileModel = GetUserProfileModel.fromJson(data);
//         getUserProfileModel = profileModel;
//         // Example logic to set follow state based on profile data
//         _isFollowing = profileModel.data?.isFollowing ?? false;
//         notifyListeners();
//         return profileModel;
//       } else if (response is Failure) {
//         final data = json.decode(response.errorResponse);
//         final message = data['message'];
//         Fluttertoast.showToast(msg: message);
//       }
//     } catch (e) {
//       AppUtils.debug(e.toString());
//     }
//     return null;
//   }

//   // Follow user functionality
//   bool get isFollowing => _isFollowing;

//   Future<void> clickFollowButton() async {
//     if (_isFollowing) {
//       await unfollowUser();
//     } else {
//       await followUser();
//     }
//   }

//   Future<void> followUser() async {
//     try {
//       final userId = await SecureStorageHelper.getUserId();
//       final accessToken = await SecureStorageHelper.getAccessToken();

//       final response = await ApiLayer.makeApiCall(
//         ApiUrls.followUser,
//         method: HttpMethod.post,
//         body: {"userId": userId},
//         userAccessToken: accessToken,
//       );

//       if (response is Success) {
//         final data = json.decode(response.body);
//         final message = data['message'];
//         final followUserModel = FollowUserModel.fromJson(data);
//         _isFollowing = true;
//         notifyListeners();
//         Fluttertoast.showToast(msg: message);
//       } else if (response is Failure) {
//         final data = json.decode(response.errorResponse);
//         final message = data['message'];
//         final followUserModel = FollowUserModel.fromJson(data);
//         Fluttertoast.showToast(msg: message);
//       }
//     } catch (e) {
//       AppUtils.debug(e.toString());
//       throw Exception(e);
//     }
//   }

//   Future<void> unfollowUser() async {
//     try {
//       final userId = await SecureStorageHelper.getUserId();
//       final accessToken = await SecureStorageHelper.getAccessToken();

//       final response = await ApiLayer.makeApiCall(
//         ApiUrls.unfollowUser,
//         method: HttpMethod.post,
//         body: {"userId": userId},
//         userAccessToken: accessToken,
//       );

//       if (response is Success) {
//         final data = json.decode(response.body);
//         final message = data['message'];
//         final followUserModel = FollowUserModel.fromJson(data);
//         _isFollowing = false;
//         notifyListeners();
//         Fluttertoast.showToast(msg: message);
//       } else if (response is Failure) {
//         final data = json.decode(response.errorResponse);
//         final message = data['message'];
//         final followUserModel = FollowUserModel.fromJson(data);
//         Fluttertoast.showToast(msg: message);
//       }
//     } catch (e) {
//       AppUtils.debug(e.toString());
//       throw Exception(e);
//     }
//   }
// }
