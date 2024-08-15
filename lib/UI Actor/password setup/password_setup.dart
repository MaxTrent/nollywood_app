import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import '../phone number/phone_number_viewmodel.dart';

class PasswordSetUpPage extends StatelessWidget {
  static String routeName = "/passwordSetUpPage";
  const PasswordSetUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _PasswordSetUpPage(),
      viewModel: locator<PhoneNumberViewmodel>(),
      disposeVM: false,
    );
  }
}

class _PasswordSetUpPage extends StatelessView<PhoneNumberViewmodel> {
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
              viewModel.passwordController.clear();
              viewModel.confirmPasswordController.clear();
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
              "Password setup",
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing14.h,
            ),
            BaseText(
              'Choose a secure password for your account. Ensure to include special characters like @%^&* etc. for maximum security ',
              fontSize: TextSizes.textSize16SP,
              fontWeight: FontWeight.w400,
              color: LightTextColor,
            ),
            SizedBox(
              height: Spacings.spacing25.h,
            ),
            Form(
              key: viewModel.passwordFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: viewModel.passwordController,
                    obscureText: true,
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
                      hintText: '*******************',
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
                  TextFormField(
                    controller: viewModel.confirmPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Confirm Password cannot be empty";
                      } else if (value.trim().length < 2) {
                        return "Confirm Password is too short";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
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
                      hintText: '*******************',
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
                    height: Spacings.spacing32.h,
                  ),
                  MainButton(
                    text: 'Continue',
                    buttonColor:
                        viewModel.isButtonActive ? black : buttonNotActive,
                    textColor: viewModel.isButtonActive ? white : textNotActive,
                    press: viewModel.isButtonActive
                        ? () {
                            if (viewModel.passwordsMatch()) {
                              // viewModel.isButtonActive = false;
                              viewModel.actorPhoneNumberSignUserUp();
                            } else {
                              // Show error message or handle passwords not matching
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Passwords do not match'),
                                  content: Text(
                                      'Please make sure the passwords match.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        : null,
                  ),
                  SizedBox(
                    height: Spacings.spacing34.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
