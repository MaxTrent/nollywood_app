import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class PinkTIle extends StatelessWidget {
  PinkTIle({
    required this.text,
    super.key,
  });

  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.h,
      width: 96.w,
      decoration: BoxDecoration(
          color: selectColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: selectColor, width: 1)),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: selectColor),
        ),
      ),
    );
  }
}