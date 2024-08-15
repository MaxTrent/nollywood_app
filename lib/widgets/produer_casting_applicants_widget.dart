import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/base_text.dart';

class ProducerCastingApplicants extends StatelessWidget {
  final String text;
  final String? amount;
  final VoidCallback? press;

  const ProducerCastingApplicants({
    Key? key,
    required this.text,
    this.press,
      this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:borderColor, // Change border color when selected
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacings.spacing16.w,
            vertical: Spacings.spacing16.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                text,
                fontSize: TextSizes.textSize14SP,
                fontWeight: FontWeight.w700,
                color: black,
              ),
              Container(
                decoration: BoxDecoration(
                  color: selectColor,
                  borderRadius: BorderRadius.all(Radius.circular(100.r)),
                  // border: Border.all(
                  //   color: borderColor,
                  //   width: 1,
                  // ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Spacings.spacing6.w,
                      vertical: Spacings.spacing2.h),
                  child: BaseText(
                    amount!,
                    fontSize: TextSizes.textSize10SP,
                    fontWeight: FontWeight.w400,
                    color: white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
