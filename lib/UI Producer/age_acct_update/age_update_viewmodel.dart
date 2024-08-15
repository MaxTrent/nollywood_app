import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../constants/app_colors.dart';
import '../../data/api_layer.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';

class AgeUpdateViewmodel extends ViewModel {
  final formKey = GlobalKey<FormState>();
  bool isButtonActive = false;

  late TextEditingController dateController;
  @override
  void init() {
    // TODO: implement init
    super.init();

    dateController = TextEditingController();

    dateController.addListener(() {
      final newIsButtonActive = dateController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
  }

  //Date picker
  DateTime? selectedDate;
  Future<void> selectDate(BuildContext context) async {
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
      selectedDate = pickedDate;

      // Ensure day and month are always two digits
      String day = pickedDate.day.toString().padLeft(2, '0');
      String month = pickedDate.month.toString().padLeft(2, '0');
      String year = pickedDate.year.toString();

      dateController.text = "$year-$month-$day";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dateController.dispose();
  }

  textClear() {
    dateController.clear();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  // Method to make a POST API call
  Future<void> submitData() async {
    setLoadingState();
    try {
      final accesstoken = await SecureStorageHelper.getAccessToken();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
        body: {
          "updateData": {
            "actual_age": dateController.text.trim().toString(),
          },
        },
        userAccessToken: accesstoken,
      );

      // print(userId);

      print(accesstoken);
      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];
        final userId = data['data']['user_id'];
        print(response.code);
        print(response.body);
        print(response);
        Fluttertoast.showToast(msg: message);
        print(Fluttertoast.showToast(msg: message));
        SecureStorageHelper.storeUserId(userId);
        textClear();
        Navigator.pop(context);
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        print(response.code);
        print(data);
        print(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
        print('toast${Fluttertoast.showToast(msg: message)}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e');
      print(Fluttertoast.showToast(msg: 'An error occurred: $e'));
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }
}
