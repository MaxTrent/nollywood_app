import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/UI Actor/friends_page/friends_page.dart';
import 'package:nitoons/UI Actor/ui.dart';
import 'package:nitoons/UI%20Actor/profile_details/profile_details_vm.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';

import '../../gen/assets.gen.dart';

class ProfileDetails extends ConsumerWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ProfileDetailsViewModel(ref);

    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Stack(
            children: [
              Image.asset(
                Assets.png.profileplaceholder.path,
                height: 478.w,
                width: 380.w,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                // top: 50,
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
                        SizedBox(
                          height: 25.h,
                        ),
                        Text(
                          'Adesua Etomi Wellington',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 6.7.h,
                        ),
                        Text(
                          '@AdesuaEtomi',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 26.71.h,
                        ),
                        _buildUserMetric(context),
                        SizedBox(
                          height: 23.h,
                        ),
                        _buildActionButtons(viewModel),
                        SizedBox(
                          height: 31.68.h,
                        ),
                        Text(
                          'Profile',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Profile())),
                          child: Container(
                            height: 54.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: dividerColor, width: 1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 21.r,
                                        backgroundColor: Colors.grey,
                                      ),
                                      Text(
                                        ' @AdesuaEtomi',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w400),
                                      ),
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
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Text(
                          'Posts',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MonologueScreen())),
                          child: Container(
                            height: 54.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: dividerColor, width: 1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Monologues',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontWeight: FontWeight.w400),
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

  Row _buildActionButtons(ProfileDetailsViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppButton(
          width: 161,
          text: viewModel.followUserState.isLoading
              ? '...'
              : (viewModel.isFollowing ? 'Unfollow' : 'Follow'),
          backgroundColor: Colors.black,
          textColor: Colors.white,
          onPressed: viewModel.followUserState.isLoading ? null : () => viewModel.clickFollowButton(),
          height: 38,
        ),
        AppButton(
          width: 161,
          text: 'Message',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          height: 38,
        ),
      ],
    );
  }

  Widget _buildUserMetric(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Endorsements())),
            child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                    text: '162',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: '\nEndorsements',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: TextSizes.textSize12SP,
                                fontWeight: FontWeight.w400,
                                color: accentColor),
                      )
                    ])),
          ),
          AppVerticalDivider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FriendPage()));
            },
            child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                    text: '834',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: '\nFollowers',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: TextSizes.textSize12SP,
                                fontWeight: FontWeight.w400,
                                color: accentColor),
                      )
                    ])),
          ),
          AppVerticalDivider(),
          Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                  text: '54',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                      text: '\nPosts',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: TextSizes.textSize12SP,
                          fontWeight: FontWeight.w400,
                          color: accentColor),
                    )
                  ])),
        ],
      ),
    );
  }

  SafeArea _buildAppbarIcons(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset(Assets.svgs.back)),
            SvgPicture.asset(Assets.svgs.forward),
          ],
        ),
      ),
    );
  }
}

class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: 1.w,
      decoration: BoxDecoration(
        color: dividerColor,
      ),
    );
  }
}
