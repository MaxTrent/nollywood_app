
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/data/api_layer.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../UI Actor/home_page.dart';


class CompanyInfoEditViewmodel extends ViewModel{
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
bool isButtonActive = false;

  late TextEditingController companynameController;
  late TextEditingController companyemailController;
  late TextEditingController companyphonenumberController;
@override
  void init() {
    // TODO: implement init
    super.init();
    
    companynameController = TextEditingController();
    companyemailController = TextEditingController();
    companyphonenumberController = TextEditingController();
    
    
    companynameController.addListener(() {
      final newIsButtonActive = companynameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
     companyemailController.addListener(() {
      final newIsButtonActive = companyemailController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    companyphonenumberController.addListener(() {
      final newIsButtonActive = companyphonenumberController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    
  }

  
  @override
  void dispose() {
    companynameController.dispose();
    companyemailController.dispose();
    companyphonenumberController.dispose();
    super.dispose();
    notifyListeners();
  }
 void textClear(){
  
    companynameController.clear();
    companyemailController.clear();
    companyphonenumberController.clear();
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
          "company_name":companynameController.text.trim().toString(),
           "company_email":companyemailController.text.trim().toString(),
            "company_phone_number":companyphonenumberController.text.trim().toString(),
             
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