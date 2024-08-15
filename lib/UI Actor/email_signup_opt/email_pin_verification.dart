import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/data/api_layer.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pinput/pinput.dart';
import 'package:pmvvm/pmvvm.dart';

import '../email_address_signUp/email_address_signup_viewmodel.dart';

class EmailPinVerificationPage extends StatefulWidget {
  static const String routeName = "/emailPinVerificationPage";

  final String emailAddress;

  const EmailPinVerificationPage({Key? key, required this.emailAddress})
      : super(key: key);

  @override
  _EmailPinVerificationPageState createState() =>
      _EmailPinVerificationPageState();
}

class _EmailPinVerificationPageState extends State<EmailPinVerificationPage> {
  late EmailAddressSignUpViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator<EmailAddressSignUpViewmodel>();
    viewModel.setEmailAddress(widget.emailAddress);
    startTimer();
  }

  // OTP Timer
  int _seconds = 120;
  Timer? _timer;
  bool get otpExpired => _seconds <= 0;
  
  void startTimer() {
    _seconds = 120;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

void resetTimer() {
    setState(() {
      _seconds = 120;
      _timer?.cancel();
    });
  }
  String get timerText {
    final minutes = _seconds ~/ 60;
    final seconds = _seconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  
bool _ResendOtpLoading = false;
  bool get ResendOtpLoading => _ResendOtpLoading;
  setLoadingResendOtpState() {
    _ResendOtpLoading = !_ResendOtpLoading;
  }
  Future resendOtp() async {
    setLoadingResendOtpState();
    try {

      final response = await ApiLayer.makeApiCall(
        ApiUrls.initiateSignUpEmail,
        method: HttpMethod.post,
        body: {"email": widget.emailAddress},
      );

      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
        resetTimer();
        startTimer();
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        print('API call failed: $message');
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      print('Exception in resendOtp: $e');
    } finally {
      setLoadingResendOtpState();
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
            onPressed: () {
              Navigator.pop(context);
              viewModel.pinController.clear();
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Spacings.spacing20.h,
              ),
              BaseText(
                'Verification code',
                fontSize: TextSizes.textSize32SP,
                fontWeight: FontWeight.w700,
                color: black,
              ),
              SizedBox(
                height: Spacings.spacing14.h,
              ),
              Container(
                child: BaseText(
                  'Enter the 6-digit that we have sent via the email address ${widget.emailAddress}',
                  fontSize: TextSizes.textSize16SP,
                  fontWeight: FontWeight.w400,
                  color: LightTextColor,
                ),
              ),
              SizedBox(
                height: Spacings.spacing30.h,
              ),
              Form(
                key: viewModel.pinVerificationFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: viewModel.pinController,
                        focusNode: viewModel.focusNode,
                        length: 6,
                        defaultPinTheme: PinTheme(
                          height: Spacings.spacing52.h,
                          width: Spacings.spacing50.w,
                          textStyle: TextStyle(
                              fontSize: TextSizes.textSize24SP, color: black),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: borderColor),
                          ),
                        ),
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          return null;
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Spacings.spacing20.h,
                    ),
                    Text(
                      'Time remaining: ${timerText}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: otpExpired ? Colors.red : Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: Spacings.spacing100.h,
                    ),
                    MainButton(
                      text: 'Continue',
                      loading: viewModel.pinloading,
                      buttonColor: viewModel.isButtonPinVerificationActive
                          ? black
                          : buttonNotActive,
                      textColor: viewModel.isButtonPinVerificationActive
                          ? white
                          : textNotActive,
                      press: viewModel.isButtonPinVerificationActive
                          ? () {
                              viewModel.isButtonPinVerificationActive = false;
                              viewModel.validateOtp();
                            }
                          : null,
                    ),
                    SizedBox(
                      height: Spacings.spacing14.h,
                    ),
                    // if (viewModel.otpExpired)
                    //   TextButton(
                    //     onPressed: viewModel.resendOtp,
                    //     child: Text(
                    //       'Resend OTP',
                    //       style: TextStyle(
                    //         fontSize: 16.sp,
                    //         color: black,
                    //       ),
                    //     ),
                    //   ),
                    MainButton(
                      buttonColor: white,
                      text: 'Resend code',
                      textColor: black,
                      press: () {
                        otpExpired==true
                            ? {resendOtp()}
                            : null;
                      },
                    ),
                    SizedBox(
                      height: Spacings.spacing34.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
