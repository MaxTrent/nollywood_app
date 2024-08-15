import "package:flutter/material.dart";


class BaseText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final VoidCallback? onPressed;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  const BaseText(
      this.text, {
        super.key,
        this.fontSize,
        this.fontWeight,
        this.color,
        this.onPressed,
        this.textAlign = TextAlign.left,
        this.textDecoration,
      });

  @override
  Widget build(BuildContext context) {
        return GestureDetector(
          onTap: onPressed,
          child: Text(
            text,
            textAlign: textAlign,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: "Satoshi",
              decoration: textDecoration,
              fontWeight: fontWeight,
              color: color ,
            ),
            
          ),
        );
  }
}
