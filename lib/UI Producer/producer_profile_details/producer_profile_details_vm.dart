import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/models/follow_user_model.dart';
import 'package:nitoons/utilities/base_notifier.dart';
import 'package:nitoons/utilities/base_state.dart';


import '../../models/get_user_profile_model.dart';

import '../../UI Actor/home_page.dart';


class ProducerProfileDetailsViewModel {
  final WidgetRef ref;
  ProducerProfileDetailsViewModel(this.ref);

  static final getUserProfileProvider =
      FutureProvider.family<GetUserProfileModel, String>(
          (ref, profileId) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getUserProfile(profileId);
  });

  static final isFollowingProvider = StateProvider.autoDispose((ref) => false);

  static final followUserNotifierProvider =
      StateNotifierProvider<FollowUserNotifier, FollowUserState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    return FollowUserNotifier(apiService);
  });

  FollowUserState get followUserState => ref.watch(followUserNotifierProvider);

  bool get isFollowing => ref.watch(isFollowingProvider);

  Future<void> clickFollowButton() async {
    if (isFollowing) {
      await unfollowUser();
    } else {
      await followUser();
    }
  }

  Future<void> followUser() async {
    final success =
        await ref.read(followUserNotifierProvider.notifier).followUser(ref);
    if (success) {
      ref.read(isFollowingProvider.notifier).state = true;
    }
  }

  Future<void> unfollowUser() async {
    final success =
        await ref.read(followUserNotifierProvider.notifier).unfollowUser(ref);
    if (success) {
      ref.read(isFollowingProvider.notifier).state = false;
    }
  }
}

class FollowUserNotifier extends BaseNotifier<FollowUserState> {
  FollowUserNotifier(ApiServices apiServices)
      : super(apiServices, () {}, FollowUserState(isLoading: false));

  Future<bool> followUser(WidgetRef ref) async {
    state = FollowUserState(isLoading: true);
    try {
      await execute(
        () async{
          final response = await apiService.followUser();
          if (response.error && response.code == 400 ){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ref.read(isModalShownProvider)){
                ref.context.showSignUpModal(ref);
                ref.read(isModalShownProvider.notifier).state = true;
              }
            });
          }
          },
        loadingState: FollowUserState(isLoading: true),
        dataState: (data) => FollowUserState(isLoading: false, data: data),
      );
      return true;
    } catch (error) {
      state = FollowUserState(isLoading: false, error: error.toString());
      return false;
    }
  }

  Future<bool> unfollowUser(WidgetRef ref) async {
    try {
      state = FollowUserState(isLoading: true);
      await execute(
        () async{
          final response = await apiService.followUser();
          if (response.error && response.code == 400 ){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ref.read(isModalShownProvider)){
                ref.context.showSignUpModal(ref);
                ref.read(isModalShownProvider.notifier).state = true;
              }
            });
          }
        },
        loadingState: FollowUserState(isLoading: true),
        dataState: (data) => FollowUserState(isLoading: false, data: data),
      );
      return true;
    } catch (error) {
      state = FollowUserState(isLoading: false, error: error.toString());
      return false;
    }
  }

  @override
  FollowUserState errorState(dynamic error) {
    return FollowUserState(isLoading: false, error: error.toString());
  }
}

class FollowUserState extends BaseState {
  final FollowUserModel? data;

  FollowUserState({required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);
}
