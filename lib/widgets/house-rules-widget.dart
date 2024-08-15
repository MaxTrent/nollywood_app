import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/base_text.dart';

class HouseRulesComponent extends StatelessWidget {
  final String mainText;
  final String subText;

  HouseRulesComponent({
    required this.mainText,
    required this.subText, // Default color for check icon
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
             Icon(
                Icons.check,
                color: selectColor,
                size: 14,
              ),

            SizedBox(
              width: Spacings.spacing14.h,
            ),
            BaseText(
              mainText,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        SizedBox(
          height: Spacings.spacing8.h,
        ),
        BaseText(
          subText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
