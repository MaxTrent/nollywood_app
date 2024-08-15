import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/components/app_button.dart';

import '../../gen/assets.gen.dart';

class ApplicationSuccess extends StatelessWidget {
  const ApplicationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SvgPicture.asset(Assets.svgs.congrat),
            Text(
              'Application Successful',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              'Congratulations! You have successfully sent in your application to the producers of The house of secrets. Sit tight!',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        child: AppButton(
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/home_page'));
          },
            text: 'Take me home',
            backgroundColor: Colors.black,
            textColor: Colors.white),
      ),
    );
  }
}
