import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  AppButton({
    required this.text,
    this.onPressed,
    required this.backgroundColor,
    this.borderColor,
    required this.textColor,
    this.width,
    this.height = 56,
    this.fontweight = FontWeight.w600,
    this.fontSize = 14,
    super.key,
  });

  Color? borderColor;
  Color backgroundColor;
  Color textColor;
  String text;
  double? width;
  double height;
  FontWeight fontweight;
  int fontSize;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width?.w,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ))),
          onPressed: onPressed,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 21.w, vertical: 7.h),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: fontSize.sp, color: textColor, fontWeight: fontweight),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
