import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../UI Actor/home_page.dart';
import '../../../data/api_layer.dart';
import '../../../data/app_storage.dart';
import '../../../utilities/api_urls.dart';

class FilmmakerProfileEditViewmodel extends ViewModel {
  bool isButtonActive = false;
 final producerFilmMakerFormKey = GlobalKey<FormState>();
  late TextEditingController filmmakerprofileController;

  @override
  void init() {
    // TODO: implement init
    super.init();

    filmmakerprofileController = TextEditingController();
    filmmakerprofileController.addListener(() {
      final newIsButtonActive = filmmakerprofileController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    filmmakerprofileController.dispose();
  }

  textClear() {
    filmmakerprofileController.clear();
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
      final accesstoken = await SecureStorageHelper.getAccessToken();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
        body: {
          "updateData": {
            "film_maker_profile": filmmakerprofileController.text.trim().toString(),
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
        Fluttertoast.showToast(msg: message);
        print(Fluttertoast.showToast(msg: message));
        SecureStorageHelper.storeUserId(userId);
        textClear();
         Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => ProducerHomePage()));
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
      Fluttertoast.showToast(msg: 'An error occurred: $e');
      print(Fluttertoast.showToast(msg: 'An error occurred: $e'));
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }

}
