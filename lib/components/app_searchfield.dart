import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../gen/assets.gen.dart';

// ignore: must_be_immutable
class AppSearchField extends StatelessWidget {
  AppSearchField({
    required this.controller,
    this.height = 48,
    this.suffixIcon,
    this.hint = 'Search',
    super.key,
  });

  TextEditingController controller;
  double height;
  Widget? suffixIcon;
  String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: TextFormField(
        showCursor: false,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 9.h),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.4)),
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.h),
            child: SvgPicture.asset(
              Assets.svgs.search,
              height: 20.h,
              width: 20.w,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.srcIn),
            ),
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xffE8E6EA))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xffE8E6EA))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xffE8E6EA))),
        ),
      ),
    );
  }
}
