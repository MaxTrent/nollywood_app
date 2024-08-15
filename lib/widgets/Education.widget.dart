import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pmvvm/pmvvm.dart';

import '../UI Producer/edit_profile/education_edit_section/education_edit_viewmodel.dart';
import '../constants/app_colors.dart';
import '../constants/sizes.dart';

class EducationDropdownWithTextField extends StatelessWidget {
  final List<String> options = ['PHD', 'MSC', 'HND', 'OND', 'SSCE', 'N/A'];
  
 @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<EducationEditViewmodel>();
    TextEditingController _textEditingController = TextEditingController();

    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        label: Text(
          'Education',
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
          return 'select latest education.';
        }
        return null;
      },
      onChanged: (String? newValue) {
        if (newValue != null) {
          viewModel.selectHighestEducation(newValue);
          _textEditingController.text = newValue;
        }
      },
      onSaved: (value) {
        if (value != null) {
          viewModel.selectHighestEducation(value);
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
    //  Row(
    //   children: [
    //     Expanded(
    //       child: DropdownButtonFormField<String>(
    //         value: selectedOption,
    //         decoration: InputDecoration(
    //           labelText: 'Education',
    //           hintText: 'Select',
    //           hintStyle: TextStyle(
    //             color: LightTextColor,
    //             fontWeight: FontWeight.w600,
    //             fontFamily: "Satoshi",
    //             fontSize: TextSizes.textSize14SP,
    //           ),
    //           labelStyle: TextStyle(
    //             fontWeight: FontWeight.w400,
    //             fontFamily: "Satoshi",
    //             fontSize: 14,
    //           ),
    //           enabledBorder: OutlineInputBorder(
    //               borderSide: BorderSide(color: LightTextColor),
    //               borderRadius: BorderRadius.circular(8.sp)
    //           ),
    //           focusedBorder: OutlineInputBorder(
    //             borderSide: BorderSide(color: black),
    //             borderRadius: BorderRadius.circular(8.0.sp),
    //           ),
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(8.0.sp),
    //           ),
    //         ),
    //         items: options.map((String option) {
    //           return DropdownMenuItem<String>(
    //             value: option,
    //             child: Text(option),
    //           );
    //         }).toList(),
    //         onChanged: (String? newValue) {
    //           if (newValue != null) {
    //             setState(() {
    //               selectedOption = newValue;
    //               _textEditingController.text = newValue;
    //             });
    //           }
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
