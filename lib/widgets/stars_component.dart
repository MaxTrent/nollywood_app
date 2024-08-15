import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/app_colors.dart';

class StarRatingButton extends StatefulWidget {
  final int numberOfStars;
  final Color starColor;

  const StarRatingButton({
    Key? key,
    required this.numberOfStars,
    required this.starColor,
  }) : super(key: key);

  @override
  _StarRatingButtonState createState() => _StarRatingButtonState();
}

class _StarRatingButtonState extends State<StarRatingButton> {
  late List<Color> starColors;

  @override
  void initState() {
    super.initState();
    starColors = List<Color>.filled(widget.numberOfStars, widget.starColor);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.numberOfStars,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              for (int i = 0; i < widget.numberOfStars; i++) {
                starColors[i] = i <= index ? selectColor : buttonNotActive;
              }
            });
          },
          child: Icon(
            Icons.star,
            color: starColors[index],
            size: 28.sp,
          ),
        ),
      ),
    );
  }
}
