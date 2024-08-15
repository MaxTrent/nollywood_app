
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:http/http.dart' as http;
import '../../data/app_storage.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';

class ProfilePictureViewmodel extends ViewModel{
 bool isButtonActive = false;
// profile picture upload for producer
  File? image;

  Future uploadPicture() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    updateColorState();
    notifyListeners();
  }

  void removeImage() {
    image = null;
    notifyListeners();
  }
void updateColorState() {
    final newIsButtonActive = image != null || image!.path.isNotEmpty;;
    if (isButtonActive != newIsButtonActive) {
      isButtonActive = newIsButtonActive;
      notifyListeners();
    }
  }
bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> createActorProfilePicture(BuildContext context) async {
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
          'profile_picture',
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
        AppUtils.debug(message);
          removeImage();
                    if (homePagePath != null) {
           Navigator.pushReplacementNamed(context, homePagePath);
         } 
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