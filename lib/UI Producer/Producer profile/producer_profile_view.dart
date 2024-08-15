import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI Actor/profile.dart';
import 'package:nitoons/UI%20Actor/profile_details/profile_details.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/gen/assets.gen.dart';

class ProducerProfileView extends StatelessWidget {
  const ProducerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
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
                        _buildActionButtons(context),
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
                          onTap: () {},
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

  Row _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.all(Radius.circular(5.r))
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 41.w,vertical: 9),
              child: SvgPicture.asset(Svgs.review,color: white,),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.all(Radius.circular(5.r))
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 41.w,vertical: 9),
              child: SvgPicture.asset(Svgs.messageIcon,color: white,),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.all(Radius.circular(5.r))
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 41.w,vertical: 9),
              child: SvgPicture.asset(Svgs.review,color: white,),
            ),
          ),
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
            onTap: (){},
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
                               // color: accentColor
                                ),
                      )
                    ])),
          ),
          AppVerticalDivider(),
          Text.rich(
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
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: TextSizes.textSize12SP,
                          fontWeight: FontWeight.w400,
                         // color: accentColor
                          ),
                    )
                  ])),
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
                         // color: accentColor
                          ),
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/editProfilePage");
              },
              child: Icon(
                CupertinoIcons.arrowshape_turn_up_right,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}