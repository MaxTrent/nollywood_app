import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/images.dart';
import '../../constants/sizes.dart';
import '../../constants/spacings.dart';
import '../../widgets/base_text.dart';
import '../../widgets/main_button.dart';
import 'login_page.dart';
import 'sign_up.dart';

 void showCustomModalBottomSheet( context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false, // Navigate to the login page
          );
          return false;
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9, // Set height to 90% of screen height
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: Spacings.spacing50.h),
                    Padding(
                      padding: EdgeInsets.fromLTRB(136.w, 0, 117.w, 7.h),
                      child: SvgPicture.asset(
                        alignment: Alignment.center,
                        Svgs.appIcon,
                        width: Spacings.spacing120.w,
                        height: Spacings.spacing76,
                        color: black,
                      ),
                    ),
                    BaseText(
                      'NOLLYWOOD ACTOR',
                      fontWeight: FontWeight.w400,
                      fontSize: TextSizes.textSize14SP,
                      color: black,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Spacings.spacing52.h),
                    BaseText(
                      'Sign up to continue',
                      fontWeight: FontWeight.w400,
                      fontSize: TextSizes.textSize18SP,
                      color: LightTextColor,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Spacings.spacing30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
                      child: MainButton(
                        text: 'Continue with email',
                        buttonColor: black,
                        textColor: white,
                        press: () {
                          Navigator.pushNamed(context, '/emailAddressSignUp');
                        },
                      ),
                    ),
                    SizedBox(height: Spacings.spacing16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
                      child: MainButton(
                        text: 'Use phone number',
                        buttonColor: Colors.transparent,
                        textColor: black,
                        borderColor: black,
                        press: () {
                          Navigator.pushNamed(context, '/phoneNumberPage');
                        },
                      ),
                    ),
                    SizedBox(height: Spacings.spacing32.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Divider(color: dividerColor),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: BaseText(
                              'or sign up with',
                              color: LightTextColor,
                              fontSize: TextSizes.textSize12SP,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Divider(color: dividerColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Spacings.spacing26.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Spacings.spacing10.h, horizontal: Spacings.spacing10.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(Spacings.spacing8.sp),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/loginPhoneNumberPage');
                            },
                            child: SvgPicture.asset(
                              Svgs.facebookIcon,
                              width: IconSizes.mainIconSize,
                              height: IconSizes.mainIconSize,
                            ),
                          ),
                        ),
                        SizedBox(width: Spacings.spacing20.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/loginEmailAddressPage');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Spacings.spacing10.h, horizontal: Spacings.spacing10.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(Spacings.spacing8.sp),
                            ),
                            child: SvgPicture.asset(
                              Svgs.googleIcon,
                              width: IconSizes.mainIconSize,
                              height: IconSizes.mainIconSize,
                            ),
                          ),
                        ),
                        SizedBox(width: Spacings.spacing20.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Spacings.spacing10.h, horizontal: Spacings.spacing10.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(Spacings.spacing8.sp),
                          ),
                          child: SvgPicture.asset(
                            Svgs.apple,
                            width: IconSizes.mainIconSize,
                            height: IconSizes.mainIconSize,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacings.spacing78.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseText(
                          'Already have an account?',
                          fontSize: TextSizes.textSize18SP,
                          fontWeight: FontWeight.w400,
                          color: LightTextColor,
                        ),
                        SizedBox(width: Spacings.spacing4.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/loginEmailAddressPage');
                          },
                          child: BaseText(
                            ' Log in',
                            fontSize: TextSizes.textSize18SP,
                            color: signInColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacings.spacing60.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseText(
                          'Terms of use',
                          fontSize: TextSizes.textSize18SP,
                          fontWeight: FontWeight.w400,
                          color: LightTextColor,
                        ),
                        SizedBox(width: Spacings.spacing30.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/privacyPolicy');
                          },
                          child: BaseText(
                            'Privacy Policy',
                            fontSize: TextSizes.textSize18SP,
                            color: LightTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacings.spacing20.h),
                  ],
                ),
              ),
              Positioned(
                right: 16.0,
                top: 16.0,
                child: GestureDetector(
                  onTap: () {// Close the bottom sheet
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),(route)=>false // Navigate to the login page
                    );
                  },
                  child: Icon(Icons.close, size: 30.0),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
