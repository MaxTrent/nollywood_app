
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:path/path.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';

class SideshotVm extends ViewModel{

   bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  // Method to make a POST API call
  // Future<void> submitSideShotData(image) async {
  //   setLoadingState();
  //   try {
  //     final homePagePath = await SharedPreferencesHelper.getUserHomePage();
      
  //     final accesstoken = await SecureStorageHelper.getAccessToken();
  //     final response = await ApiLayer.makeApiCall(
  //       ApiUrls.updateUserProfile,
  //       method: HttpMethod.post,
  //       requireAccess: true,
  //       body: {
  //         "updateData": {
  //           "side_headshot": image.toString()
  //         },
  //       },
  //       userAccessToken: accesstoken,
  //     );

  //     // print(userId);

  //     print(accesstoken);
  //     if (response is Success) {
  //       final data = json.decode(response.body);
  //       final message = data['message'];
  //       final userId = data['data']['user_id'];
  //       print(response.code);
  //       print(response.body);
  //       print(response);
  //       Fluttertoast.showToast(msg: message);
  //       print(Fluttertoast.showToast(msg: message));
  //       SecureStorageHelper.storeUserId(userId);
        
  //         if (homePagePath != null) {
  //         Navigator.pushReplacementNamed(context, homePagePath);
  //       }
  //     } else if (response is Failure) {
  //       final data = json.decode(response.errorResponse);
  //       print(response.code);
  //       print(data);
  //       print(response.errorResponse);
  //       final message = data['message'];
  //       Fluttertoast.showToast(msg: message);
  //       print('toast${Fluttertoast.showToast(msg: message)}');
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'An error occurred: $e');
  //     print(Fluttertoast.showToast(msg: 'An error occurred: $e'));
  //   } finally {
  //     setLoadingState();
  //     notifyListeners();
  //   }
  // }

Future<void> submitSideShotData(image) async {
    setLoadingState();
       final homePagePath = await SharedPreferencesHelper.getUserHomePage();    
     final accessToken = await SecureStorageHelper.getAccessToken();
    try {
        var url = Uri.parse(
            'https://${ApiUrls.baseUrl}${ApiUrls.updateUserImages}');
        final request = new http.MultipartRequest('PUT', url);

       Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      };
      request.headers.addAll(headers);
      String? mimeType = lookupMimeType(image!.path);
      request.files.add(
        await http.MultipartFile.fromPath(
          'side_headshot',
          image!.path,
          filename: basename(image!.path),
          contentType: MediaType.parse(mimeType!),
        ),
      );
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          print('File uploaded successfully');
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);
        final message = data['message'];
        AppUtils.debug(message); // Navigate to your success page
          Fluttertoast.showToast(msg: message);
        } else if (response is Failure) {
          print(response.statusCode);
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        final message = data['message'];
          AppUtils.debug(responseBody);
          Fluttertoast.showToast(msg: message);
        }
        notifyListeners();
      
    } catch (e) {
      debugPrint('An error occurred: $e');
      Fluttertoast.showToast(msg: 'An error occurred. Please try again later.');
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }

}