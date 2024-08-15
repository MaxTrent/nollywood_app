import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pmvvm/pmvvm.dart';

import '../UI Actor/role/signup_role_viewmodel.dart';
import '../constants/app_colors.dart';
import '../constants/sizes.dart';

class DropdownWithTextField extends StatelessWidget {
  final List<String> options = ['18-24', '25-34', '35-54', '55-74'];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpRoleViewmodel>();
    TextEditingController _textEditingController = TextEditingController();

    // @override
    // void initState() {
    //   super.initState();
    //   selectedOption = options.first; // Set initial selected option
    // }

    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        label: Text(
          'Playable age',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: "Satoshi",
              fontSize: 14.sp,
              color: black),
        ),
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 16),

        // Add more decoration..
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LightTextColor),
            borderRadius: BorderRadius.circular(8.sp)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: black),
          borderRadius: BorderRadius.circular(8.0.sp),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.sp),
        ),
      ),
      hint: Text(
        'Select',
        style: TextStyle(
          color: LightTextColor,
          fontWeight: FontWeight.w600,
          fontFamily: "Satoshi",
          fontSize: TextSizes.textSize14SP,
        ),
      ),
      items: options
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Satoshi",
                    fontSize: TextSizes.textSize14SP,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'select playable age.';
        }
        return null;
      },
      onChanged: (String? newValue) {
        if (newValue != null) {
          viewModel.selectPlayableAge(newValue);
          _textEditingController.text = newValue;
        }
      },
      onSaved: (value) {
        if (value != null) {
          viewModel.selectPlayableAge(value);
        }
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: black),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        offset: Offset(0, -20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
      ),
    );
  }
}
