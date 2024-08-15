import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/app_colors.dart';

class AppStarRating extends StatefulWidget {
  final int numberOfStars;
  final initialRating;
  final Color starColor;
  final ValueChanged<int>? onRatingChanged;
  final isStarClickable;

  const AppStarRating({
    Key? key,
    required this.numberOfStars,
    required this.starColor,
    this.initialRating = 0,
    this.onRatingChanged,
    this.isStarClickable = true,
  }) : super(key: key);

  @override
  _StarRatingButtonState createState() => _StarRatingButtonState();
}

class _StarRatingButtonState extends State<AppStarRating> {
  late List<Color> starColors;
  late int _selectedStars;

  @override
  void initState() {
    super.initState();
    starColors = List<Color>.generate(widget.numberOfStars, (index) {
      return index < _selectedStars ? selectColor : buttonNotActive;
    });
    _selectedStars = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.numberOfStars,
        (index) => GestureDetector(
          onTap: widget.isStarClickable
              ? () {
                  setState(() {
                    _selectedStars = index + 1;
                    for (int i = 0; i < widget.numberOfStars; i++) {
                      starColors[i] =
                          i < _selectedStars ? selectColor : buttonNotActive;
                    }
                    if (widget.onRatingChanged != null) {
                      widget.onRatingChanged!(_selectedStars);
                    }
                  });
                }
              : null,
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
