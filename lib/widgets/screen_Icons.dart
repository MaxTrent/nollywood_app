import 'package:flutter/material.dart';

class ScreenIcons extends StatelessWidget {
  final String iconAsset;
  final String text;
  final VoidCallback onPressed;

  const ScreenIcons({
    required this.iconAsset,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: ImageIcon(
            AssetImage(iconAsset),
            color: Colors.white,
            size: 24,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
