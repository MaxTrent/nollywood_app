import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  AppLoadingIndicator({
    super.key,
    this.color = Colors.black,
  });
  Color color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2,
      color: color,
    );
  }
}
