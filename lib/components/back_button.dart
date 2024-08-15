// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../gen/assets.gen.dart';

class AppBackButton extends StatelessWidget {
  AppBackButton({
    this.color = Colors.black,
    super.key,
  });
  Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        Assets.svgs.back,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        height: 24.h,
        width: 24.w,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
