import 'package:flutter/material.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/widgets/base_text.dart';

class TextSwitchRow extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const TextSwitchRow({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BaseText(
          text,
          fontSize:TextSizes.textSize16SP ,
          fontWeight:FontWeight.w400 ,
          color:black ,
        ),
       Switch(
        activeColor:white ,
        inactiveTrackColor: switchNotActive,
        inactiveThumbColor: white,
        activeTrackColor: switchActive,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
