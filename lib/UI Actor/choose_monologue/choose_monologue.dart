import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI Actor/select_monologue.dart';
import 'package:nitoons/components/app_button.dart';

import '../../gen/assets.gen.dart';

class ChooseMonologue extends StatelessWidget {
   static String routeName = "/chooseMonologue";
  const ChooseMonologue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.svgs.back,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            height: 24.h,
            width: 24.w,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: Text(
              'Skip for now',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monologue',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Select a monologue from the provided list, memorize it, and record a 60 seconds video of your performance',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 367.h,
              decoration: BoxDecoration(
                color: Color(0xffF7F7F7),
              ),
              child: Center(child: SvgPicture.asset(Assets.svgs.silhoutte)),
            ),
            SizedBox(
              height: 35.h,
            ),
            AppButton(
              width: double.infinity,
                onPressed:()=> Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SelectMonologue())),
                text: 'Choose a template',
                backgroundColor: Colors.black,
                textColor: Colors.white),
            SizedBox(height: 20.h),
            AppButton(
                width: double.infinity,
                text: 'Continue',
                backgroundColor: Color(0xffEBECEF),
                textColor: Color(0xff828491)),
          ],
        ),
      ),
    );
  }
}
