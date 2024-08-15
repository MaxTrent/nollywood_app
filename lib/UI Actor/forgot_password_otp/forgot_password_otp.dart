import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Actor/forgot_password_otp/forgot_password_otp_vm.dart';
import 'package:nitoons/UI%20Actor/reset_password/reset_password.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordOtp extends ConsumerWidget {
  static String routeName = "/ForgotPasswordOtp";
  ForgotPasswordOtp({Key? key}) : super(key: key);

  final _formKey = GlobalObjectKey<FormState>('otpform');

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ForgotPasswordOtpViewModel(ref);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24),
          child: ListView(
            physics: BouncingScrollPhysics(),
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
              BaseText(
                'Enter the 6-digit that we have sent via the phone number',
                fontSize: TextSizes.textSize16SP,
                fontWeight: FontWeight.w400,
                color: LightTextColor,
              ),
              SizedBox(
                height: Spacings.spacing30.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,
                      child: AppOtpField(viewModel: viewModel),
                    ),
                    SizedBox(
                      height: Spacings.spacing100.h,
                    ),
                    viewModel.validatePasswordResetState.isLoading
                        ? AppLoadingIndicator()
                        : AppButton(
                            onPressed: viewModel.isTextFieldFilled()
                                ? () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ResetPasswordEmail()));
                                    viewModel.validateOtp();
                                  }
                                : null,
                            text: 'Continue',
                            width: double.infinity,
                            backgroundColor: viewModel.isTextFieldFilled()
                                ? Colors.black
                                : Color(0xffEBECEF),
                            textColor: viewModel.isTextFieldFilled()
                                ? Colors.white
                                : Color(0xff828491),
                          ),
                    SizedBox(
                      height: Spacings.spacing14.h,
                    ),
                    BaseText(
                      'Resend code',
                      color: black,
                      fontSize: TextSizes.textSize16SP,
                      fontWeight: FontWeight.w400,
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

class AppOtpField extends StatelessWidget {
  const AppOtpField({
    super.key,
    required this.viewModel,
  });

  final ForgotPasswordOtpViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      preFilledWidget: Text('0',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Color(0xffE8E6EA))),
      controller: viewModel.controller,
      // focusNode: viewModel.focusNode,
      length: 6,
      defaultPinTheme: PinTheme(
        height: Spacings.spacing52.h,
        width: Spacings.spacing50.w,
        textStyle: TextStyle(fontSize: TextSizes.textSize24SP, color: black),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: borderColor),
        ),
      ),
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      listenForMultipleSmsOnAndroid: true,
      separatorBuilder: (index) => SizedBox(width: 7.w),

      hapticFeedbackType: HapticFeedbackType.lightImpact,
      // onCompleted: (pin) {
      //   debugPrint('onCompleted: $pin');
      // },
      // onChanged: (value) {
      //   debugPrint('onChanged: $value');
      // },
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      ),
    );
  }
}
