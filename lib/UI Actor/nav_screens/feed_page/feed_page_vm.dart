import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nitoons/UI%20Actor/account_setup/account_setup_vm.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/models/all_comments_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../data/app_storage.dart';

import '../../../UI Producer/producer_profile_details/producer_profile_details_vm.dart';

import '../../../main.dart';
import '../../../utilities/base_notifier.dart';
import '../../../utilities/base_state.dart';
import '../../home_page.dart';

class FeedPageViewModel extends AccountSetupViewModel {
  final WidgetRef ref;

  FeedPageViewModel(this.ref);

  static final incompleteSnackProvider =
  StateProvider.autoDispose((ref) => true);

  static final likedCommentsCountProvider =
  StateProvider<Map<String, int>>((ref) => {});

  static final postsLikesCountProvider =
  StateProvider<Map<String, int>>((ref) => {});
  static final replyLikesCountProvider =
  StateProvider<Map<String, int>>((ref) => {});

  static final makeCommentNotifierProvider =
  StateNotifierProvider<MakeCommentNotifier, MakeCommentState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    final navigatorKey = ref.read(navigatorKeyProvider);
    return MakeCommentNotifier(
      apiService,
          () {
        navigatorKey.currentState?.pop();
      },
    );
  });

  static final getAllCommentsProvider = FutureProvider.family
      .autoDispose<CommentsResponseModel, String>((ref, postId) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getAllComments(postId);
  });

  static final isReplyingProvider = StateProvider<bool>((ref) => false);
  static final likedCommentsProvider =
  StateProvider<Map<String, bool>>((ref) => {});
  static final replyingToCommentIdProvider =
  StateProvider<String?>((ref) => null);
  static final visibleRepliesProvider = StateProvider<Set<String>>((ref) => {});

  // static final likedCommentsCountProvider = StateProvider<Map<String, int>>((ref) => {});

  static final likeButtonNotifierProvider =
  StateNotifierProvider<LikeButtonNotifier, LikeButtonState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    return LikeButtonNotifier(
      apiService,
          () {},
    );
  });
  static final tempIconPositionProvider = StateProvider((ref) => Offset.zero);
  static final isLikedProvider = StateProvider((ref) => false);

  static final showTempIconProvider = StateProvider((ref) => false);
  static final getTimelinePostsProvider =
  FutureProvider.autoDispose((ref) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getTimelinePosts();
  });

  LikeButtonState get likeState => ref.watch(likeButtonNotifierProvider);

  Offset get tempIconPosition => ref.watch(tempIconPositionProvider);

  bool get showTempIcon => ref.watch(showTempIconProvider);

  bool get isReplying => ref.watch(isReplyingProvider);

  // Future get toggleLike => ref.watch(toggleLikeProvider);

  Map<String, bool> get likedComments => ref.watch(likedCommentsProvider);

  String? get replyingToCommentId => ref.watch(replyingToCommentIdProvider);

  Set<String> get visibleReplies => ref.watch(visibleRepliesProvider);

  bool get isLiked => ref.watch(isLikedProvider);

  Map<String, int> get commentLikesCount =>
      ref.watch(likedCommentsCountProvider);

  Map<String, int> get replyLikesCount => ref.watch(replyLikesCountProvider);

  Map<String, int> get postLikesCount => ref.watch(postsLikesCountProvider);

  // FutureProvider get getTimelinePosts => ref.watch(getTimelinePostsProvider.future);

  void handleDoubleTap(TapDownDetails details) {
    ref
        .read(showTempIconProvider.notifier)
        .state = true;
    ref
        .read(isLikedProvider.notifier)
        .state = true;
    ref
        .read(tempIconPositionProvider.notifier)
        .state = details.globalPosition;

    Future.delayed(Duration(milliseconds: 500), () {
      ref
          .read(showTempIconProvider.notifier)
          .state = false;
    });
  }

  // Future<void> toggleLikeButton(String commentId) async {
  //
  //   ref
  //       .read(likeButtonNotifierProvider.notifier)
  //       .likeComment(commentId);
  // }

  static final commentControllerProvider =
  Provider.autoDispose((ref) => TextEditingController());
  static final isFirstTimeProvider = StateProvider((ref) => true);
  static final showOverlayProvider = StateProvider((ref) => true);
  static final commentFocusNodeProvider =
  Provider.autoDispose((ref) => FocusNode());

  FocusNode get commentFocusNode => ref.watch(commentFocusNodeProvider);

  bool get incompleteSnackBar => ref.watch(incompleteSnackProvider);

  bool removeSnackBar() =>
      ref
          .read(incompleteSnackProvider.notifier)
          .state = false;

  bool get isFirstTime => ref.watch(isFirstTimeProvider);

  bool get showOverlay => ref.watch(showOverlayProvider);

  bool likeButtonToggle() =>
      ref
          .read(isLikedProvider.notifier)
          .state =
      !ref
          .read(isLikedProvider.notifier)
          .state;

  bool removeOverlay() =>
      ref
          .read(showOverlayProvider.notifier)
          .state = false;

  TextEditingController get commentController =>
      ref.watch(commentControllerProvider);

  String get commentText =>
      ref
          .watch(commentControllerProvider)
          .text;

  checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool? firstTime = prefs.getBool('first_time');
    // if (firstTime != null) {
    //   ref.read(isFirstTimeProvider.notifier).state = firstTime;
    // } else {
    //    ref.read(isFirstTimeProvider.notifier).state = true;
    // }
    if (isFirstTime) {
      prefs.setBool('first_time', false);
      ref
          .read(showOverlayProvider.notifier)
          .state = false;
    }

    ref
        .read(isFirstTimeProvider.notifier)
        .state = prefs.getBool('first_time')!;
  }

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
      ref
          .read(isFollowingProvider.notifier)
          .state = true;
    }
  }

  Future<void> unfollowUser() async {
    final success =
    await ref.read(followUserNotifierProvider.notifier).unfollowUser(ref);
    if (success) {
      ref
          .read(isFollowingProvider.notifier)
          .state = false;
    }
  }

  Future<void> checkProfileCompletionStatus() async {
    await accountPages(); // ensure _accountList is populated
    await checkProfileCompletion();
  }

