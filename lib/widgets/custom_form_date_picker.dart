import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/sizes.dart';

class CustomTextFormDateField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  const CustomTextFormDateField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  @override
  _CustomTextFormDateFieldState createState() =>
      _CustomTextFormDateFieldState();
}

class _CustomTextFormDateFieldState extends State<CustomTextFormDateField> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              // override MaterialApp ThemeData
              colorScheme: ColorScheme.light(
                primary: black, //header and selected day background color
                onPrimary: white, // titles and
                onSurface: black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // ok , cancel    buttons
                ),
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;

        // Ensure day and month are always two digits
        String day = pickedDate.day.toString().padLeft(2, '0');
        String month = pickedDate.month.toString().padLeft(2, '0');
        String year = pickedDate.year.toString();

        widget.controller.text = "$year-$month-$day";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        cursorColor: black,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: LightTextColor,
            fontWeight: FontWeight.w400,
            fontFamily: "Satoshi",
            fontSize: TextSizes.textSize14SP,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: LightTextColor,
            fontWeight: FontWeight.w600,
            fontSize: TextSizes.textSize14SP,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: LightTextColor),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: black),
          ),
          suffixIcon: Expanded(
            child: IconButton(
              onPressed: () => _selectDate(context),
              icon: Icon(
                Icons.calendar_today,
                color: black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
