import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI Actor/profile.dart';
import 'package:nitoons/UI Actor/profile_card.dart';
import 'package:nitoons/UI%20Actor/SignUp/sign_up.dart';
import 'package:nitoons/UI%20Actor/home_page.dart';
import 'package:nitoons/UI%20Actor/roles/roles.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:shimmer/shimmer.dart';

import '../components/app_button.dart';
import '../components/app_verticaldivider.dart';
import '../constants/app_colors.dart';
import '../constants/sizes.dart';
import '../constants/spacings.dart';
import '../data/app_storage.dart';
import '../gen/assets.gen.dart';
import '../widgets/base_text.dart';
import '../widgets/main_button.dart';
import 'actor_profile_viewmodel.dart';
import 'edit_actor_profile/edit_actor_profile.dart';
import 'endorsements/endorsements.dart';
import 'monologue_screen.dart';
import 'profile/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> _isAuthenticatedFuture =
        SecureStorageHelper.isAuthenticated(); // Authentication future

    return FutureBuilder<bool>(
        future: _isAuthenticatedFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: BaseText(
                  'Login',
                  color: black,
                  fontSize: TextSizes.textSize16SP,
                  fontWeight: FontWeight.w600,
                ),
                elevation: 1,
              ),
              body: Center(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.perm_identity_outlined,
                      color: textNotActive,
                      size: IconSizes.largestIconSize,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BaseText(
                      'Login to access this resource',
                      fontWeight: FontWeight.w600,
                      fontSize: TextSizes.textSize16SP,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Spacings.spacing70.w),
                      child: MainButton(
                        text: 'Login',
                        buttonColor: black,
                        textColor: white,
                        press: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                            (route) => false,
                          );
                        },
                      ),
                    )
                  ],
                ),
              )),
            ); // Show the login screen if not authenticated
          }

          return MVVM<ActorProfileViewmodel>.builder(
              disposeVM: false,
              viewModel: locator<ActorProfileViewmodel>(),
              viewBuilder: (_, viewModel) {
                return Scaffold(
                  body: Stack(
                    fit: StackFit.loose,
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Stack(
                        children: [
                            if (viewModel.getUserProfileModel != null &&
      viewModel.getUserProfileModel!.data != null &&
      viewModel.getUserProfileModel!.data!.profilePicture != null &&
      viewModel.getUserProfileModel!.data!.profilePicture!.isNotEmpty)
    Image.network(
      viewModel.getUserProfileModel!.data!.profilePicture!,
      height: 478.h,
      width: 380.w,
      fit: BoxFit.cover,
    )
  else ...[
    _buildShimmerText(context, 478.h, 380.w),
    Image.network(
      'https://cvhrma.org/wp-content/uploads/2015/07/default-profile-photo.jpg',
      height: 478.h,
      width: 380.w,
      fit: BoxFit.cover,
    )
  ],
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
                                    viewModel.getUserProfileModel?.data !=
                                              null
                                          ? Text('${viewModel.getUserProfileModel!.data!.lastName} ${viewModel.getUserProfileModel!.data!.firstName}',
                                          style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ):_buildShimmerText(context, 24.w, 100.w),

                                    SizedBox(
                                      height: 6.7.h,
                                    ),
                                    viewModel.getUserProfileModel?.data !=
                                                  null
                                              ? Text(
                                                  '@${viewModel.getUserProfileModel!.data!.lastName}${viewModel.getUserProfileModel!.data!.firstName}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                )
                                              : _buildShimmerText(
                                                  context, 18.w, 100.w),
                                    SizedBox(
                                      height: 26.71.h,
                                    ),
                                    _buildUserMetric(context, viewModel),
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    _buildActionButtons(context),
                                    SizedBox(
                                      height: 31.68.h,
                                    ),
                                    Text(
                                      'Profile',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
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
                                          border: Border.all(
                                              color: dividerColor, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                 CircleAvatar(
                                                      radius: 21.r,
                                                      backgroundColor: Colors.transparent, // Optional: set a background color if needed
                                                      child: ClipOval(
                                                        child: SizedBox(
                                                          width: 42.r,  // Diameter of the CircleAvatar (2 * radius)
                                                          height: 42.r,
                                                          child: viewModel.getUserProfileModel?.data?.profilePicture != null && 
                                                                viewModel.getUserProfileModel!.data!.profilePicture!.isNotEmpty ?
                                                            Image.network(
                                                              viewModel.getUserProfileModel!.data!.profilePicture.toString(),
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context, error, stackTrace) =>
                                                                Image.asset(
                                                                  Assets.png.profilepic.path,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                            ) : Image.network(
                                                              'https://cvhrma.org/wp-content/uploads/2015/07/default-profile-photo.jpg',
                                                              fit: BoxFit.cover,
                                                            ),
                                                        ),
                                                      ),
                                                    ),

                                                  SizedBox(width: 5.w,),
                                                  viewModel.getUserProfileModel
                                                                ?.data !=
                                                            null
                                                        ? Text(
                                                            '@${viewModel.getUserProfileModel!.data!.lastName}${viewModel.getUserProfileModel!.data!.firstName}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          )
                                                        : _buildShimmerText(
                                                            context,
                                                            18.w,
                                                            100.w),
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
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
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
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
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
                                                        fontWeight:
                                                            FontWeight.w400),
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
              });
        });
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

  Row _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditActorProfile())),
          child: AppButton(
            width: 157,
            text: 'Edit Profile',
            backgroundColor: Colors.black,
            textColor: Colors.white,
            height: 38,
          ),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                      height: 211.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          children: [
                            SizedBox(height: 24.h),
                            Text('Share profile',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontWeight: FontWeight.w700)),
                            SizedBox(
                              height: 25.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SvgPicture.asset(Assets.svgs.link),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text('Copy link',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(Assets.svgs.whatapp),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text('WhatsApp',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(Assets.svgs.twitter),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text('Twitter',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(Assets.svgs.telegram),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text('Telegram',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(Assets.svgs.instagram),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text('Instagram',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
          },
          child: AppButton(
            // width: 157,
            text: 'Share Profile',
            backgroundColor: Colors.black,
            textColor: Colors.white,
            height: 38,
          ),
        ),
      ],
    );
  }

   Widget _buildUserMetric(BuildContext context,  viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Endorsements())),
                child: viewModel.getUserProfileModel?.data != null
                    ? Text(
                        '${viewModel.getUserProfileModel!.data!.endorsements!.toString()}',
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
          Column(
            children: [
              viewModel.getUserProfileModel?.data != null
                  ? Text(
                      '${viewModel.getUserProfileModel!.data!.followers!.toString()}',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    )
                  : _buildShimmerText(context, 24.h, 50.w),
              Text(
                'Followers',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Column(
            children: [
              viewModel.getUserProfileModel?.data != null
                  ? Text(
                      '${viewModel.getUserProfileModel!.data!.totalRatings!.toString()}',
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
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/settingsPage");
                },
                icon: SvgPicture.asset(
                  Assets.svgs.settings,
                  height: 24.h,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ))
          ],
        ),
      ),
    );
  }
}
