import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorProfilePicture extends StatelessWidget {
  const ErrorProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      size: 26.r,
      color: Colors.grey,
    );
  }
}
