import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/spacings.dart';

class SelectableRow extends StatelessWidget {
  final String item;
  final bool isSelected;
  final Color borderColor;
  final VoidCallback? onTap; // Add onTap callback

  const SelectableRow({
    Key? key,
    required this.item,
    this.isSelected = false,
    required this.borderColor,
    this.onTap, // Receive onTap callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call onTap callback
      child: Container(
        height: 58.h,
        width: 327.w,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: black,
                    fontFamily: "Satoshi",
                    fontSize: Spacings.spacing16,
                  ),
                ),
                isSelected
                    ? Icon(Icons.check, color: black)
                    : Icon(Icons.check, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