Future<bool> checkUserAuthentication() async {
    // Replace with actual authentication check
    bool isAuthenticated = await SecureStorageHelper.isAuthenticated();
    return isAuthenticated;
  }

  // Future<void> toggleLikeButton(String commentId) async {
  //   final currentState = ref.read(likedCommentsProvider)[commentId] ?? false;
  //   if (currentState) {
  //     await ref.read(likeButtonNotifierProvider.notifier).unlikeComment(commentId);
  //   } else {
  //     await ref.read(likeButtonNotifierProvider.notifier).likeComment(commentId, p);
  //   }}

    Future<void> unlikeComment(String commentId, String postId) async {
      await ref
          .read(likeButtonNotifierProvider.notifier)
          .unlikeComment(commentId, postId, ref);
    }

  Future<void> likeComment(String commentId, String postId) async {
    await ref
        .read(likeButtonNotifierProvider.notifier)
        .likeComment(commentId, postId, ref);
  }

    Future<void> likeReply(String commentId, String replyId,
        String postId) async {
      await ref
          .read(likeButtonNotifierProvider.notifier)
          .likeReply(commentId, replyId, postId, ref);
    }
    Future<void> unlikeReply(String commentId, String replyId,
        String postId) async {
      await ref
          .read(likeButtonNotifierProvider.notifier)
          .unlikeReply(commentId, replyId, postId, ref);
    }

    Future<void> likePost(String postId) async {
      await ref
          .read(likeButtonNotifierProvider.notifier)
          .likePost(postId, ref);
    }

    Future<void> unlikePost(String postId) async {
      await ref
          .read(likeButtonNotifierProvider.notifier)
          .unlikePost(postId, ref);
    }


    void toggleReplies(String commentId) {
      final currentVisibleReplies = Set<String>.from(visibleReplies);
      if (currentVisibleReplies.contains(commentId)) {
        currentVisibleReplies.remove(commentId);
      } else {
        currentVisibleReplies.add(commentId);
      }
      ref
          .read(visibleRepliesProvider.notifier)
          .state = currentVisibleReplies;
    }

    void focusReplyField() {
      commentFocusNode.requestFocus();
    }

    Future<void> makeCommentOrReply(String postId) async {
      // final replyingToCommentId = ref.read(replyingToCommentIdProvider);

      if (commentText.isNotEmpty) {
        if (isReplying && replyingToCommentId != null) {
          await addReplyToComment(replyingToCommentId!, commentText);
          print('make reply');
        } else {
          await makeComment(postId);
          print('make comment');
        }
        commentController.clear();
        ref
            .read(isReplyingProvider.notifier)
            .state = false;
        ref.refresh(getAllCommentsProvider(postId));
      }
      ref.refresh(getTimelinePostsProvider);
    }

    Future<void> addReplyToComment(String commentId,
        String replyContent) async {
      await ref
          .read(makeCommentNotifierProvider.notifier)
          .addReply(commentId, replyContent, ref);
    }

    Future<void> makeComment(String postId) async {
      if (commentText.isNotEmpty) {
        await ref
            .read(makeCommentNotifierProvider.notifier)
            .makeComment(postId, commentText, ref);
        commentController.clear();
        ref.refresh(getAllCommentsProvider(postId));
      }
    }
  }

