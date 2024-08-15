import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/account_setup/account_setup.dart';
import 'package:nitoons/UI%20Actor/nav_screens/feed_page/feed_page_vm.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/models/all_comments_model.dart';
import 'package:nitoons/models/get_timeline_posts_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../components/app_loading_indicator.dart';
import '../../../components/app_textfield.dart';
import '../../../data/app_storage.dart';
import '../../../gen/assets.gen.dart';
import '../../ui.dart';
import 'package:shimmer/shimmer.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  late FeedPageViewModel viewModel;
  late PageController _pageController;
  Map<int, double> _videoProgress = {};
  Map<int, VideoPlayerController> _videoControllers = {};
  Map<int, bool> _isPlaying = {};
  Map<int, VoidCallback> _videoListeners = {};

  @override
  void initState() {
    super.initState();
    viewModel = FeedPageViewModel(ref);
    viewModel.checkFirstTime();
    _pageController = PageController();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        int currentPage = _pageController.page!.round();
        _videoControllers.forEach((index, controller) {
          if ((index - currentPage).abs() > 1) {
            _disposeVideoController(index);
          } else if (index != currentPage) {
            controller.pause();
            _isPlaying[index] = false;
          } else {
            if (!controller.value.isPlaying) {
              controller.play();
              _isPlaying[index] = true;
            }
          }
        });
      }
    });
    viewModel.checkProfileCompletionStatus();
    viewModel.checkUserAuthentication();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoControllers.keys.toList().forEach((index) {
      _disposeVideoController(index);
    });
    _videoListeners.clear();
    super.dispose();
  }

  Future<void> _initializeVideo(int index, String videoUrl) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    _videoControllers[index] = controller;
    await controller.initialize();
    controller.setLooping(true);
    // controller.play();
    // if (!_isPlaying.containsKey(index)) {
    //   controller.play();
    //   _isPlaying[index] = true;
    // }
    // _videoControllers[index] = controller;

    if (_pageController.page == index) {
      controller.play();
      _isPlaying[index] = true;
    } else {
      _isPlaying[index] = false;
    }

    void listener() {
      if (mounted) {
        setState(() {
          _videoProgress[index] = controller.value.position.inMilliseconds /
              controller.value.duration.inMilliseconds;
          // print(_videoProgress[index]);
        });
      }
    }

    controller.addListener(listener);
    _videoListeners[index] = listener;

    if (mounted) setState(() {});
    // setState(() {
    //   _videoControllers[index] = controller;
    // });
  }

  void _disposeVideoController(int index) {
    final controller = _videoControllers[index];
    final listener = _videoListeners[index];
    if (controller != null && listener != null) {
      controller.removeListener(listener);
      controller.dispose();
    }
    _videoControllers.remove(index);
    _videoListeners.remove(index);
    _isPlaying.remove(index);
    _videoProgress.remove(index);
  }

  void _togglePlayPause(int index) {
    final controller = _videoControllers[index];
    if (controller != null) {
      if (_isPlaying[index]!) {
        controller.pause();
      } else {
        controller.play();
      }
      _isPlaying[index] = !_isPlaying[index]!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final timelinePosts = ref.watch(FeedPageViewModel.getTimelinePostsProvider);

    // ref.refresh(FeedPageViewModel.getTimelinePostsProvider);
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Stack(
        children: [
          timelinePosts.when(data: (data) {
            return GestureDetector(
              onDoubleTapDown: (details) => viewModel.handleDoubleTap(details),
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: data.data.results.length,
                itemBuilder: (context, index) {
                  final videoUrl = data.data.results[index].mediaUpload!;
                  if (!_videoControllers.containsKey(index)) {
                    _initializeVideo(index, videoUrl);
                  }
                  final controller = _videoControllers[index];
                  return VisibilityDetector(
                    key: Key('video-$index'),
                    onVisibilityChanged: (visibilityInfo) {
                      if (visibilityInfo.visibleFraction == 0) {
                        controller?.pause();
                        _isPlaying[index] = false;
                        if ((index - _pageController.page!).abs() > 1) {
                          _disposeVideoController(index);
                        }
                      } else if (visibilityInfo.visibleFraction == 1) {
                        controller?.play();
                        _isPlaying[index] = true;
                      }
                    },
                    child: Stack(
                      children: [
                        if (controller != null &&
                            controller.value.isInitialized)
                          GestureDetector(
                            onTap: () => _togglePlayPause(index),
                            child: Container(
                              width: double.infinity,
                              // Fill the width of the screen
                              height: double.infinity,
                              // aspectRatio: controller.value.aspectRatio,
                              child: VideoPlayer(controller),
                            ),
                          )
                        else
                          Center(child: CircularProgressIndicator()),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 17.h,
                              child: SizedBox(
                                height: 2.h,
                                width: 350.w,
                                child: LinearProgressIndicator(
                                  value: _videoProgress[index] ?? 0.0,
                                  backgroundColor: Colors.grey[300],
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.red),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 35.h,
                              left: 10.w,
                              child: buildVideoDetails(context, ref, index),
                            ),
                            Positioned(
                              right: 12.w,
                              bottom: 22.h,
                              child: buildFeedActions(
                                  context, viewModel, ref, index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }, error: (error, _) {
            AppUtils.debug(error.toString());
            AppUtils.debug(_.toString());
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.black54,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
            );
          }, loading: () {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.black54,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
            );
          }),
          SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: 23.w, right: 14.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/account_setup");
                    },
                    child: Text(
                      'Discover',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Search())),
                    child: SvgPicture.asset(Assets.svgs.search),
                  ),
                ],
              ),
            ),
          ),
          if (!viewModel.isComplete)
            buildIncompleteProfileDialog(viewModel, context),
          if (viewModel.showOverlay)
            Dismissible(
              direction: DismissDirection.up,
              onDismissed: (direction) {
                viewModel.removeOverlay();
              },
              key: Key('overlay'),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.svgs.swipe),
                      Text(
                        'Swipe up to start',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (viewModel.showTempIcon)
            Positioned(
              left: viewModel.tempIconPosition.dx,
              top: viewModel.tempIconPosition.dy,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: SvgPicture.asset(
                  Assets.svgs.likeBig,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildIncompleteProfileDialog(
      FeedPageViewModel viewModel, BuildContext context) {
    return FutureBuilder<bool>(
      future: SecureStorageHelper.isAuthenticated(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data == false) {
          return SizedBox.shrink();
        } else {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 38.h,
                decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.h),
                  child: Row(
                    children: [
                      Container(
                        height: 18.h,
                        width: 18.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(1000.r),
                        ),
                        child: Center(
                          child: Text(
                            '40%',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontSize: 5.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Profile incomplete',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                      ),
                      SizedBox(width: 17.w),
                      buildCompleteSetupButton(context),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          viewModel.removeSnackBar();
                        },
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  ElevatedButton buildCompleteSetupButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all(selectColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AccountSetup()),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.5.h),
        child: Text(
          'Click here to complete your setup',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 8.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


Widget buildVideoDetails(BuildContext context, WidgetRef ref, int index) {
  final timelinePosts = ref.watch(FeedPageViewModel.getTimelinePostsProvider);
  return timelinePosts.when(data: (data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // '@AdesuaEtomi',

          '@${data.data!.results[index].userProfile?.firstName ?? ''}${data.data!.results[index].userProfile?.lastName ?? ''}',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Colors.white),
        ),
        Text(
          data.data!.results[index].description.toString(),
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }, error: (error, _) {
    AppUtils.debug(error.toString());
    AppUtils.debug(_.toString());
    return Text(
      error.toString(),
      style: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(color: Colors.white),
    );
  }, loading: () {
    return SizedBox(
      height: 40.h,
      width: 280.w,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.black87,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
        ),
      ),
    );
  });
}

Widget buildFeedActions(BuildContext context, FeedPageViewModel viewModel,
    WidgetRef ref, int index) {
  final timelinePosts = ref.watch(FeedPageViewModel.getTimelinePostsProvider);
  return timelinePosts.when(data: (data) {
    final postId = data.data.results[index].id;

    print(data.data.results[index].isLikedByYou);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileDetails())),
                child: buildProfilePicture(data, index)),

            // data.data.results[index].userProfile?.profilePicture !=
            //         null
            //     ? Image.network(data.data.results[index]
            //         .userProfile!.profilePicture)
            //     :
            // Image.asset(Assets.svgs.profile)
            // )),
            Positioned(
              top: 30,
              child: GestureDetector(
                onTap: viewModel.followUserState.isLoading
                    ? null
                    : () => viewModel.clickFollowButton(),
                child: Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                      color: Color(0xffFE2C55),
                      borderRadius: BorderRadius.circular(30.r)),
                  child: viewModel.followUserState.isLoading
                      ? Padding(
                          padding: EdgeInsets.all(4.h),
                          child: AppLoadingIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          viewModel.isFollowing ? Icons.check : Icons.add,
                          color: Colors.white,
                          size: 14,
                        ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 24.h),
        Column(
          children: [
            GestureDetector(
              onTap: viewModel.likeState.isLoading ? null : () {
                data.data.results[index].isLikedByYou?viewModel.unlikePost(postId) : viewModel.likePost(postId);
                ref.refresh(FeedPageViewModel.getTimelinePostsProvider);
              },
              child: data.data.results[index].isLikedByYou ? SvgPicture.asset(
                  Assets.svgs.likeSmall):SvgPicture.asset(
                  Assets.svgs.like),
            ),
            SizedBox(height: 6.h),
            Text(
              // '154',
              // viewModel.postLikesCount[postId].toString(),
              data.data.results[index].likes.toString(),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 12.sp, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Column(
          children: [
            GestureDetector(
                onTap: () {
                  buildCommentSection(context, ref, postId);
                },
                child: SvgPicture.asset(Assets.svgs.comment)),
            SizedBox(height: 6.h),
            Text(
              // '154',
              data.data.results[index].comments.toString(),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 12.sp, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Column(
          children: [
            SvgPicture.asset(Assets.svgs.share),
            SizedBox(height: 6.h),
            Text(
              '0',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 12.sp, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }, error: (error, _) {
    return Container();
  }, loading: () {
    return Container();
  });
}

CircleAvatar buildProfilePicture(GetTimePostsModel profilePictureUrl, int index) {
  return CircleAvatar(
    radius: 21.r,
    backgroundImage: NetworkImage(
        profilePictureUrl.data.results[index].userProfile?.profilePicture ??
            'https://www.example.com/default_profile_picture.png'),
    onBackgroundImageError: (_, __) => Image.asset(Assets.png.profilepic.path),
  );
}

void buildCommentSection(BuildContext context, WidgetRef ref, String postId) {
  final _formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        height: 447.h,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.16.r),
            topRight: Radius.circular(7.16.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Form(
              key: _formKey,
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: CommentSectionContent(postId: postId))),
        ),
      );
    },
  );
}
// Future buildCommentSection(
//     BuildContext context, WidgetRef ref, String postId) {
//   final comments = ref.watch(FeedPageViewModel.getAllCommentsProvider(postId));
//
//   return comments.when(data: (comment) {
//     if (comment.data!.isEmpty) {
//       print("No comments available for post ID $postId");
//       return showModalBottomSheet(
//           backgroundColor: Colors.transparent,
//           context: context,
//           builder: (context) => Container(
//               height: 447.h,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(7.16.r),
//                     topRight: Radius.circular(7.16.r),
//                   )),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w),
//                 child: Text('No comments',
//                     style: Theme.of(context).textTheme.displaySmall!.copyWith(
//                         fontSize: TextSizes.textSize12SP,
//                         fontWeight: FontWeight.w600)),
//               )));
//     } else {
//       print("Displaying ${comment.data!.length} comments for post ID $postId");
//
//       return showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         context: context,
//         builder: (context) =>
//             Container(
//               height: 447.h,
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(7.16.r),
//                     topRight: Radius.circular(7.16.r),
//                   )),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 10.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox.shrink(),
//                         Text(
//                           // '4 comments',
//                             '${comment.data!.length} comments',
//                             style: Theme
//                                 .of(context)
//                                 .textTheme
//                                 .displaySmall!
//                                 .copyWith(
//                                 fontSize: TextSizes.textSize12SP,
//                                 fontWeight: FontWeight.w600)),
//                         GestureDetector(
//                             onTap: () => Navigator.pop(context),
//                             child: Icon(Icons.close)),
//                       ],
//                     ),
//                     SizedBox(height: 18.h),
//                     Expanded(
//                         child: ListView.builder(
//                             itemCount: comment.data!.length,
//                             itemBuilder: (context, index) {
//                               final commentData = comment.data![index];
//                               final commentMadeAt = commentData.createdAt;
//
//                               final formattedcommentMadeAt =
//                               timeago.format(commentMadeAt);
//
//                               return Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment
//                                     .spaceBetween,
//                                 children: [
//                                   CircleAvatar(radius: 15.r),
//                                   Expanded(
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                           left: 11.19.w, right: 17.45.w),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                               commentData.isProducer
//                                                   ? '${commentData
//                                                   .userName} Producer'
//                                                   : commentData.userName,
//                                               // 'someone·Producer',
//                                               style: Theme
//                                                   .of(context)
//                                                   .textTheme
//                                                   .displaySmall!
//                                                   .copyWith(
//                                                   fontSize:
//                                                   TextSizes.textSize10SP,
//                                                   fontWeight: FontWeight.w700,
//                                                   color: likeCountColor)),
//                                           Text(
//                                             // 'Mauris sed eget nunc lacus velit amet vel.. Mauris sed eget n',
//                                             commentData.comment,
//                                             style: Theme
//                                                 .of(context)
//                                                 .textTheme
//                                                 .displaySmall,
//                                           ),
//                                           Text.rich(TextSpan(
//                                               text: formattedcommentMadeAt,
//                                               style: Theme
//                                                   .of(context)
//                                                   .textTheme
//                                                   .displaySmall!
//                                                   .copyWith(
//                                                   fontSize:
//                                                   TextSizes.textSize12SP,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: likeCountColor),
//                                               children: [
//                                                 TextSpan(
//                                                   text: ' Reply',
//                                                   style: Theme
//                                                       .of(context)
//                                                       .textTheme
//                                                       .displaySmall!
//                                                       .copyWith(
//                                                       fontSize: TextSizes
//                                                           .textSize12SP,
//                                                       fontWeight:
//                                                       FontWeight.w600,
//                                                       color: likeCountColor),
//                                                 )
//                                               ])),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset(Assets.svgs.heart),
//                                       Text('0',
//                                           style: Theme
//                                               .of(context)
//                                               .textTheme
//                                               .displaySmall!
//                                               .copyWith(
//                                               fontSize: TextSizes.textSize12SP,
//                                               fontWeight: FontWeight.w400,
//                                               color: likeCountColor))
//                                     ],
//                                   )
//                                 ],
//                               );
//                             })),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CircleAvatar(radius: 15.r),
//                         Expanded(
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: 11.19.w, right: 17.45.w),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('someone·Producer',
//                                     style: Theme
//                                         .of(context)
//                                         .textTheme
//                                         .displaySmall!
//                                         .copyWith(
//                                         fontSize: TextSizes.textSize10SP,
//                                         fontWeight: FontWeight.w700,
//                                         color: likeCountColor)),
//                                 Text(
//                                   'Mauris sed eget nunc lacus velit amet vel.. Mauris sed eget n',
//                                   style: Theme
//                                       .of(context)
//                                       .textTheme
//                                       .displaySmall,
//                                 ),
//                                 Text.rich(TextSpan(
//                                     text: '5h',
//                                     style: Theme
//                                         .of(context)
//                                         .textTheme
//                                         .displaySmall!
//                                         .copyWith(
//                                         fontSize: TextSizes.textSize12SP,
//                                         fontWeight: FontWeight.w400,
//                                         color: likeCountColor),
//                                     children: [
//                                       TextSpan(
//                                         text: ' Reply',
//                                         style: Theme
//                                             .of(context)
//                                             .textTheme
//                                             .displaySmall!
//                                             .copyWith(
//                                             fontSize: TextSizes.textSize12SP,
//                                             fontWeight: FontWeight.w600,
//                                             color: likeCountColor),
//                                       )
//                                     ])),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             SvgPicture.asset(Assets.svgs.heart),
//                             Text('0',
//                                 style: Theme
//                                     .of(context)
//                                     .textTheme
//                                     .displaySmall!
//                                     .copyWith(
//                                     fontSize: TextSizes.textSize12SP,
//                                     fontWeight: FontWeight.w400,
//                                     color: likeCountColor))
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//       );
//     }
//   }, error: (error, _) {
//     print("Error fetching comments for post ID $postId: $error");
//     return showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) => Container(
//         height: 447.h,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(7.16.r),
//               topRight: Radius.circular(7.16.r),
//             )),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12.w),
//           child: Text(error.toString(),
//               style: Theme.of(context).textTheme.displaySmall!.copyWith(
//                   fontSize: TextSizes.textSize12SP,
//                   fontWeight: FontWeight.w600)),
//         ),
//       ),
//     );
//   }, loading: () {
//     print("Loading comments for post ID $postId");
//     return showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) => Container(
//         height: 447.h,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(7.16.r),
//               topRight: Radius.circular(7.16.r),
//             )),
//         child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 12.w),
//             child: Center(
//               child: AppLoadingIndicator(),
//             )),
//       ),
//     );
//   });
//
//   return showModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     context: context,
//     builder: (context) => Container(
//       height: 447.h,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(7.16.r),
//             topRight: Radius.circular(7.16.r),
//           )),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 12.w),
//         child: Column(
//           children: [
//             SizedBox(height: 10.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox.shrink(),
//                 Text('4 comments',
//                     style: Theme.of(context).textTheme.displaySmall!.copyWith(
//                         fontSize: TextSizes.textSize12SP,
//                         fontWeight: FontWeight.w600)),
//                 GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Icon(Icons.close)),
//               ],
//             ),
//             SizedBox(height: 18.h),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CircleAvatar(radius: 15.r),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 11.19.w, right: 17.45.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('someone·Producer',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displaySmall!
//                                 .copyWith(
//                                     fontSize: TextSizes.textSize10SP,
//                                     fontWeight: FontWeight.w700,
//                                     color: likeCountColor)),
//                         Text(
//                           'Mauris sed eget nunc lacus velit amet vel.. Mauris sed eget n',
//                           style: Theme.of(context).textTheme.displaySmall,
//                         ),
//                         Text.rich(TextSpan(
//                             text: '5h',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displaySmall!
//                                 .copyWith(
//                                     fontSize: TextSizes.textSize12SP,
//                                     fontWeight: FontWeight.w400,
//                                     color: likeCountColor),
//                             children: [
//                               TextSpan(
//                                 text: ' Reply',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .displaySmall!
//                                     .copyWith(
//                                         fontSize: TextSizes.textSize12SP,
//                                         fontWeight: FontWeight.w600,
//                                         color: likeCountColor),
//                               )
//                             ])),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     SvgPicture.asset(Assets.svgs.heart),
//                     Text('0',
//                         style: Theme.of(context)
//                             .textTheme
//                             .displaySmall!
//                             .copyWith(
//                                 fontSize: TextSizes.textSize12SP,
//                                 fontWeight: FontWeight.w400,
//                                 color: likeCountColor))
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}

class CommentSectionContent extends ConsumerWidget {
  final String postId;

  const CommentSectionContent({Key? key, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = FeedPageViewModel(ref);
    final comments =
    ref.watch(FeedPageViewModel.getAllCommentsProvider(postId));

    return comments.when(
      data: (comment) {
        if (comment.data == null || comment.data!.isEmpty) {
          print("No comments available for post ID $postId");
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text('No comments',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w600)),
                  ),
                  buildMakeCommentsWidgets(viewModel, comment),
                  SizedBox(height: 5.h),
                ]),
          );
        } else {
          print(
              "Displaying ${comment.data!.length} comments for post ID $postId");
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    Text(
                      // '4 comments',
                        '${comment.data!.length} comments',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                            fontSize: TextSizes.textSize12SP,
                            fontWeight: FontWeight.w600)),
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close)),
                  ],
                ),
                SizedBox(height: 18.h),
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                          itemCount: comment.data!.length,
                          itemBuilder: (context, index) {
                            final commentData = comment.data![index];
                            final commentMadeAt = commentData.createdAt;

                            final formattedcommentMadeAt =
                            timeago.format(commentMadeAt);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommentWidget(
                                    commentData: commentData,
                                    formattedcommentMadeAt:
                                    formattedcommentMadeAt,
                                    viewModel: viewModel,
                                    postId: postId),
                                commentData.replies.isEmpty
                                    ? SizedBox()
                                    : SizedBox(
                                  height: 2.h,
                                ),
                                if (viewModel.visibleReplies
                                    .contains(commentData.id))
                                  ...commentData.replies.map((reply) => Padding(
                                    padding: EdgeInsets.only(left: 16.w),
                                    child: ReplyWidget(
                                        replyData: reply,
                                        commentData: commentData,
                                        formattedcommentMadeAt:
                                        formattedcommentMadeAt,
                                        viewModel: viewModel,
                                        postId: postId
                                    ),
                                  )),
                                // TextButton(
                                //   onPressed: () =>
                                //       viewModel.focusReplyField(commentData.id),
                                //   child: Text('Reply'),
                                // ),
                                commentData.replies.isEmpty
                                    ? SizedBox()
                                    : TextButton(
                                  onPressed: () => viewModel
                                      .toggleReplies(commentData.id),
                                  child: Text(
                                      viewModel.visibleReplies
                                          .contains(commentData.id)
                                          ? 'Hide Replies'
                                          : 'View Replies (${commentData.replies.length})',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                          fontSize:
                                          TextSizes.textSize12SP,
                                          fontWeight: FontWeight.w600,
                                          color: likeCountColor)),
                                ),
                                SizedBox(
                                  height: 22.h,
                                )
                              ],
                            );
                          }),
                      buildMakeCommentsWidgets(viewModel, comment)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
      error: (error, _) {
        print("Error fetching comments for post ID $postId: $error");
        print(_);
        return Container(
          height: 447.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7.16.r),
                topRight: Radius.circular(7.16.r),
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(error.toString(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: TextSizes.textSize12SP,
                    fontWeight: FontWeight.w600)),
          ),
        );
      },
      loading: () => Center(child: AppLoadingIndicator()),
    );
  }

  Positioned buildMakeCommentsWidgets(
      FeedPageViewModel viewModel, CommentsResponseModel commentData) {
    return Positioned(
      bottom: 5.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 14.r,
              child:
              // Image.asset(Assets.png.profilepic.path),
              Image.network(
                  commentData.data?.first.thumbnailUrl ??
                      'default_image_url.png',

                  // 'https://www.example.com/default_profile_picture.png',
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset(Assets.png.profilepic.path))),
          SizedBox(
            width: 2.w,
          ),
          AppTextField(
            focusNode: viewModel.commentFocusNode,
            width: 280,
            fillColor: Color(0xffF1F1F3),
            filled: true,
            controller: viewModel.commentController,
            height: 35,
            hintText: viewModel.isReplying
                ? 'Write a reply...'
                : 'Write a comment...',
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
              child: SizedBox(
                width: 80.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(Assets.svgs.aticon),
                    SizedBox(
                      width: 1.w,
                    ),
                    SvgPicture.asset(Assets.svgs.smiley),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          GestureDetector(
              onTap: () => viewModel.makeCommentOrReply(postId),
              child: SvgPicture.asset(
                Assets.svgs.sendcomment,
                height: 25.h,
                width: 25.h,
              )),
        ],
      ),
    );
  }
}

