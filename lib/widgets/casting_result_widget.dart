import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/base_text.dart';

class CastingResultWidget extends StatelessWidget {
  const CastingResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 21.r,
            backgroundColor: Colors.grey,
          ),
          SizedBox(width: Spacings.spacing8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                'Adesua Etomi',
                fontSize: TextSizes.textSize12SP,
                fontWeight: FontWeight.w700,
                color: black,
              ),
              BaseText(
                'queensheba_5',
                fontSize: TextSizes.textSize10SP,
                fontWeight: FontWeight.w400,
                color: LightTextColor,
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.all(Radius.circular(5.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                child: BaseText(
                  'Message',
                  fontSize: TextSizes.textSize12SP,
                  fontWeight: FontWeight.w600,
                  color: white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: Spacings.spacing8.w,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.all(Radius.circular(5.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                child: BaseText(
                  'Reject',
                  fontSize: TextSizes.textSize12SP,
                  fontWeight: FontWeight.w600,
                  color: white,
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: Spacings.spacing14.h),
      Stack(
        children: [
          Container(
            height: Spacings.spacing150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: containerColor,
                  
            ),
            child: Center(
              child: Image.asset(
                'assets/png/ade.png',
                width: Spacings.spacing116.w,
                height: Spacings.spacing150.h,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.075,
             right: MediaQuery.of(context).size.width * 0.4,
            child: SvgPicture.asset(
              Svgs.iconPlay,
              height: 19.h,
              width: 19.w,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
             right: MediaQuery.of(context).size.width * 0.04,
            child: GestureDetector(
              onTap: (){
                showDialog(
  context: context,
  barrierDismissible: true,
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 369.w,
                  height:420.h,
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/png/ade.png',
                  width: 369.w,
                  height:471.h,
                ),
              ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.195,
             right: MediaQuery.of(context).size.width * 0.303,
            child: SvgPicture.asset(
              Svgs.iconPlay,
              height: 60.h,
              width: 60.w,
            ),
          ),
            ],
          ),
        ),
      ),
    );
  },
);
              },
              child: SvgPicture.asset(
                Svgs.maximize,
                height: 16.h,
                width: 16.w,
              ),
            ),
          ),
        ],
      ),
    ]));
  }
}
