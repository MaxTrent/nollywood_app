import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Actor/email_address_signUp/email_address.dart';
import 'package:nitoons/UI%20Actor/forgot_password_email/forgot_password_email.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../constants/app_colors.dart';
import 'login_email_address_viewmodel.dart';

class LoginEmailAddressPage extends StatelessWidget {
  static String routeName = "/loginEmailAddressPage";
  const LoginEmailAddressPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _LoginEmailAddressPage(),
      viewModel: locator<LoginEmailAddressViewmodel>(),
      disposeVM: false,
    );
  }
}

class _LoginEmailAddressPage extends StatelessView<LoginEmailAddressViewmodel> {
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
            padding: EdgeInsets.symmetric(
                horizontal: Spacings.spacing18.w,
                vertical: Spacings.spacing18.h),
            child: BaseText(
              'Sign up',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailAddressSignUp(),
                  ),
                );
              },
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
                  TextFormField(
                    controller: viewModel.emailController,
                    cursorColor: black,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Email cannot be empty";
                      } else if (value.trim().length < 2) {
                        return "Email is too short";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
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
                      hintText: 'Johndoe@gmail.com',
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
                    controller: viewModel.passwordController,
                    obscureText: viewModel.isPasswordHidden,
                    cursorColor: black,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Password cannot be empty";
                      } else if (value.trim().length < 5) {
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
                      suffixIcon: InkWell(
                        onTap: () {
                          viewModel.togglePassword();
                        },
                        child: Icon(
                          viewModel.isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: LightTextColor),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: black),
                      ),
                      hintText: '*****************',
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
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPasswordEmail())),
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
                    loading: viewModel.loading,
                    buttonColor:
                        viewModel.isLoginButtonActive ? black : buttonNotActive,
                    textColor:
                        viewModel.isLoginButtonActive ? white : textNotActive,
                    press: viewModel.isLoginButtonActive
                        ? () async {
                            if (viewModel.formKey.currentState!.validate()) {
                              viewModel.isLoginButtonActive = false;
                              viewModel.actorEmailSignUserIn();
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
            SizedBox(
              height: Spacings.spacing20.h,
            ),
          ],
        ),
      ),
    );
  }
}