class CommentWidget extends ConsumerWidget {
  CommentWidget({
    super.key,
    required this.commentData,
    required this.formattedcommentMadeAt,
    required this.viewModel,
    required this.postId,
  });

  final CommentModel commentData;
  final String formattedcommentMadeAt;
  final FeedPageViewModel viewModel;
  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = viewModel.likedComments[commentData.id] ?? false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 15.r),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 11.19.w, right: 17.45.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    commentData.isProducer
                        ? '${commentData.userName} Producer'
                        : commentData.userName,
                    // 'someone·Producer',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: TextSizes.textSize10SP,
                        fontWeight: FontWeight.w700,
                        color: likeCountColor)),
                Text(
                  // 'Mauris sed eget nunc lacus velit amet vel.. Mauris sed eget n',
                  commentData.comment,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      formattedcommentMadeAt,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: TextSizes.textSize12SP,
                          fontWeight: FontWeight.w400,
                          color: likeCountColor),
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.focusReplyField();
                        ref
                            .read(FeedPageViewModel.isReplyingProvider.notifier)
                            .state = true;
                        ref
                            .read(FeedPageViewModel
                            .replyingToCommentIdProvider.notifier)
                            .state = commentData.id;
                      },
                      child: Text(' Reply',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                              fontSize: TextSizes.textSize12SP,
                              fontWeight: FontWeight.w600,
                              color: likeCountColor)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: viewModel.likeState.isLoading ? null :() {
                commentData.isLikedByYou
                    ? viewModel.unlikeComment(commentData.id, postId)
                    : viewModel.likeComment(commentData.id, postId);
                ref.refresh(FeedPageViewModel.getAllCommentsProvider(postId));

              },
              child: commentData.isLikedByYou
                  ? SvgPicture.asset(Assets.svgs.heart,
                  colorFilter:
                  ColorFilter.mode(Colors.red, BlendMode.srcIn))
                  : SvgPicture.asset(Assets.svgs.heart),
            ),
            Text(
              // viewModel.commentLikesCount[commentData.id].toString(),
                commentData.likes.toString(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: TextSizes.textSize12SP,
                    fontWeight: FontWeight.w400,
                    color: likeCountColor))
          ],
        )
      ],
    );
  }
}

