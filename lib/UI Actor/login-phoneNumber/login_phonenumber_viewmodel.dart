import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

class LoginPhoneNumberViewModel extends ViewModel {
  bool isButtonActive = false;
  FocusNode focusNode = FocusNode();
  late TextEditingController controller;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();
  void textClear() {
    controller.clear();
    passwordController.clear();
  }

  void init() {
    super.init();
    controller = TextEditingController();
    passwordController = TextEditingController();
    controller.addListener(() {
      final newIsButtonActive = controller.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    passwordController.dispose();
    super.dispose();
    notifyListeners();
  }
}
