import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/gen/assets.gen.dart';

class PasswordResetSuccessful extends StatelessWidget {
  const PasswordResetSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.svgs.congrat),
            Text(
              'Password reset successful!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 32.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'You have successfully reset your password.\nClick the button below to log back into your account',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: AppButton(
            width: double.infinity,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/loginEmailAddressPage');
            },
            text: 'Log in',
            backgroundColor: Colors.black,
            textColor: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
