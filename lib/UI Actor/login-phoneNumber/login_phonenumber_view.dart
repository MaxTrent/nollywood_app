import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nitoons/UI Actor/login-phoneNumber/login_phonenumber_viewmodel.dart';
import 'package:nitoons/UI%20Actor/forgot_password_email/forgot_password_email.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

class LoginPhoneNumberPage extends StatelessWidget {
  static String routeName = "/loginPhoneNumberPage";
  const LoginPhoneNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _LoginPhoneNumberPage(),
      viewModel: locator<LoginPhoneNumberViewModel>(),
      disposeVM: false,
    );
  }
}

class _LoginPhoneNumberPage extends StatelessView<LoginPhoneNumberViewModel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
              viewModel.textClear();
            },
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacings.spacing18.w),
            child: BaseText(
              'Sign up',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: black,
            ),
          )
        ],
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
              "Welcome Back",
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing34.h,
            ),
            Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  IntlPhoneField(
                    flagsButtonPadding:
                        EdgeInsets.only(left: Spacings.spacing20.w),
                    focusNode: viewModel.focusNode,
                    controller: viewModel.controller,
                    initialCountryCode: 'NG',
                    dropdownIconPosition: IconPosition.trailing,
                    disableLengthCheck: true,
                    pickerDialogStyle: PickerDialogStyle(
                      // searchFieldInputDecoration: InputDecoration(
                      //   border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(Spacings.spacing5.sp),
                      // ),
                      // ),
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
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: borderColor), // Focus color
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    languageCode: "NGN",
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                  ),
                  SizedBox(
                    height: Spacings.spacing14.h,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: viewModel.passwordController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Password cannot be empty";
                      } else if (value.trim().length < 2) {
                        return "Password is too short";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: LightTextColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Satoshi",
                        fontSize: TextSizes.textSize14SP,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: LightTextColor),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: black),
                      ),
                      hintText: '*************',
                      hintStyle: TextStyle(
                        color: LightTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: TextSizes.textSize14SP,
                      ),
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  SizedBox(
                    height: Spacings.spacing14.h,
                  ),
                  GestureDetector(
                    // onTap: ,
                    child: BaseText(
                      'Forgot Password',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: black,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: Spacings.spacing57.h,
                  ),
                  MainButton(
                    text: 'Continue',
                    buttonColor:
                        viewModel.isButtonActive ? black : buttonNotActive,
                    textColor: viewModel.isButtonActive ? white : textNotActive,
                    press: viewModel.isButtonActive
                        ? () {
                            viewModel.isButtonActive = false;

                            viewModel.textClear();
                            Navigator.pushNamed(context, '/home_page');
                          }
                        : null,
                  ),
                  SizedBox(
                    height: Spacings.spacing34.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Spacings.spacing20.h,
            ),
          ],
        ),
      ),
    );
  }
}
