import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/app_button.dart';
import '../components/app_verticaldivider.dart';
import '../constants/app_colors.dart';
import '../constants/sizes.dart';
import '../gen/assets.gen.dart';


class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 586.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffEB545D),
                borderRadius: BorderRadius.circular(24.r),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 14.h,),
                  Padding(
                    padding:  EdgeInsets.only(left: 14.w),
                    child: SvgPicture.asset(Assets.svgs.logotext, height: 32.h, width: 42.w,),
                  ),

                ],
              ),
            ),
            Container(
              height: 473.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 54.h,
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
                    height: 32.h,
                  ),
                  Center(child: SvgPicture.asset(Assets.svgs.qr))

                ],
              ),
            ),
            ),
            Positioned(
              top: 20.h,
              child: CircleAvatar(
                radius: 67.r,
                child: Image.asset(Assets.png.adesua.path),
              ),
            )
          ],
        ),
      ),
    );
  }
  Row _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfileCard())),
          child: AppButton(
            text: 'Message',
            backgroundColor: Colors.black,
            textColor: Colors.white,
            height: 38,
          ),
        ),
        AppButton(
          text: 'Follow',
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
          Text.rich(
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
                          color: accentColor),
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
                          color: accentColor),
                    )
                  ])),
        ],
      ),
    );
  }
}
