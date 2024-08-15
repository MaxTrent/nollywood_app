// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class NumberContainer extends StatelessWidget {
  NumberContainer({
    required this.number,
    super.key,
  });
  String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18.h,
      decoration: BoxDecoration(
          color: selectColor, borderRadius: BorderRadius.circular(100.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        child: Text(
          number,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ),
    );
  }
}
