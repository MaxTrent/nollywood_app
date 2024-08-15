import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgProfileInCircle extends StatelessWidget {
  final String svgAssetPath;
  final double circleSize;
  final VoidCallback? pressed;
  final double? height;
  final double? width;

  SvgProfileInCircle({
    super.key,
    required this.svgAssetPath,
    this.circleSize = 48.0,
    this.pressed,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(svgAssetPath,
              height: height, 
              width: width, 
              ),
        ),
      ),
    );
  }
}
