import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../constants/app_colors.dart';
import '../../data/api_layer.dart';
import '../../data/app_storage.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';
import '../publish_successful/publish_successful.dart';

class ProducerMonologueCastingTimeViewmodel extends ViewModel {
  bool isButtonActive = false;
  late TextEditingController castingStartDateController;
  late TextEditingController castingStopDateController;
final Keyform = GlobalKey<FormState>();
  @override
  void init() {
    super.init();
    castingStartDateController = TextEditingController();
    castingStopDateController = TextEditingController();

    castingStartDateController.addListener(() {
      final newIsButtonActive = castingStartDateController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });

    castingStopDateController.addListener(() {
      final newIsButtonActive = castingStopDateController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    castingStartDateController.dispose();
    castingStopDateController.dispose();
    super.dispose();
    notifyListeners();
  }

  textClear() {
    castingStartDateController.clear();
    castingStopDateController.clear();
  }

  

  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

//Date picker
  DateTime? selectedDate;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
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

      castingStartDateController.text = "$year-$month-$day";
    }
  }

  DateTime? selectedEndDate;
  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? pickedEndDate = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
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
    if (pickedEndDate != null && pickedEndDate != selectedEndDate) {
      selectedEndDate = pickedEndDate;

      // Ensure day and month are always two digits
      String day = pickedEndDate.day.toString().padLeft(2, '0');
      String month = pickedEndDate.month.toString().padLeft(2, '0');
      String year = pickedEndDate.year.toString();

      castingStopDateController.text = "$year-$month-$day";
    }
  }

  bool _publishMonologueLoading = false;
  bool get publishMonologueLoading => _publishMonologueLoading;

  void setLoadingPublishMonologueState() {
    _publishMonologueLoading = !_publishMonologueLoading;
    notifyListeners();
  }
  
  Future publishProject(projectId, producerId) async {
    setLoadingPublishMonologueState();

    try {
      //  final producerId = SharedPreferencesHelper.getProducerId();
      // final projectId = SharedPreferencesHelper.getProducerProjectId();
      if (producerId.toString().isNotEmpty && projectId.toString().isNotEmpty) {
        final accesstoken = await SecureStorageHelper.getAccessToken();
        final response = await ApiLayer.makeApiCall(ApiUrls.publishProject,
            method: HttpMethod.put,
            requireAccess: true,
            body: {
              "project_id": projectId,
              "producer_id": producerId,
              "cast_start": castingStartDateController.text.toString(),
              "cast_end": castingStopDateController.text.toString(),
            },
            userAccessToken: accesstoken);
        if (response is Success) {
          print('project published');
          AppUtils.debug(response.body);
          final data = json.decode(response.body);
          final message = data['message'];

          AppUtils.debug(message);
          print(response.body);
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => PublishSuccessful()));
               Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => PublishSuccessful()),
    (Route<dynamic> route) => false, // Remove all previous routes
  );
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   '/producer_home_page',
          //   (Route<dynamic> route) => false,
          // );
          Fluttertoast.showToast(msg: message);
        } else if (response is Failure) {
          print('project not published');
          final data = json.decode(response.errorResponse);
          final message = data['message'];
          Fluttertoast.showToast(msg: message);
        }
      }
    } catch (e) {
      AppUtils.debug(e.toString());
    } finally {
      setLoadingPublishMonologueState();
      
    }
  }
}
