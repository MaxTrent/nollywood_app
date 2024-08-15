import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/components/components.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/app_colors.dart';
import '../../../gen/assets.gen.dart';
import '../../UI Actor/SignUp/sign_up.dart';
import '../../UI Actor/edit-profile/edit-profile_view.dart';
import '../../UI Actor/endorsements/endorsements.dart';
import '../../UI Actor/monologue_screen.dart';
import '../../UI Actor/profile/profile_view_model.dart';
import '../../data/app_storage.dart';
import '../../locator.dart';
import '../../widgets/base_text.dart';
import '../../widgets/main_button.dart';
import '../producer_profile/producer_profile.dart';

class ProducerProfileScreen extends StatelessWidget {
  const ProducerProfileScreen({super.key});

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
            return _buildLoginScreen(
                context); // Show the login screen if not authenticated
          } else {
            return FutureBuilder<String?>(
                future: SharedPreferencesHelper.getUserProfession(),
                builder: (context, professionSnapshot) {
                  if (professionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  } else if (professionSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${professionSnapshot.error}'));
                  } else if (!professionSnapshot.hasData ||
                      professionSnapshot.data != 'Producer') {
                    return _buildProfessionLoginScreen(context);
                  } else {
                    // Continue with the main screen if the profession is "Producer"

                    return MVVM<ProfileViewModel>.builder(
                        disposeVM: false,
                        viewModel: locator<ProfileViewModel>(),
                        viewBuilder: (_, viewModel) => Scaffold(
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
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 25.h,
                                                ),
                                                viewModel.getUserProfileModel
                                                            ?.data !=
                                                        null
                                                    ? Text(
                                                        '${viewModel.getUserProfileModel!.data!.lastName} ${viewModel.getUserProfileModel!.data!.firstName}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayLarge!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      )
                                                    : _buildShimmerText(
                                                        context, 24.w, 100.w),
                                                SizedBox(
                                                  height: 6.7.h,
                                                ),
                                                Row(
                                                  children: [
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
                                                    SizedBox(
                                                      width: 9.w,
                                                    ),
                                                    PinkTIle(text: 'Producer')
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 26.71.h,
                                                ),
                                                _buildUserMetric(
                                                    context, viewModel),
                                                SizedBox(
                                                  height: 23.h,
                                                ),
                                                _buildActionButtons(context),
                                                SizedBox(
                                                  height: 31.68.h,
                                                ),
                                                viewModel.getUserProfileModel
                                                            ?.data !=
                                                        null
                                                    ? Text(
                                                        '${viewModel.getUserProfileModel!.data!.lastName} ${viewModel.getUserProfileModel!.data!.firstName}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      )
                                                    : _buildShimmerText(
                                                        context, 20.w, 100.w),
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                GestureDetector(
                                                  //Go to the producer profile to see details

                                                  onTap: () => Navigator.of(
                                                          context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProducerProfile())),
                                                  child: Container(
                                                    height: 54.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      border: Border.all(
                                                          color: dividerColor,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
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

                                                              SizedBox(
                                                                width: 3.w,
                                                              ),
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
                                                                              fontWeight: FontWeight.w400),
                                                                    )
                                                                  : _buildShimmerText(
                                                                      context,
                                                                      18.w,
                                                                      100.w),
                                                            ],
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios,
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
                                                  'Appreciated Posts',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                GestureDetector(
                                                  onTap: () => Navigator.of(
                                                          context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              MonologueScreen())),
                                                  child: Container(
                                                    height: 54.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      border: Border.all(
                                                          color: dividerColor,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  Assets.svgs
                                                                      .colouredrose),
                                                              SizedBox(
                                                                width: 14.w,
                                                              ),
                                                              Text(
                                                                'See all appreciated posts',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .displaySmall!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                              ),
                                                            ],
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios,
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
                                  _buildAppbarIcons(context, viewModel),
                                ],
                              ),
                            ));
                  }
                });
          }
        });
  }

  Widget _buildLoginScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BaseText(
          'Login',
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        elevation: 1,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.perm_identity_outlined,
              color: Colors.grey,
              size: 100.sp,
            ),
            SizedBox(height: 10.h),
            BaseText(
              'Login to access this resource',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: MainButton(
                text: 'Login',
                buttonColor: Colors.black,
                textColor: Colors.white,
                press: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
 Widget _buildProfessionLoginScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BaseText(
          'Login',
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        elevation: 1,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.perm_identity_outlined,
              color: Colors.grey,
              size: 100.sp,
            ),
            SizedBox(height: 10.h),
            BaseText(
              'Login as a producer to access this resource',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: MainButton(
                text: 'Login',
                buttonColor: Colors.black,
                textColor: Colors.white,
                press: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
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

  Row _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditProfilePage())),
          //  Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => ProfileCard())),
          child: AppButton(
            width: 157.w,
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

  Widget _buildUserMetric(BuildContext context, ProfileViewModel viewModel) {
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
                      '${viewModel.getUserProfileModel!.data!.following!.toString()}',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    )
                  : _buildShimmerText(context, 24.h, 50.w),
              Text(
                'Following',
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

  SafeArea _buildAppbarIcons(BuildContext context, ProfileViewModel ViewModel) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        child: Row(
          children: [
            GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset(Assets.svgs.back)),
            Spacer(),
            IconButton(
                onPressed: () {
                  ViewModel.logout();
                },
                icon: Icon(
                  Icons.logout,
                  size: 24.h,
                  color: Colors.white,
                )),
            SizedBox(
              width: 10.w,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/settingsPage");
                },
                icon: SvgPicture.asset(
                  Assets.svgs.settings,
                  height: 24.h,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                )),
          ],
        ),
      ),
    );
  }
}
