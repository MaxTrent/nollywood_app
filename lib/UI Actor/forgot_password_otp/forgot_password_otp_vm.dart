import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/UI%20Actor/reset_password/reset_password.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/main.dart';
import 'package:nitoons/models/validate_signup_otp_model.dart';
import 'package:nitoons/utilities/base_notifier.dart';
import 'package:nitoons/utilities/base_state.dart';

class ForgotPasswordOtpViewModel {
  final WidgetRef ref;
  ForgotPasswordOtpViewModel(this.ref);

  static final controllerProvider =
      Provider.autoDispose((ref) => TextEditingController());

  static final validatePasswordResetOtpEmailNotifierProvider =
      StateNotifierProvider<ForgotPasswordOtpNotifier, ForgotPasswordOtpState>(
          (ref) {
    final apiService = ref.read(apiServiceProvider);
    final navigatorKey = ref.read(navigatorKeyProvider);
    return ForgotPasswordOtpNotifier(
      apiService,
      () {
        navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => ResetPasswordEmail()));
      },
    );
  });

  TextEditingController get controller => ref.watch(controllerProvider);

  bool isTextFieldFilled() => controller.text.isNotEmpty;

  ForgotPasswordOtpState get validatePasswordResetState =>
      ref.watch(validatePasswordResetOtpEmailNotifierProvider);

  Future<void> validateOtp() async {
    final otp = ref.watch(controllerProvider).text;
    ref
        .read(validatePasswordResetOtpEmailNotifierProvider.notifier)
        .validateOtpEmail(otp);
  }
}

class ForgotPasswordOtpState extends BaseState {
  final ValidateOtpModel? data;

  ForgotPasswordOtpState({required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);
}

class ForgotPasswordOtpNotifier extends BaseNotifier<ForgotPasswordOtpState> {
  ForgotPasswordOtpNotifier(ApiServices apiServices, VoidCallback onSuccess)
      : super(apiServices, onSuccess, ForgotPasswordOtpState(isLoading: false));

  Future<void> validateOtpEmail(String otp) async {
    await execute(
      () => apiService.validatePasswordResetOtpEmail(otp),
      loadingState: ForgotPasswordOtpState(isLoading: true),
      dataState: (data) => ForgotPasswordOtpState(isLoading: false, data: data),
    );
  }

  @override
  ForgotPasswordOtpState errorState(dynamic error) {
    return ForgotPasswordOtpState(isLoading: false, error: error.toString());
  }
}
