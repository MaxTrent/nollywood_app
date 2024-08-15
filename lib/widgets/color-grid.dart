import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Actor/role/signup_role_viewmodel.dart';
import 'package:pmvvm/pmvvm.dart';
import '../constants/app_colors.dart';

class ColorGrid extends StatelessWidget {
  final List<String> _hexColors = [
    '#FBD7C1',
    '#DDC5A9',
    '#F9E0AA',
    '#D7C9BC',
    '#EDBA85',
    '#E4B48C',
    '#EABD82',
    '#BC9279',
    '#A2876A',
    '#8A5F3E',
    '#AB6A47',
    '#AB6C40',
    '#8F614D',
    '#58361A',
    '#392315',
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpRoleViewmodel>();

    return Container(
      height: 700.h,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 93 / 63,
        ),
        itemCount: _hexColors.length,
        itemBuilder: (BuildContext context, int index) {
          Color color = _getColorFromHex(_hexColors[index]);
          return SizedBox(
            height: 20,
            width: 50,
            child: GestureDetector(
              onTap: () {
                viewModel.selectColor(_hexColors[index]);
              },
              child: ValueListenableBuilder<String?>(
                valueListenable: viewModel.selectedColorNotifier,
                builder: (context, selectedColor, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12.0.sp),
                      border: selectedColor == _hexColors[index]
                          ? Border.all(
                              color:
                                  selectColor, // Change to your selection color
                              width: 5.0,
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
