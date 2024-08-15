import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/utilities/app_util.dart';

class EndorsementsViewModel {
  final WidgetRef ref;

  EndorsementsViewModel(this.ref);

  static final controllerProvider = StateProvider((ref) {
    return TextEditingController();
  });

  static final getAllEndorsementsProvider = FutureProvider((ref) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getAllEndorsements();
  });

  static final isButtonActiveProvider = StateProvider((ref) {
    final controller = ref.watch(controllerProvider.notifier).state;
    return controller.text.isNotEmpty;
  });

  TextEditingController get controller => ref.watch(controllerProvider);
}
