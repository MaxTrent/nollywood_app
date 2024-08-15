import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/models/application_project_model.dart';
import 'package:nitoons/utilities/base_notifier.dart';
import 'package:nitoons/utilities/base_state.dart';

class RolesViewModel {
  final WidgetRef ref;
  RolesViewModel(this.ref);


  // static final isModalShownProvider = StateProvider((ref) => false);

  static final getAllApplicationsProvider = FutureProvider.autoDispose((ref) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getAllApplicationsActorId();
  });

  static final getAllOpenRolesProvider = FutureProvider.autoDispose((ref) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getAllOpenRoles();
  });

  final tabController = useTabController(initialLength: 2);

  // AutoDisposeFutureProvider get getAllOpenRoles => ref.watch(getAllOpenRolesProvider.future);

  // bool get isModalShown => ref.watch(isModalShownProvider);
}

class CreateApplicationProjectIdState extends BaseState {
  final ApplicationProjectResponseModel? data;

  CreateApplicationProjectIdState(
      {required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);
}

class CreatePostNotifier extends BaseNotifier<CreateApplicationProjectIdState> {
  CreatePostNotifier(ApiServices apiServices, VoidCallback onSuccess)
      : super(apiServices, onSuccess,
            CreateApplicationProjectIdState(isLoading: false));

  Future<void> createPost(String description, String mediaUpload) async {
    await execute(
      () => apiService.createPost(description, mediaUpload),
      loadingState: CreateApplicationProjectIdState(isLoading: true),
      dataState: (data) =>
          CreateApplicationProjectIdState(isLoading: false, data: data),
    );
  }

  @override
  CreateApplicationProjectIdState errorState(dynamic error) {
    return CreateApplicationProjectIdState(
        isLoading: false, error: error.toString());
  }
}
