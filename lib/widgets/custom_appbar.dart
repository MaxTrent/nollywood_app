import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kToolbarHeight,
        color: Colors.white,
        child: Row(
          children: [
            if (leading != null) leading!,
            if (title != null) Expanded(child: title!),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
}