class ReplyWidget extends ConsumerWidget {
  ReplyWidget({
    super.key,
    required this.replyData,
    required this.commentData,
    required this.formattedcommentMadeAt,
    required this.viewModel,
    required this.postId,
  });

  final ReplyModel replyData;
  final CommentModel commentData;
  final String formattedcommentMadeAt;
  final FeedPageViewModel viewModel;
  final String postId;

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 15.r),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 11.19.w, right: 17.45.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    replyData.isProducer
                        ? '${replyData.userName} Producer'
                        : replyData.userName,
                    // 'someone·Producer',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: TextSizes.textSize10SP,
                        fontWeight: FontWeight.w700,
                        color: likeCountColor)),
                Text(
                  // 'Mauris sed eget nunc lacus velit amet vel.. Mauris sed eget n',
                  replyData.reply,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      formattedcommentMadeAt,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: TextSizes.textSize12SP,
                          fontWeight: FontWeight.w400,
                          color: likeCountColor),
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.focusReplyField();
                        ref
                            .read(FeedPageViewModel.isReplyingProvider.notifier)
                            .state = true;
                        ref
                            .read(FeedPageViewModel
                            .replyingToCommentIdProvider.notifier)
                            .state = commentData.id;
                      },
                      child: Text(' Reply',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                              fontSize: TextSizes.textSize12SP,
                              fontWeight: FontWeight.w600,
                              color: likeCountColor)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: viewModel.likeState.isLoading ? null : () {
                replyData.isLikedByYou
                    ? viewModel.unlikeReply(commentData.id, replyData.id, postId)
                    : viewModel.likeReply(commentData.id,replyData.id, postId);
                ref.refresh(FeedPageViewModel.getAllCommentsProvider(postId));
              },
              child: replyData.isLikedByYou
                  ? SvgPicture.asset(
                Assets.svgs.heart,
                colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
              )
                  : SvgPicture.asset(Assets.svgs.heart),
            ),
            Text(
              // viewModel.replyLikesCount[replyData.id].toString(),
                replyData.likes.toString(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: TextSizes.textSize12SP,
                    fontWeight: FontWeight.w400,
                    color: likeCountColor))
          ],
        )
      ],
    );
  }
}

