import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../models/producer_just_created_project_model.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../update_project_details/producer_project_update_name_view.dart';

class ProducerProjectDetailsViewmodel extends ViewModel {
  late PostCreatedProjectModel getCreatedProjectModel;

  Future<PostCreatedProjectModel> fetchCreatedProject() async {
    try {
      final projectId = await SharedPreferencesHelper.getProducerProjectId();
      // SharedPreferencesHelper.storeProducerProjectId(projectId!);
      final accessToken = await SecureStorageHelper.getAccessToken();

      final response = await ApiLayer.makeApiCall(
        ApiUrls.getProducerProject + projectId!,
        requireAccess: true,
        method: HttpMethod.get,
        userAccessToken: accessToken,
      );
     
      if (response is Success) {
        final data = json.decode(response.body);
    
        final projectCreatedModel = PostCreatedProjectModel.fromJson(data);
        getCreatedProjectModel = projectCreatedModel;
      
        SharedPreferencesHelper.storeProducerEditProjectId(getCreatedProjectModel.data!.id.toString());
      
       // Fluttertoast.showToast(msg: message);

        return projectCreatedModel;
      } else if (response is Failure) {
      
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

  toUpdateNamePage(projectDes, NameofProject, projectId) {
    if (projectId.toString().isNotEmpty) {
      SharedPreferencesHelper.storeProducerProjectId(projectId);
      print('projectId from details page $projectId');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProducerProjectUpdateNameView(
                projectDescription: projectDes,
                projectId: projectId,
                projectName: NameofProject,
              )));
    } else {
      null;
    }
  }
}
