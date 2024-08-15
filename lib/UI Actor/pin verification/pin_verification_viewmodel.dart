import 'package:flutter/widgets.dart';
import 'package:pmvvm/pmvvm.dart';
import "package:flutter/material.dart";

class PinVerificationViewmodel extends ViewModel{
  bool isButtonPinVerificationActive = false;
   late TextEditingController pinController ;
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  void init() {
    super.init();
    pinController = TextEditingController();
    pinController.addListener(() {
      final newIsPinVerificationButtonActive = pinController.text.isNotEmpty;
      if (isButtonPinVerificationActive != newIsPinVerificationButtonActive) {
        isButtonPinVerificationActive = newIsPinVerificationButtonActive;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
    notifyListeners();
  }
}