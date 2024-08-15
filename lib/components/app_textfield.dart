import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/app_colors.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  AppTextField({
    required this.controller,
    required this.hintText,
    this.height,
    this.labelText,
    this.width,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.focusNode,
    this.fillColor,
    this.filled,
    super.key, 
  });

  TextEditingController controller;
  String hintText;
  String? labelText;
  double? width;
  Widget? suffixIcon;
  String? Function(String?)? validator;
  bool obscureText;
  void Function(String)? onChanged;
FocusNode? focusNode;
bool? filled;
Color? fillColor;
double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: 59.h,
      height: (height ?? 59).h,
        width: width!.w,
        child: TextFormField(
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.w400),
          focusNode: focusNode,

          onChanged: onChanged,
          showCursor: true,
          cursorColor: selectColor,
          cursorWidth: 2.w,
          obscureText: obscureText,
          obscuringCharacter: '*',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8.h),
            filled: filled,
            fillColor: fillColor,
            hintText: hintText,
            labelText: labelText,
            suffixIcon: suffixIcon,

            hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w400, color: const Color(0xffE8E6EA)),
            labelStyle: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.w400),
            errorStyle: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.w400, color: Colors.red),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: Color(0xffE8E6EA),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: Color(0xff7C7C7C),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: Color(0xffE8E6EA),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ));
  }
}
