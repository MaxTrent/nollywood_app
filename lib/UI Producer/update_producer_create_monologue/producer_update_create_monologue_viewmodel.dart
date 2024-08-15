

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../models/producer_just_created_project_model.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';

class ProducerUpdateCreateMonologueViewmodel extends ViewModel {
  bool isButtonActive = false;
  List<bool> isSelected = [];
  late TextEditingController monologueScriptController;
  late TextEditingController monologueTitleController;
  late TextEditingController castingStartDateController;
  late TextEditingController castingStopDateController;

  @override
  void init() {
    super.init();
    isSelected = List.generate(6, (index) => false);
    monologueScriptController = TextEditingController();
    monologueTitleController = TextEditingController();
    castingStartDateController = TextEditingController();
    castingStopDateController = TextEditingController();

    monologueScriptController.addListener(() {
      final newIsButtonActive = monologueScriptController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    monologueScriptController.dispose();
    monologueTitleController.dispose();
    super.dispose();
    notifyListeners();
  }

  textClear() {
    monologueScriptController.clear();
    monologueTitleController.clear();
  }

  bool _publishMonologueLoading = false;
  bool get publishMonologueLoading => _publishMonologueLoading;
  setLoadingPublishMonologueState() {
    _publishMonologueLoading = !_publishMonologueLoading;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> CreateUpdateSingleMonologue() async {
    setLoadingState();

    try {
      if (monologueScriptController.text.isNotEmpty &&
          monologueTitleController.text.isNotEmpty) {
        final accesstoken = await SecureStorageHelper.getAccessToken();
        final projectId = await SharedPreferencesHelper
            .getProducerProjectId(); // Ensure to await if this returns a Future<String?>
        final response = await ApiLayer.makeApiCall(
          ApiUrls.createSingleMonologueScript,
          method: HttpMethod.post,
          requireAccess: true,
          userAccessToken: accesstoken,
          body: {
            "project_id": projectId,
            "script": monologueScriptController.text.trim().toString(),
            "title": monologueTitleController.text.trim().toString(),
          },
        );
        if (response is Success) {
          final data = json.decode(response.body);
          final message = data['message'];
          final String monologueId = data['data']['_id'];

          SharedPreferencesHelper.storeProducerProjectSingleMonologueId(
              monologueId);
          AppUtils.debug(response.body);
          AppUtils.debug(message);
          print(response.body);
          Navigator.pushReplacementNamed(
              context, '/producerMonologueProjectDetailsPage');
          Fluttertoast.showToast(msg: message);

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

  Future publishUpdateProject(projectId,producerId ) async {
    setLoadingPublishMonologueState();

    try {
      final accesstoken = await SecureStorageHelper.getAccessToken();
    //  final producerId = SharedPreferencesHelper.getProducerId();
     // final projectId = SharedPreferencesHelper.getProducerProjectId();
      if (producerId.toString().isNotEmpty && projectId.toString().isNotEmpty) {
        final response = await ApiLayer.makeApiCall(
          ApiUrls.publishProject,
          method: HttpMethod.put,
          requireAccess: true,
          body: {
            "project_id": projectId,
              "producer_id": producerId,
          },
          userAccessToken: accesstoken
        );
        if (response is Success) {
          print('project published');
          AppUtils.debug(response.body);
          final data = json.decode(response.body);
          final message = data['message'];
          

          AppUtils.debug(message);
          print(response.body);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/producer_home_page',
            (Route<dynamic> route) => false,
          );
          Fluttertoast.showToast(msg: message);
        } else if (response is Failure) {
           print('project not published');
          final data = json.decode(response.errorResponse);
          final message = data['message'];
          Fluttertoast.showToast(msg: message);
        }
        notifyListeners();
      }
    } catch (e) {
      AppUtils.debug(e.toString());
    } finally {
      setLoadingPublishMonologueState();
      notifyListeners();
    }
  }

  late PostCreatedProjectModel getCreatedProjectModel;

  Future<PostCreatedProjectModel> fetchUpdatedCreatedProject() async {
    try {
      final projectId = await SharedPreferencesHelper.getProducerProjectId();
      final accessToken = await SecureStorageHelper.getAccessToken();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getProducerProject + projectId!,
        requireAccess: true,
        method: HttpMethod.get,
        userAccessToken: accessToken,
      );
      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];

        final projectCreatedModel = PostCreatedProjectModel.fromJson(data);
        getCreatedProjectModel = projectCreatedModel;
        AppUtils.debug(response.body);
        print(response);
        Fluttertoast.showToast(msg: message);

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
