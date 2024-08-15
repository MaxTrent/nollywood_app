import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../UI Producer/producer_profile_details/producer_profile_details_vm.dart';
import '../../data/api_services.dart';

class ProfileDetailsViewModel{
  final WidgetRef ref;
  ProfileDetailsViewModel(this.ref);

  static final isFollowingProvider = StateProvider.autoDispose((ref) => false);

  bool get isFollowing => ref.watch(isFollowingProvider);

  // bool clickFollowButton() => ref.read(isFollowingProvider.notifier).state =
  // !ref.read(isFollowingProvider.notifier).state;


  static final followUserNotifierProvider =
  StateNotifierProvider<FollowUserNotifier, FollowUserState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    return FollowUserNotifier(apiService);
  });

  FollowUserState get followUserState => ref.watch(followUserNotifierProvider);


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

// class FollowUserNotifier extends BaseNotifier<FollowUserState> {
//   FollowUserNotifier(ApiServices apiServices)
//       : super(apiServices, () {}, FollowUserState(isLoading: false));
//
//   Future<bool> followUser() async {
//     try {
//       await execute(
//             () => apiService.followUser(),
//         loadingState: FollowUserState(isLoading: true),
//         dataState: (data) => FollowUserState(isLoading: false, data: data),
//       );
//       return true;
//     } catch (error) {
//       // Handle error here if necessary
//       return false;
//     }
//   }
//
//   Future<bool> unfollowUser() async {
//     try {
//       await execute(
//             () => apiService.unfollowUser(),
//         loadingState: FollowUserState(isLoading: true),
//         dataState: (data) => FollowUserState(isLoading: false, data: data),
//       );
//       return true;
//     } catch (error) {
//       // Handle error here if necessary
//       return false;
//     }
//   }
//
//   @override
//   FollowUserState errorState(dynamic error) {
//     return FollowUserState(isLoading: false, error: error.toString());
//   }
// }
//
// class FollowUserState extends BaseState {
//   final FollowUserModel? data;
//
//   FollowUserState({required bool isLoading, this.data, String? error})
//       : super(isLoading: isLoading, error: error);
// }