class MakeCommentState extends BaseState {
  final List<CommentModel> comments;

  MakeCommentState(
      {required bool isLoading, required this.comments, String? error})
      : super(isLoading: isLoading, error: error);

  MakeCommentState copyWith({
    bool? isLoading,
    List<CommentModel>? comments,
    String? error,
  }) {
    return MakeCommentState(
      isLoading: isLoading ?? this.isLoading,
      comments: comments ?? this.comments,
      error: error,
    );
  }
}

class MakeCommentNotifier extends BaseNotifier<MakeCommentState> {
  MakeCommentNotifier(ApiServices apiService, VoidCallback onSuccess)
      : super(apiService, onSuccess,
            MakeCommentState(isLoading: false, comments: []));

  Future<void> makeComment(String postId, String comment, WidgetRef ref) async {
    await execute(
      () async {
        final response = await apiService.makeComment(postId, comment);
        if (response.error && response.code == 400) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!ref.read(isModalShownProvider)) {
              ref.context.showSignUpModal(ref);
              ref.read(isModalShownProvider.notifier).state = true;
            }
          });
        }
        if (response.success && response.data != null) {
          final newComments = CommentModel.fromJson(response.data);
          final updatedComments = [...state.comments, newComments];
          return updatedComments;
        } else {
          throw Exception('Failed to send comments');
        }
      },
      loadingState: MakeCommentState(isLoading: true, comments: state.comments),
      dataState: (data) => MakeCommentState(isLoading: false, comments: data),
    );
  }

  Future<void> addReply(String commentId, String reply, WidgetRef ref) async {
    await execute(
      () async {
        final response = await apiService.addReply(commentId, reply);
        if (response.error && response.code == 400) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!ref.read(isModalShownProvider)) {
              ref.context.showSignUpModal(ref);
              ref.read(isModalShownProvider.notifier).state = true;
            }
          });
        }
        if (response.success && response.data != null) {
          final updatedComments = [...state.comments];
          final commentIndex =
              updatedComments.indexWhere((c) => c.id == commentId);
          if (commentIndex != -1) {
            updatedComments[commentIndex]
                .replies
                .add(ReplyModel.fromJson(response.data));
          }
          return updatedComments;
        } else {
          throw Exception('Failed to add reply');
        }
      },
      loadingState: MakeCommentState(isLoading: true, comments: state.comments),
      dataState: (data) => MakeCommentState(isLoading: false, comments: data),
    );
  }

  @override
  MakeCommentState errorState(dynamic error) {
    return MakeCommentState(
        isLoading: false, comments: state.comments, error: error.toString());
  }
}

class LikeButtonState extends BaseState {
  final dynamic data;

  LikeButtonState({required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);
}

class LikeButtonNotifier extends BaseNotifier<LikeButtonState> {
  LikeButtonNotifier(ApiServices apiService, VoidCallback onSuccess)
      : super(apiService, onSuccess, LikeButtonState(isLoading: false));

