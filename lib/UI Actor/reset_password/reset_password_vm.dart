import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/UI%20Actor/password_reset_successful/password_reset_successful.dart';
import 'package:nitoons/UI%20Actor/reset_password/reset_password.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/main.dart';
import 'package:nitoons/models/reset_password_model.dart';
import 'package:nitoons/utilities/base_notifier.dart';
import 'package:nitoons/utilities/base_state.dart';

class ResetPasswordEmailViewModel {
  final WidgetRef ref;
  ResetPasswordEmailViewModel(this.ref);

  static final passwordControllerProvider =
      Provider.autoDispose((ref) => TextEditingController());
  static final confirmPasswordControllerProvider =
      Provider.autoDispose((ref) => TextEditingController());

  static final resetPasswordEmailNotifierProvider = StateNotifierProvider<
      ResetPasswordEmailNotifier, ResetPasswordEmailState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    final navigatorKey = ref.read(navigatorKeyProvider);
    return ResetPasswordEmailNotifier(
      apiService,
      () {
        navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => PasswordResetSuccessful()));
      },
    );
  });

  TextEditingController get passwordController =>
      ref.watch(passwordControllerProvider);
  TextEditingController get confirmPasswordController =>
      ref.watch(confirmPasswordControllerProvider);

  ResetPasswordEmailState get resetPasswordState =>
      ref.watch(resetPasswordEmailNotifierProvider);

  bool areTextFieldsFilled() =>
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty;

  Future<void> resetPassword() async {
    final password = ref.watch(confirmPasswordControllerProvider).text;
    ref
        .read(resetPasswordEmailNotifierProvider.notifier)
        .resetPasswordEmail(password);
  }
}

class ResetPasswordEmailState extends BaseState {
  final ResetPasswordModel? data;

  ResetPasswordEmailState({required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);
}

class ResetPasswordEmailNotifier extends BaseNotifier<ResetPasswordEmailState> {
  ResetPasswordEmailNotifier(ApiServices apiServices, VoidCallback onSuccess)
      : super(
            apiServices, onSuccess, ResetPasswordEmailState(isLoading: false));

  Future<void> resetPasswordEmail(String password) async {
    await execute(
      () => apiService.resetPasswordEmail(password),
      loadingState: ResetPasswordEmailState(isLoading: true),
      dataState: (data) =>
          ResetPasswordEmailState(isLoading: false, data: data),
    );
  }

  @override
  ResetPasswordEmailState errorState(dynamic error) {
    return ResetPasswordEmailState(isLoading: false, error: error.toString());
  }
}
