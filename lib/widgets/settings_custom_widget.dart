import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/widgets/base_text.dart';

class SettingsCustomContainer extends StatelessWidget {
  final String text;
  final String iconAsset;
  final String forwardIconAsset;
  final double spacingWidth;
  final VoidCallback? press;

  SettingsCustomContainer({
    required this.text,
    required this.iconAsset,
    required this.forwardIconAsset,
    this.spacingWidth = 12.0,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:press,
      child: Container(
        child: Row(
          children: [
            SvgPicture.asset(iconAsset),
            SizedBox(
              width: spacingWidth,
            ),
            BaseText(
              text,
              fontSize: TextSizes.textSize16SP,
              fontWeight: FontWeight.w400,
              color: black,
            ),
            Spacer(),
            SvgPicture.asset(forwardIconAsset),
          ],
        ),
      ),
    );
  }
}
