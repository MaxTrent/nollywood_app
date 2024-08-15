import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/constants/images.dart';
import 'package:shimmer/shimmer.dart';

import 'package:nitoons/UI Actor/friends_page/friends_page.dart';
import 'package:nitoons/UI Actor/ui.dart';
import 'package:nitoons/UI Producer/producer_endorsement/producer_endorsements.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/UI Actor/message_chat/messages_chat.dart';
import '../../constants/images.dart';
import '../../gen/assets.gen.dart';
import '../../models/get_user_profile_model.dart';
import '../choose_a_project/choose_a_project.dart';
import 'producer_profile_details_vm.dart';

class ProducerProfileDetails extends ConsumerWidget {
  final String profileId;

  const ProducerProfileDetails({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(
        ProducerProfileDetailsViewModel.getUserProfileProvider(profileId));
    final isFollowing =
        ref.watch(ProducerProfileDetailsViewModel.isFollowingProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Stack(
            children: [
              if (userProfile.asData?.value?.data != null)
                Image.network(
                  userProfile.asData!.value.data!.profilePicture ?? '',
                  height: 478.h,
                  width: 380.w,
                  fit: BoxFit.cover,
                )
              else
                Column(
                  children: [
                    _buildShimmerText(context, 478.h, 380.w),
                    Image.network(
                      'https://cvhrma.org/wp-content/uploads/2015/07/default-profile-photo.jpg',
                      height: 478.h,
                      width: 380.w,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 470.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                      bottomRight: Radius.circular(0.r),
                      bottomLeft: Radius.circular(0.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25.h),
                        userProfile.asData?.value?.data != null
                            ? Text(
                                '${userProfile.asData!.value.data!.lastName} ${userProfile.asData!.value!.data!.firstName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontWeight: FontWeight.w700),
                              )
                            : _buildShimmerText(context, 18.w, 100.w),
                        SizedBox(height: 6.7.h),
                        userProfile.asData?.value?.data != null
                            ? Text(
                                '@${userProfile.asData!.value!.data!.lastName}${userProfile.asData!.value!.data!.firstName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontWeight: FontWeight.w400),
                              )
                            : _buildShimmerText(context, 18.w, 100.w),
                        SizedBox(height: 26.71.h),
                        _buildUserMetric(context, userProfile),
                        SizedBox(height: 23.h),
                        _buildActionButtons(context, isFollowing),
                        SizedBox(height: 31.68.h),
                        Text(
                          'Profile',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 6.h),
                         
          Container(
            height: 54.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: dividerColor, width: 1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 21.r,
                        backgroundColor: Colors
                            .transparent, // Optional: set a background color if needed
                        child: ClipOval(
                          child: SizedBox(
                            width: 42
                                .r, // Diameter of the CircleAvatar (2 * radius)
                            height: 42.r,
                            child: userProfile.asData?.value.data != null
                                ? Image.network(
                                    userProfile
                                        .asData!.value.data!.profilePicture
                                        .toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      Assets.png.profilepic.path,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.network(
                                    'https://cvhrma.org/wp-content/uploads/2015/07/default-profile-photo.jpg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      userProfile.asData?.value?.data != null
                          ? Text(
                              '@${userProfile.asData!.value.data!.lastName}${userProfile.asData!.value.data!.firstName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontWeight: FontWeight.w400),
                            )
                          : _buildShimmerText(context, 18.w, 100.w),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
                        SizedBox(height: 22.h),
                        Text(
                          'Posts',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 6.h),
                        GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MonologueScreen())),
                                child: Container(
                                  height: 54.h,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: dividerColor, width: 1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Monologues',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildAppbarIcons(context),
        ],
      ),
    );
  }

  Widget _buildShimmerText(BuildContext context, double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  Row _buildActionButtons(BuildContext context, bool isFollowing) {
    final viewModel = ProducerProfileDetailsViewModel(context as WidgetRef);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppButton(
          text: isFollowing ? 'Follow' : 'Unfollow',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          height: 38,
          onPressed: () async {
            await viewModel.clickFollowButton();
          },
        ),
        AppButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ChooseAProject())),
          width: 130,
          text: 'Invite',
          backgroundColor: Colors.white,
          textColor: Colors.black,
          height: 38,
          borderColor: Colors.black,
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MessagesChat(
                    conversationId: '',
                    fullName: '',
                    profilePicture: '',
                  ))),
          child: Container(
            height: 38.h,
            width: 60.w,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 7.h),
              child: SvgPicture.asset(Assets.svgs.chat),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildUserMetric(
      BuildContext context, AsyncValue<GetUserProfileModel> userProfile) {
    return userProfile.when(
      data: (data) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Endorsements())),
                    child: data.data != null
                        ? Text(
                            data.data!.endorsements.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.w700),
                          )
                        : _buildShimmerText(context, 24.h, 50.w),
                  ),
                  Text(
                    'Endorsements',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              AppVerticalDivider(),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FriendPage())),
                    child: data.data != null
                        ? Text(
                            data.data!.followers.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.w700),
                          )
                        : _buildShimmerText(context, 24.h, 50.w),
                  ),
                  Text(
                    'Followers',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              AppVerticalDivider(),
              Column(
                children: [
                  data.data != null
                      ? Text(
                          data.data!.recentProjects.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        )
                      : _buildShimmerText(context, 24.h, 50.w),
                  Text(
                    'Posts',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => _buildShimmerText(context, 24.h, 50.w),
      loading: () => _buildShimmerText(context, 24.h, 50.w),
    );
  }

  Widget _buildAppbarIcons(BuildContext context) {
    return Positioned(
      top: 42.h,
      left: 24.w,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              Assets.svgs.back,
              height: 24.h,
              width: 24.w,
            ),
          ),
          SizedBox(width: 24.w),
        ],
      ),
    );
  }
}
