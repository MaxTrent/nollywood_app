import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/UI%20Actor/forgot_password_otp/forgot_password_otp.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/main.dart';
import 'package:nitoons/models/request_password_reset_email.dart';
import 'package:nitoons/utilities/base_notifier.dart';
import 'package:nitoons/utilities/base_state.dart';

class ForgotPasswordEmailViewModel {
  final WidgetRef ref;

  ForgotPasswordEmailViewModel(this.ref);

  static final controllerProvider =
      Provider.autoDispose((ref) => TextEditingController());

  static final requestPasswordResetEmailNotifierProvider =
      StateNotifierProvider<RequestPasswordResetNotifier,
          RequestPasswordResetState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    final navigatorKey = ref.read(navigatorKeyProvider);
    return RequestPasswordResetNotifier(
      apiService,
      () {
        navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => ForgotPasswordOtp()));
      },
    );
  });

  TextEditingController get controller => ref.watch(controllerProvider);

  RequestPasswordResetState get requestPasswordResetState =>
      ref.watch(requestPasswordResetEmailNotifierProvider);

  bool isTextFieldFilled() => controller.text.isNotEmpty;

  Future<void> requestPasswordResetOtp() async {
    final email = ref.watch(controllerProvider).text;
    ref
        .read(requestPasswordResetEmailNotifierProvider.notifier)
        .requestPasswordReset(email);
  }
}

// class RequestPasswordResetState {
//   final bool isLoading;
//   final RequestPasswordResetModel? data;
//   final String? error;

//   RequestPasswordResetState({required this.isLoading, this.data, this.error});
// }

class RequestPasswordResetState extends BaseState {
  final RequestPasswordResetModel? data;

  RequestPasswordResetState({required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);
}

// class RequestPasswordResetNotifier extends StateNotifier<RequestPasswordResetState> {
//   final ApiServices apiService;
//   final VoidCallback onSuccess;

//   RequestPasswordResetNotifier(this.apiService, this.onSuccess)
//       : super(RequestPasswordResetState(isLoading: false));

//   Future<void> requestPasswordReset(String email) async {
//     try {
//       state = RequestPasswordResetState(isLoading: true);
//       final data = await apiService.requestPasswordResetEmail(email);
//       state = RequestPasswordResetState(isLoading: false, data: data);
//       onSuccess();
//     } catch (error) {
//       state =
//           RequestPasswordResetState(isLoading: false, error: error.toString());
//     }
//   }
// }

class RequestPasswordResetNotifier
    extends BaseNotifier<RequestPasswordResetState> {
  RequestPasswordResetNotifier(ApiServices apiService, VoidCallback onSuccess)
      : super(
            apiService, onSuccess, RequestPasswordResetState(isLoading: false));

  Future<void> requestPasswordReset(String email) async {
    await execute(
      () => apiService.requestPasswordResetEmail(email),
      loadingState: RequestPasswordResetState(isLoading: true),
      dataState: (data) =>
          RequestPasswordResetState(isLoading: false, data: data),
    );
  }

  @override
  RequestPasswordResetState errorState(dynamic error) {
    return RequestPasswordResetState(isLoading: false, error: error.toString());
  }
}
