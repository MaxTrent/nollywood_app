import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/UI%20Actor/account_setup/account_setup_vm.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/models/all_comments_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../utilities/base_notifier.dart';
import '../../../utilities/base_state.dart';

import '../../../data/app_storage.dart';

class ProducerFeedPageViewModel extends AccountSetupViewModel{
  final WidgetRef ref;

  ProducerFeedPageViewModel(this.ref);

  static final incompleteSnackProvider =
      StateProvider.autoDispose((ref) => true);

  static final tempIconPositionProvider = StateProvider((ref) => Offset.zero);
  static final isLikedProvider = StateProvider((ref) => false);
  static final showTempIconProvider = StateProvider((ref) => false);
  static final getTimelinePostsProvider = FutureProvider((ref) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getTimelinePosts();
  });

  Offset get tempIconPosition => ref.watch(tempIconPositionProvider);

  bool get showTempIcon => ref.watch(showTempIconProvider);

  bool get isLiked => ref.watch(isLikedProvider);

  // FutureProvider get getTimelinePosts => ref.watch(getTimelinePostsProvider.future);

  void handleDoubleTap(TapDownDetails details) {
    ref.read(showTempIconProvider.notifier).state = true;
    ref.read(isLikedProvider.notifier).state = true;
    ref.read(tempIconPositionProvider.notifier).state = details.globalPosition;

    Future.delayed(Duration(milliseconds: 500), () {
      ref.read(showTempIconProvider.notifier).state = false;
    });
  }

  static final isFirstTimeProvider = StateProvider((ref) => true);
  static final showOverlayProvider = StateProvider((ref) => true);

  bool get incompleteSnackBar => ref.watch(incompleteSnackProvider);

  bool removeSnackBar() =>
      ref.read(incompleteSnackProvider.notifier).state = false;

  bool get isFirstTime => ref.watch(isFirstTimeProvider);

  bool get showOverlay => ref.watch(showOverlayProvider);

  bool likeButtonToggle() => ref.read(isLikedProvider.notifier).state =
      !ref.read(isLikedProvider.notifier).state;

  bool removeOverlay() => ref.read(showOverlayProvider.notifier).state = false;
TextEditingController get commentController => ref.watch(commentControllerProvider);
  String get commentText => ref.watch(commentControllerProvider).text;

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
      ref.read(showOverlayProvider.notifier).state = false;
    }

    ref.read(isFirstTimeProvider.notifier).state = prefs.getBool('first_time')!;
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

static final makeCommentNotifierProvider =
  StateNotifierProvider<MakeCommentNotifier,
      MakeCommentState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    final navigatorKey = ref.read(navigatorKeyProvider);
    return MakeCommentNotifier(
      apiService,
          () {
        navigatorKey.currentState?.pop();
      },
    );
  });

  static final getAllCommentsProvider = FutureProvider.family.autoDispose
      <CommentsResponseModel, String>((ref, postId) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getAllComments(postId);
  });



  static final isReplyingProvider = StateProvider<bool>((ref) => false);
  static final likedCommentsProvider = StateProvider<Map<String, bool>>((ref)=> {});
  static final replyingToCommentIdProvider = StateProvider<String?>((ref) => null);
  static final visibleRepliesProvider = StateProvider<Set<String>>((ref) => {});


