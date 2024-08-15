import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter/material.dart";
import 'package:nitoons/UI%20Actor/forgot_password_otp/forgot_password_otp_vm.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/main.dart';
import 'package:nitoons/models/endorsement_model.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:nitoons/utilities/base_notifier.dart';
import 'package:nitoons/utilities/base_state.dart';

class ProducerEndorseRateAndReviewViewmodel {
  final WidgetRef ref;

  ProducerEndorseRateAndReviewViewmodel(this.ref);

  static final controllerProvider = StateProvider.autoDispose((ref) {
    return TextEditingController();
  });

  static final ratingProvider = StateProvider.autoDispose((ref) => 0);

  static final createEndorsementNotifierProvider = StateNotifierProvider<
      ProducerEndorseRateAndReviewNotifier,
      ProducerEndorseRateAndReviewState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    final navigatorKey = ref.read(navigatorKeyProvider);
    return ProducerEndorseRateAndReviewNotifier(
      apiService,
      () {
        navigatorKey.currentState?.pop();
      },
    );
  });

  bool isButtonActive() =>
      ref.read(controllerProvider.notifier).state.text.isNotEmpty;

  TextEditingController get controller => ref.watch(controllerProvider);
  int get ratingValue => ref.watch(ratingProvider);
  ProducerEndorseRateAndReviewState get createEndorsementState =>
      ref.watch(createEndorsementNotifierProvider);

  void Function(int)? onRatingChanged(rating) {
    ref.read(ratingProvider.notifier).state = rating;
    AppUtils.debug('Selected rating: $rating');
    return null;
  }

  Future<void> createEndorsement() async {
    final review = ref.watch(controllerProvider).text;
    final rating = ref.watch(ratingProvider);
    await ref
        .read(createEndorsementNotifierProvider.notifier)
        .createEndorsement(review, rating);
  }
}

class ProducerEndorseRateAndReviewState extends BaseState {
  final EndorsementModel? data;

  ProducerEndorseRateAndReviewState(
      {required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);
}

class ProducerEndorseRateAndReviewNotifier
    extends BaseNotifier<ProducerEndorseRateAndReviewState> {
  ProducerEndorseRateAndReviewNotifier(
      ApiServices apiServices, VoidCallback onSuccess)
      : super(apiServices, onSuccess,
            ProducerEndorseRateAndReviewState(isLoading: false));

  Future<void> createEndorsement(String review, int rating) async {
    await execute(
      () => apiService.createEndorsement(review, rating),
      loadingState: ProducerEndorseRateAndReviewState(isLoading: true),
      dataState: (data) =>
          ProducerEndorseRateAndReviewState(isLoading: false, data: data),
    );
  }

  @override
  ProducerEndorseRateAndReviewState errorState(dynamic error) {
    return ProducerEndorseRateAndReviewState(
        isLoading: false, error: error.toString());
  }
}
