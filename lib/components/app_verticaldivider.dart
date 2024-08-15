import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: 1.w,
      decoration: BoxDecoration(
        color: dividerColor,
      ),
    );
  }
}