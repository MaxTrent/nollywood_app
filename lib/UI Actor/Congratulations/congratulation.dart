import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../constants/images.dart';
import '../../widgets/main_button.dart';

class CongratulationPage extends StatelessWidget {
  static String routeName = "/congratulationPage";
  const CongratulationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: Spacings.spacing160.h,
          ),
          Center(
            child: Image(
              image: AssetImage(
                Pngs.congrats,
              ), // Replace 'congratulations.png' with your asset path
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
            'Your profile has been successfully created',
            fontWeight: FontWeight.w400,
            fontSize: TextSizes.textSize14SP,
            color: LightTextColor,
          ),
          SizedBox(
            height: Spacings.spacing226.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
            child: MainButton(
              text: 'Proceed',
              buttonColor: black,
              textColor: white,
              press: () {
                Navigator.pushNamed(context, '/houseRulesPage');
              },
            ),
          ),
          SizedBox(
            height: Spacings.spacing40.h,
          ),
        ],
      ),
    );
  }
}
