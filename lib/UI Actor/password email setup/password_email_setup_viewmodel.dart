import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

class PasswordSetupViewModel extends ViewModel {
  bool isButtonPasswordControllerActive = false;
  FocusNode focusNode = FocusNode();
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final formKey = GlobalKey<FormState>();

  void init() {
    super.init();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    passwordController.addListener(() {
      final newIsButtonPasswordControllerActive = passwordController.text.isNotEmpty;
      if (isButtonPasswordControllerActive != newIsButtonPasswordControllerActive) {
        isButtonPasswordControllerActive = newIsButtonPasswordControllerActive;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
    notifyListeners();
  }
}
