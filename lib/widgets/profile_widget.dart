import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ProfileImageWithBadge extends StatelessWidget {
  final String imagePath;
  final double imageSize;
  final double badgeSize;

  const ProfileImageWithBadge({
    required this.imagePath,
    required this.imageSize,
    required this.badgeSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Plus badge at the bottom
        Positioned(
          bottom: 0,
          left: (imageSize - badgeSize) / 2,
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              color: selectColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: badgeSize * 0.6,
            ),
          ),
        ),
      ],
    );
  }
}
