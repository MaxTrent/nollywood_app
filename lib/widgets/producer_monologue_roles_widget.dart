import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/base_text.dart';

class ProducerMonologueRolesCustomContainer extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final bool isSelected;

  const ProducerMonologueRolesCustomContainer({
    Key? key,
    required this.text,
    this.press,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.pink : borderColor, // Change border color when selected
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
                color:  black,
              ),
              SvgPicture.asset(
                Svgs.monologueScript,
                height: 24.h,
                width: 24.w,
                color: isSelected ? Colors.pink : buttonNotActive, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