  Future<void> likePost(String postId, WidgetRef ref) async {
    await execute(
            () async {
          final response = await apiService.likePost(postId);
          if (response.code == 400) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ref.read(isModalShownProvider)) {
                ref.context.showSignUpModal(ref);
                ref.read(isModalShownProvider.notifier).state = true;
              }
            });
          }
        },
        loadingState: LikeButtonState(isLoading: true),
        dataState: (data) {
          ref
              .read(FeedPageViewModel.postsLikesCountProvider.notifier)
              .update((state) {
            final currentLikes = state[postId] ?? 0;
            return {...state, postId: currentLikes + 1};
          });
          return LikeButtonState(isLoading: false, data: data);
        });
  }

  Future<void> unlikePost(String postId, WidgetRef ref) async {
    await execute(
            () async {
          final response = await apiService.unlikePost(postId);
          if (response.code == 400) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ref.read(isModalShownProvider)) {
                ref.context.showSignUpModal(ref);
                ref.read(isModalShownProvider.notifier).state = true;
              }
            });
          }
        },
        loadingState: LikeButtonState(isLoading: true),
        dataState: (data) {
          ref
              .read(FeedPageViewModel.postsLikesCountProvider.notifier)
              .update((state) {
            final currentLikes = state[postId] ?? 0;
            return {...state, postId: currentLikes - 1};
          });
          return LikeButtonState(isLoading: false, data: data);
        });
  }


  Future<void> likeComment(String commentId, String postId, WidgetRef ref) async {
    await execute(
        () async {
          final response = await apiService.likeComment(commentId);
          if (response.code == 400) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ref.read(isModalShownProvider)) {
                ref.context.showSignUpModal(ref);
                ref.read(isModalShownProvider.notifier).state = true;
              }
            });
          }
          if(response.success){
            ref.refresh(FeedPageViewModel.getAllCommentsProvider(postId));
          }
        },
        loadingState: LikeButtonState(isLoading: true),
        dataState: (data) {

          // ref
          //     .read(FeedPageViewModel.likedCommentsCountProvider.notifier)
          //     .update((state) {
          //   final currentLikes = state[commentId] ?? 0;
          //   return {...state, commentId: currentLikes + 1};
          // });
          return LikeButtonState(isLoading: false, data: data);
        });
  }

  Future<void> unlikeComment(String commentId, String postId, WidgetRef ref) async {
    await execute(
        () async {
          final response = await apiService.unlikeComment(commentId);
          if (response.code == 400) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ref.read(isModalShownProvider)) {
                ref.context.showSignUpModal(ref);
                ref.read(isModalShownProvider.notifier).state = true;
              }
            });
          }
          if(response.success){
            ref.refresh(FeedPageViewModel.getAllCommentsProvider(postId));
          }
        },
        loadingState: LikeButtonState(isLoading: true),
        dataState: (data) {
          ref
              .read(FeedPageViewModel.likedCommentsCountProvider.notifier)
              .update((state) {
            final currentLikes = state[commentId] ?? 0;
            return {...state, commentId: currentLikes - 1};
          });
          return LikeButtonState(isLoading: false, data: data);
        });
  }

  Future<void> likeReply(String commentId,String replyId, String postId, WidgetRef ref) async {
    await execute(
            () async {
          final response = await apiService.likeReply(commentId, replyId);
          if (response.code == 400) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ref.read(isModalShownProvider)) {
                ref.context.showSignUpModal(ref);
                ref.read(isModalShownProvider.notifier).state = true;
              }
            });
          }
          if(response.success){
            ref.refresh(FeedPageViewModel.getAllCommentsProvider(postId));
          }
        },
        loadingState: LikeButtonState(isLoading: true),
        dataState: (data) {
          ref
              .read(FeedPageViewModel.replyLikesCountProvider.notifier)
              .update((state) {
            final currentLikes = state[commentId] ?? 0;
            return {...state, commentId: currentLikes + 1};
          });
          return LikeButtonState(isLoading: false, data: data);
        });
  }
  Future<void> unlikeReply(String commentId,String replyId,String postId, WidgetRef ref) async {
    await execute(
            () async {
          final response = await apiService.unlikeReply(commentId, replyId);
          if (response.code == 400) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ref.read(isModalShownProvider)) {
                ref.context.showSignUpModal(ref);
                ref.read(isModalShownProvider.notifier).state = true;
              }
            });
          }
          if(response.success){
            ref.refresh(FeedPageViewModel.getAllCommentsProvider(postId));
          }
        },
        loadingState: LikeButtonState(isLoading: true),
        dataState: (data) {
          ref
              .read(FeedPageViewModel.replyLikesCountProvider.notifier)
              .update((state) {
            final currentLikes = state[commentId] ?? 0;
            return {...state, commentId: currentLikes + 1};
          });
          return LikeButtonState(isLoading: false, data: data);
        });
  }

  @override
  LikeButtonState errorState(dynamic error) {
    return LikeButtonState(isLoading: false, error: error.toString());
  }
}
