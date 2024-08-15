import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pinput/pinput.dart';
import 'package:pmvvm/pmvvm.dart';

import '../phone number/phone_number_viewmodel.dart';

class PinVericationPage extends StatelessWidget {
  static String routeName = "/pinVericationPage";
  const PinVericationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _PinVericationPage(),
      viewModel: locator<PhoneNumberViewmodel>(),
      disposeVM: false,
    );
  }
}

class _PinVericationPage extends StatelessView<PhoneNumberViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: black,),
            onPressed: () {
              Navigator.pop(context);
              viewModel.pinController.clear();
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
              key: viewModel.pinVerificationFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Directionality(
                    // Specify direction if desired
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
                      // onClipboardFound: (value) {
                      //   debugPrint('onClipboardFound: $value');
                      //   pinController.setText(value);
                      // },
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
                    height: Spacings.spacing100.h,
                  ),
                  MainButton(
                    text: 'Continue',
                    buttonColor: viewModel.isButtonActive ? black : buttonNotActive,
                    textColor: viewModel.isButtonActive ? white : textNotActive,
                    
                    press: viewModel.isButtonActive?() {
                       viewModel.isButtonActive = false;

                      viewModel.validateOtp();
                    }:null,
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
    );
  }
}
