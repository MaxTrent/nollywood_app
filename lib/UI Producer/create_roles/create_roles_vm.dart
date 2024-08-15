import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../components/app_textfield.dart';
import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';

class CreateRolesViewModel extends ViewModel {
 final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isButtonActive = false;
  CreateRolesViewModel() {
    _controllers.add(_controller);
    _textFields.add(_buildTextField(_controller));
  }

  
 // State variables
  final TextEditingController _controller = TextEditingController();
  final List<TextEditingController> _controllers = [];
  final List<Widget> _textFields = [];

  // Getters to access state variables
  TextEditingController get controller => _controller;

  List<Widget> get textFields => _textFields;

  List<TextEditingController> get controllers => _controllers;

  // Check if all text fields are filled
  bool areAllTextFieldsFilled() =>
      _controllers.any((controller) => controller.text.isNotEmpty) ||
      _controller.text.isNotEmpty;

  // Method to add a new text field
  void addTextField() {
    if (areAllTextFieldsFilled()) {
      final newController = TextEditingController();
      _controllers.add(newController);
      _textFields.add(_buildTextField(newController));
      notifyListeners(); // Notify listeners to update the UI
    } else {
      print('Cannot add a new text field until at least one field is filled');
    }
  }

  Widget _buildTextField(TextEditingController controller) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 13.h),
          child: AppTextField(
            controller: controller,
            hintText: 'e.g Village witch',
            labelText: 'Role',
          ),
        ),
      ],
    );
  }

  // set loading state
  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> createRolesByProducer() async {
    setLoadingState();
    try {
      final accessToken = await SecureStorageHelper.getAccessToken();
      final projectId = await SharedPreferencesHelper.getProducerProjectId();

      for (final controller in _controllers) {
        final requestBody = {
          "project_id": projectId,
          "role_name": controller.text
        };

        print('Request Body: $requestBody');

        final response = await ApiLayer.makeApiCall(
          ApiUrls.createRoles,
          method: HttpMethod.post,
          requireAccess: true,
          body: requestBody,
          userAccessToken: accessToken,
        );

        if (response is Success) {
          final data = json.decode(response.body);
          final message = data['message'];
          final roleId = data['data']['_id'];
          print(response.code);
          print(response.body);
          print('this is the role ID $roleId');
          Fluttertoast.showToast(msg: message);
          SharedPreferencesHelper.storeProducerProjectRoleId(roleId);
          print('this is $roleId');
          Navigator.pushReplacementNamed(
              context, '/producerCreateMonologueRolesPage');
            //   Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   '/producerCreateMonologueRolesPage',
            //   (Route<dynamic> route) => false,
            // );
        } else if (response is Failure) {
          final data = json.decode(response.errorResponse);
          print(response.code);
          print(data);
          print(response.errorResponse);
          final message = data['message'];
          Fluttertoast.showToast(msg: message);
        }
      }
    } catch (e) {
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }
}
