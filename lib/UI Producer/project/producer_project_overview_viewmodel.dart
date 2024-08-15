import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';
import "package:flutter/material.dart";
import '../../data/api_layer.dart';
import '../../models/producer_just_created_project_model.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';

class ProducerProjectOverviewViewmodel extends ViewModel {
 

  late PostCreatedProjectModel getCreatedProjectModel;

  Future<PostCreatedProjectModel> fetchProject() async {
    try {
      final projectId = await SharedPreferencesHelper.getProducerProjectId();
      final accessToken = await SecureStorageHelper.getAccessToken();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getProducerProject + projectId!,
        requireAccess: true,
        method: HttpMethod.get,
        userAccessToken: accessToken,
      );
      print('${ApiUrls.getUserProfile}/$projectId');
      if (response is Success) {
        final data = json.decode(response.body);
       // final message = data['message'];

        final projectCreatedModel = PostCreatedProjectModel.fromJson(data);
        getCreatedProjectModel = projectCreatedModel;

        print(response);
       // Fluttertoast.showToast(msg: message);
        return projectCreatedModel;
      } else if (response is Failure) {
        print(response);
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      AppUtils.debug(e.toString());
    }
    notifyListeners(); // Notify listeners to update the UI
    return getCreatedProjectModel;
  }
}
