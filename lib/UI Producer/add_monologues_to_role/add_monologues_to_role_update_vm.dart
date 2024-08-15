import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../models/get_multiple_roles_model.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';

class ProducerAddMonologuesToRoleUpdateViewModel extends ViewModel {
  bool isButtonActive = false;
  late TextEditingController monologueScriptController;
  late TextEditingController monologueTitleController;

  bool _allRolesActive = false;
  bool get allRolesActive => _allRolesActive;

  @override
  void init() async {
    super.init();
    monologueScriptController = TextEditingController();
    monologueTitleController = TextEditingController();

    monologueScriptController.addListener(() {
      final newIsButtonActive = monologueScriptController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });

   await fetchUpdateMultipleRoles();
    
  }

  bool _loading = false;
  bool get loading => _loading;

  void setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  void textClear() {
    monologueScriptController.clear();
    monologueTitleController.clear();
  }

  Future<void> createMonologueForRoles(String roleId) async {
    setLoadingState();

    try {
      if (monologueScriptController.text.isNotEmpty &&
          monologueTitleController.text.isNotEmpty) {
        final accesstoken = await SecureStorageHelper.getAccessToken();
        final response = await ApiLayer.makeApiCall(
          ApiUrls.createMultipleMonologueScript,
          method: HttpMethod.post,
          requireAccess: true,
          userAccessToken: accesstoken,
          body: {
            "role_id": roleId.toString(),
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

          Navigator.pop(context);
          Fluttertoast.showToast(msg: message);

          textClear();
         await fetchUpdateMultipleRoles(); // Fetch roles again to update their status
          
        } else if (response is Failure) {
          final data = json.decode(response.errorResponse);
          final message = data['message'];
          Fluttertoast.showToast(msg: message);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setLoadingState();
    }
  }

  List<Datum> _roles = [];
  List<Datum> get roles => _roles;

  Future<List<Datum>> fetchUpdateMultipleRoles() async {
    try {
      final projectId = await SharedPreferencesHelper.getProducerProjectId();
      final accessToken = await SecureStorageHelper.getAccessToken();
      final response = await ApiLayer.makeApiCall(
        '${ApiUrls.getAllProjectRoles}$projectId',
        requireAccess: true,
        method: HttpMethod.get,
        userAccessToken: accessToken,
      );
      if (response is Success) {
        final data = json.decode(response.body);
        final getMultipleRoles = GetMultipleRoles.fromJson(data);
        _roles = getMultipleRoles.data ?? [];

        await Future.wait(_roles.map((role) async {
          await SharedPreferencesHelper.storeProducerMultipleRoleIdForMonologue(
            role.id.toString(),
          );
          notifyListeners();
        }));

        checkAllRolesActive();
        notifyListeners();
        Fluttertoast.showToast(msg: data['message']);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        Fluttertoast.showToast(msg: data['message']);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching roles');
    } finally {
      notifyListeners();
    }
    return _roles;
  }

  void checkAllRolesActive() {
    final newAllRolesActive =
        _roles.every((role) => role.monologueScriptSet ?? false);
    if (_allRolesActive != newAllRolesActive) {
      _allRolesActive = newAllRolesActive;
      notifyListeners(); // Notify listeners if the active roles state changes
    }
    notifyListeners();
  }

  Future<void> checkCompletion() async {
    await fetchUpdateMultipleRoles();
    checkAllRolesActive();
  }
}
