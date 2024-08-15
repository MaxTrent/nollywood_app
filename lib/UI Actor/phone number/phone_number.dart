import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nitoons/UI Actor/phone number/phone_number_viewmodel.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

class PhoneNumberPage extends StatefulWidget {
  static String routeName = "/phoneNumberPage";
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  @override
  Widget build(BuildContext context) {
    return MVVM<PhoneNumberViewmodel>.builder(
      viewModel: locator<PhoneNumberViewmodel>(),
      disposeVM: false,
      viewBuilder: (_, viewModel) => Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
                viewModel.phoneNumberController.clear();
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: Spacings.spacing20.h,
              ),
              BaseText(
                'Phone number',
                fontSize: TextSizes.textSize32SP,
                fontWeight: FontWeight.w700,
                color: black,
              ),
              SizedBox(
                height: Spacings.spacing10.h,
              ),
              BaseText(
                'Please enter your valid phone number. We will send you a 4-digit code to verify your account. ',
                fontSize: TextSizes.textSize16SP,
                fontWeight: FontWeight.w400,
                color: LightTextColor,
              ),
              SizedBox(
                height: Spacings.spacing50.h,
              ),
              Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    IntlPhoneField(
                      flagsButtonPadding:
                          EdgeInsets.only(left: Spacings.spacing20.w),
                      focusNode: viewModel.focusNode,
                      controller: viewModel.phoneNumberController,
                      initialCountryCode: 'NG',
                      dropdownIconPosition: IconPosition.trailing,
                      dropdownIcon: Icon(Icons.arrow_drop_down,
                        color: black,
                      ),
                      disableLengthCheck: true,
                      pickerDialogStyle: PickerDialogStyle(
                        backgroundColor: white,
                        countryCodeStyle: TextStyle(
                          color: black,
                          fontFamily: "Satoshi",
                          fontWeight: FontWeight.w400,
                          fontSize: TextSizes.textSize14SP,
                        ),
                        countryNameStyle: TextStyle(
                          color: black,
                          fontFamily: "Satoshi",
                          fontWeight: FontWeight.w400,
                          fontSize: TextSizes.textSize14SP,
                        ),
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor),
                            borderRadius:
                                BorderRadius.circular(Spacings.spacing5.sp)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: borderColor), // Focus color
                          borderRadius:
                              BorderRadius.circular(Spacings.spacing8.sp),
                        ),
                      ),
                      languageCode: "NGN",
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                      },
                      cursorColor: black,
                    ),
                    SizedBox(
                      height: Spacings.spacing70.h,
                    ),
                    MainButton(
                      text: 'Continue',
                      loading: viewModel.loading,
                      buttonColor:
                          viewModel.isButtonActive ? black : buttonNotActive,
                      textColor:
                          viewModel.isButtonActive ? white : textNotActive,
                      press: viewModel.isButtonActive
                          ? () {
                              setState(() {
                                viewModel.isButtonActive = false;
                              });
                              viewModel.getPhoneVerificationCode();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // viewModel: locator<PhoneNumberViewmodel>(),
      // disposeVM: false,
    );
  }
}
