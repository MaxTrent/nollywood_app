import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../components/app_textfield.dart';
import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';

class ActorlookalikeViewModel extends ViewModel {
  final formKey = GlobalKey<FormState>();
  bool isButtonActive = false;
 
  @override
  void init() {
    super.init();
  }

   // Constructor to initialize with one controller
  ActorlookalikeViewModel() {
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
            hintText: 'e.g Jim Iyke',
            labelText: 'Actor lookalike',
          ),
        ),
      ],
    );
  }

  void clearControllers() {
    for (var controller in controllers) {
      controller.dispose();
    }
    controllers.clear();
    textFields.clear();
  }
void resetForm() {
    clearControllers();
    final defaultController = TextEditingController();
    _controllers.add(defaultController);
    _textFields.add(_buildTextField(defaultController));
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  void setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> submitData() async {
    setLoadingState();
    try {
      final homePagePath = await SharedPreferencesHelper.getUserHomePage();
      final accessToken = await SecureStorageHelper.getAccessToken();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
        body: {
          "updateData": {
            'actor_lookalike': controllers.map((controller) => controller.text).toList(),
          },
        },
        userAccessToken: accessToken,
      );

      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];
        final userId = data['data']['user_id'];
        Fluttertoast.showToast(msg: message);
        SecureStorageHelper.storeUserId(userId);
        resetForm(); 
        if (homePagePath != null) {
          Navigator.pushReplacementNamed(context, homePagePath);
        }
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e');
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }
}
