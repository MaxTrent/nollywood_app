import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../components/app_textfield.dart';
import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../models/get_multiple_roles_model.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/app_util.dart';
import '../update_producer_create_monologue/producer_update_create_monologue_view.dart';

// Class to hold both the TextEditingController and the roleId
class RoleController {
  final TextEditingController controller;
  final String roleId;

  RoleController(this.controller, this.roleId);
}

class CreateRolesUpdateViewmodel extends ViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isButtonActive = false;

  CreateRolesUpdateViewmodel() {
    _roleControllers.add(RoleController(_controller, ''));
    _textFields.add(_buildTextField(_controller));
    _controller.addListener(_updateButtonState);
  }

  @override
  void init() {
    super.init();

    CreateRolesUpdateViewmodel();
    fetchMultipleRoles();
  }

  // State variables
  final TextEditingController _controller = TextEditingController();
  final List<RoleController> _roleControllers = [];
  final List<Widget> _textFields = [];

  // Getters to access state variables
  TextEditingController get controller => _controller;
  List<Widget> get textFields => _textFields;
  List<RoleController> get roleControllers => _roleControllers;

  void _updateButtonState() {
    final newIsButtonActive = areAllTextFieldsFilled();
    if (isButtonActive != newIsButtonActive) {
      isButtonActive = newIsButtonActive;
      notifyListeners();
    }
  }
  // Check if all text fields are filled
  // bool areAllTextFieldsFilled() =>
  //     _roleControllers.any((roleController) => roleController.controller.text.isNotEmpty) ||
  //     _controller.text.isNotEmpty;

  bool areAllTextFieldsFilled() => _roleControllers
      .every((roleController) => roleController.controller.text.isNotEmpty);

  // Method to add a new text field
  void addTextField() {
    if (areAllTextFieldsFilled()) {
      final newController = TextEditingController();
      newController.addListener(_updateButtonState);
      _roleControllers.add(RoleController(newController, ''));
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
            labelText: 'Input a role',
          ),
        ),
      ],
    );
  }

  void clearAllControllers() {
    for (var roleController in _roleControllers) {
      roleController.controller.clear();
    }
  }

  // Set loading state
  bool _loading = false;
  bool get loading => _loading;
  void setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  // Fetch created roles
  List<Datum> _roles = [];
  List<Datum> get roles => _roles;

  final TextEditingController rolesController = TextEditingController();

  Future<List<Datum>> fetchMultipleRoles() async {
    try {
      final projectId = await SharedPreferencesHelper.getProducerProjectId();
      final accessToken = await SecureStorageHelper.getAccessToken();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.getAllProjectRoles + projectId!,
        requireAccess: true,
        method: HttpMethod.get,
        userAccessToken: accessToken,
      );
      print('${ApiUrls.getUserProfile}$projectId');
      if (response is Success) {
        final data = json.decode(response.body);

        final message = data['message'];

        final getMultipleRoles = GetMultipleRoles.fromJson(data);

        _roles = getMultipleRoles.data ?? []; // Update _roles with fetched data

        // Convert roles to string and update the TextEditingControllers
        for (var role in _roles) {
          final roleController = TextEditingController(text: role.roleName);
          roleController.addListener(_updateButtonState);
          _roleControllers
              .add(RoleController(roleController, role.id.toString()));
          _textFields.add(_buildTextField(roleController));
          SharedPreferencesHelper.storeProducerMultipleRoleIdForMonologue(
              role.id.toString());
        }
        notifyListeners(); // Notify listeners to update the UI
        return _roles; // Return _roles list
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching roles');
    }
    notifyListeners(); // Notify listeners to update the UI
    return []; // Return an empty list if there's an error
  }

  Future<void> createRolesUpdateByProducer() async {
    setLoadingState();
    try {
      final accessToken = await SecureStorageHelper.getAccessToken();
      final projectId = await SharedPreferencesHelper.getProducerProjectId();

      for (final roleController in _roleControllers) {
        final requestBody = {
          "project_id": projectId,
          "role_id": roleController.roleId,
          "role_name": roleController.controller.text,
        };

        print('Request Body: $requestBody');

        final response = await ApiLayer.makeApiCall(
          ApiUrls.updateCreatedRoles,
          method: HttpMethod.put,
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
          Fluttertoast.showToast(msg: "Role updated successfully");
          SharedPreferencesHelper.storeProducerProjectRoleId(roleId);
          print('this is $roleId');
          roleController.controller.clear();

          Navigator.pushReplacementNamed(
              context, '/producerUpdateCreateMonologueRolesPage');

          // Navigator.of(context).push(MaterialPageRoute(
          //                   builder: (context) =>
          //                       ProducerUpdateCreateMonologueView()));
        } else if (response is Failure) {
          final data = json.decode(response.errorResponse);
          print(response.code);
          print(data);
          print(response.errorResponse);
          final message = data['message'];
          // Fluttertoast.showToast(msg: message);
        }
      }
    } catch (e) {
      AppUtils.debug(e.toString());
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }
}
