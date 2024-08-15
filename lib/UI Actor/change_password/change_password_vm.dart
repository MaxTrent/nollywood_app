import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordViewModel{
  final WidgetRef ref;
  ChangePasswordViewModel(this.ref);

  static final oldPasswordControllerProvider = Provider.autoDispose((ref) => TextEditingController());
  static final newPasswordControllerProvider =
  Provider.autoDispose((ref) => TextEditingController());
  static final confirmPasswordControllerProvider =
  Provider.autoDispose((ref) => TextEditingController());


  TextEditingController get oldPasswordController => ref.watch(oldPasswordControllerProvider);
  TextEditingController get newPasswordController => ref.watch(newPasswordControllerProvider);
  TextEditingController get confirmPasswordController => ref.watch(confirmPasswordControllerProvider);

  bool areTextFieldsFilled() => oldPasswordController.text.isNotEmpty && newPasswordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty;

}