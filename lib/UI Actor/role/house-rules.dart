import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/house-rules-widget.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../widgets/base_text.dart';
import '../../widgets/main_button.dart';

class HouseRulesPage extends StatelessWidget {
  static String routeName = "/houseRulesPage";
  const HouseRulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: black,
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: Spacings.spacing20.h,
              ),
              BaseText(
                "Welcome to the Nollywood actor.",
                fontSize: TextSizes.textSize32SP,
                fontWeight: FontWeight.w700,
                color: black,
              ),
              SizedBox(
                height: Spacings.spacing26.h,
              ),
              BaseText(
                'Please follow these House Rules.',
                fontSize: TextSizes.textSize16SP,
                fontWeight: FontWeight.w400,
                color: LightTextColor,
              ),
              SizedBox(
                height: Spacings.spacing32.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: selectColor,
                    size: 14.sp,
                  ),
                  SizedBox(
                    width: Spacings.spacing14.h,
                  ),
                  BaseText(
                    'Complete your profile.',
                    fontSize: TextSizes.textSize16SP,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              SizedBox(
                height: Spacings.spacing8.h,
              ),
              BaseText(
                'Incomplete profiles may not be recommended to producers, but you can always return to your profile later to complete this step and improve its visibility.',
                fontSize: TextSizes.textSize14SP,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: Spacings.spacing24.h,
              ),
              HouseRulesComponent(
                  mainText: 'Be yourself.',
                  subText:
                      'Make sure your photos, age, and bio and true to who you are.'),
              SizedBox(
                height: Spacings.spacing24.h,
              ),
              HouseRulesComponent(
                  mainText: 'Stay safe.',
                  subText:
                      'Don’t be too quick to give out personal information. Date Safely'),
              SizedBox(
                height: Spacings.spacing24.h,
              ),
              HouseRulesComponent(
                  mainText: 'Play it cool.',
                  subText:
                      'Respect others and treat them as you would like to be treated.'),
              SizedBox(
                height: Spacings.spacing24.h,
              ),
              HouseRulesComponent(
                  mainText: 'Be proactive.',
                  subText: 'Always report bad behavior.'),
              SizedBox(
                height: Spacings.spacing56.h,
              ),
              MainButton(
                text: 'Go to my Profile',
                buttonColor: black,
                textColor: white,
                press: () {
                  Navigator.pushNamed(context, '/home_page');
                },
              ),
              SizedBox(
                height: Spacings.spacing40.h,
              ),
            ],
          ),
        ));
  }
}