static final likeButtonNotifierProvider = StateNotifierProvider<LikeButtonNotifier, LikeButtonState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return LikeButtonNotifier(
    apiService,
        () {
    },
  );
});
 
  bool get isReplying => ref.watch(isReplyingProvider);

  // Future get toggleLike => ref.watch(toggleLikeProvider);

  Map<String, bool> get likedComments => ref.watch(likedCommentsProvider);
  String? get replyingToCommentId => ref.watch(replyingToCommentIdProvider);
  Set<String> get visibleReplies => ref.watch(visibleRepliesProvider);
 
  // FutureProvider get getTimelinePosts => ref.watch(getTimelinePostsProvider.future);


  // Future<void> toggleLikeButton(String commentId) async {
  //
  //   ref
  //       .read(likeButtonNotifierProvider.notifier)
  //       .likeComment(commentId);
  // }

  static final commentControllerProvider = Provider.autoDispose((ref)=> TextEditingController());
  static final commentFocusNodeProvider = Provider.autoDispose((ref) => FocusNode());


  FocusNode get commentFocusNode => ref.watch(commentFocusNodeProvider);
 


  Future<void> toggleLikeButton(String commentId) async {
    final currentState = ref.read(likedCommentsProvider)[commentId] ?? false;
    if (currentState) {
      await ref.read(likeButtonNotifierProvider.notifier).unlikeComment(commentId);
    } else {
      await ref.read(likeButtonNotifierProvider.notifier).likeComment(commentId);
    }
    // Toggle the liked state in the provider after the operation
    ref.read(likedCommentsProvider.notifier).update((state) => {
      ...state,
      commentId: !currentState
    });
  }


  void toggleReplies(String commentId) {
    final currentVisibleReplies = Set<String>.from(visibleReplies);
    if (currentVisibleReplies.contains(commentId)) {
      currentVisibleReplies.remove(commentId);
    } else {
      currentVisibleReplies.add(commentId);
    }
    ref.read(visibleRepliesProvider.notifier).state = currentVisibleReplies;
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
      ref.read(isReplyingProvider.notifier).state = false;
      ref.refresh(getAllCommentsProvider(postId));
    }
  }
  
  Future<void> makeComment(String postId) async {
    if (commentText.isNotEmpty) {
      await ref
          .read(makeCommentNotifierProvider.notifier)
          .makeComment(postId, commentText);
      commentController.clear();
      ref.refresh(getAllCommentsProvider(postId));
      // scrollController.animateTo(
      //   scrollController.position.minScrollExtent,
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );

      // scrollController.animateTo(0.0,
      //     duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
    }
  }

  Future<void> addReplyToComment(String commentId, String replyContent) async {
   await ref
        .read(makeCommentNotifierProvider.notifier)
        .addReply(commentId, replyContent);
  }


  }


class MakeCommentState extends BaseState {
  final List<CommentModel> comments;

  MakeCommentState({required bool isLoading, required this.comments, String? error})
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
  }}


class MakeCommentNotifier
    extends BaseNotifier<MakeCommentState> {
  MakeCommentNotifier(ApiServices apiService, VoidCallback onSuccess)
      : super(
      apiService, onSuccess, MakeCommentState(isLoading: false, comments: []));

  Future<void> makeComment(String postId,String comment) async {
    await execute(
          () async {
        final response = await apiService.makeComment(postId, comment);
        if (response.success && response.data != null) {
          final newComments = CommentModel.fromJson(response.data);
          final updatedComments = [...state.comments, newComments];
          return updatedComments;
        } else {
          throw Exception('Failed to send comments');
        }},
      loadingState: MakeCommentState(isLoading: true, comments: state.comments),
      dataState: (data) =>
          MakeCommentState(isLoading: false, comments: data),
    );
  }

  Future<void> addReply(String commentId, String reply) async {
    await execute(
          () async {
        final response = await apiService.addReply(commentId, reply);
        if (response.success && response.data != null) {
          final updatedComments = [...state.comments];
          final commentIndex = updatedComments.indexWhere((c) => c.id == commentId);
          if (commentIndex != -1) {
            updatedComments[commentIndex].replies.add(ReplyModel.fromJson(response.data));
          }
          return updatedComments;
        } else {
          throw Exception('Failed to add reply');
        }},
      loadingState: MakeCommentState(isLoading: true, comments: state.comments),
      dataState: (data) =>
          MakeCommentState(isLoading: false, comments: data),
    );
  }



  @override
  MakeCommentState errorState(dynamic error) {
    return MakeCommentState(isLoading: false, comments: state.comments, error: error.toString());
  }
}




class LikeButtonState extends BaseState {
  final dynamic data;

  LikeButtonState({required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);

}


class LikeButtonNotifier
    extends BaseNotifier<LikeButtonState> {
  LikeButtonNotifier(ApiServices apiService, VoidCallback onSuccess)
      : super(
      apiService, onSuccess, LikeButtonState(isLoading: false));

  Future<void> likeComment(String commentId) async {
    await execute(
          () async {
            await apiService.likeComment(commentId);
          },
      loadingState: LikeButtonState(isLoading: true),
      dataState: (data) =>
          LikeButtonState(isLoading: false, data: data),
    );
  }
  Future<void> unlikeComment(String commentId) async {
    await execute(
          () async {
        await apiService.unlikeComment(commentId);
      },
      loadingState: LikeButtonState(isLoading: true),
      dataState: (data) =>
          LikeButtonState(isLoading: false, data: data),
    );
  }



  @override
  LikeButtonState errorState(dynamic error) {
    return LikeButtonState(isLoading: false, error: error.toString());
  }
}






// bool isAuthenticated = await SecureStorageHelper.isAuthenticated();
//     if (!isAuthenticated) {
//       return;
//     } else {
//       await accountPages(); // ensure _accountList is populated
//       await checkProfileCompletion();
//     }