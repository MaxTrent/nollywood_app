import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/sizes.dart';

class ProducerMessageSettingsDropdownWithTextField extends StatefulWidget {
  @override
  _ProducerMessageSettingsDropdownWithTextFieldState createState() => _ProducerMessageSettingsDropdownWithTextFieldState();
}

class _ProducerMessageSettingsDropdownWithTextFieldState extends State<ProducerMessageSettingsDropdownWithTextField> {
  final List<String> options = ['No one', 'Everyone', 'All verified users','Verified actors only','Verified producers only',];
  late String selectedOption;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedOption = options.first; // Set initial selected option
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedOption,
            decoration: InputDecoration(
              labelText: 'Message',
              hintText: 'Select',
              hintStyle: TextStyle(
                color: LightTextColor,
                fontWeight: FontWeight.w600,
                fontFamily: "Satoshi",
                fontSize: TextSizes.textSize14SP,
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: "Satoshi",
                fontSize: TextSizes.textSize14SP ,
                color: LightTextColor,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: LightTextColor),
                  borderRadius: BorderRadius.circular(8.sp)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: black),
                borderRadius: BorderRadius.circular(8.0.sp),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0.sp),
              ),
            ),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedOption = newValue;
                  _textEditingController.text = newValue;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
