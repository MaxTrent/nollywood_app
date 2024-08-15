import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/UI%20Actor/home_page.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../constants/images.dart';

class PublishSuccessful extends StatelessWidget {
  static String routeName = "/publishSuccessful";

  const PublishSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(
              height: Spacings.spacing160.h,
            ),
            Center(
              child: Image(
                image: AssetImage(
                  Pngs.congrats,
                ),
                width: Spacings.spacing186.w,
                height: Spacings.spacing186.h,
              ),
            ),
            BaseText(
              'Congratulations',
              fontWeight: FontWeight.w700,
              fontSize: TextSizes.textSize24SP,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing10.h,
            ),
            BaseText(
              'Your project has been successfully created and published for open casting. Sit tight and expect to start receiving applications soon.',
              fontWeight: FontWeight.w400,
              fontSize: TextSizes.textSize14SP,
              textAlign: TextAlign.center,
              color: LightTextColor,
            ),
            SizedBox(
              height: Spacings.spacing226.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
              child: AppButton(
                onPressed: () {
                   Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => ProducerHomePage()),
    (Route<dynamic> route) => false, // Remove all previous routes
  );
                },
                text: 'Take me home',
                backgroundColor: black,
                textColor: white,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: Spacings.spacing40.h,
            ),
          ],
        ),
      ),
    );
  }
}
