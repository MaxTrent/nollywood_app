import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Actor/forgot_password_otp/forgot_password_otp.dart';
import 'package:nitoons/UI%20Actor/password_reset_successful/password_reset_successful.dart';
import 'package:nitoons/UI%20Actor/reset_password/reset_password_vm.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/components/back_button.dart';
import '../../components/components.dart';

class ResetPasswordEmail extends ConsumerWidget {
  static String routeName = "/reset_password_email";
  ResetPasswordEmail({super.key});

  final _formKey = GlobalObjectKey<FormState>('resetpasswordemail');

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ResetPasswordEmailViewModel(ref);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(leading: AppBackButton()),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reset your password',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Choose a new unique password for your account',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  AppTextField(
                    obscureText: true,
                    controller: viewModel.passwordController,
                    hintText: '*******************',
                    labelText: 'Password',
                    validator: (val) {
                      if (val!.length < 8) {
                        return 'Password too short';
                      } else if (val.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AppTextField(
                    obscureText: true,
                    controller: viewModel.confirmPasswordController,
                    hintText: '*******************',
                    labelText: 'Confirm Password',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please confirm password';
                      } else if (val != viewModel.passwordController.text) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                  ),
                  // SizedBox(height: 13.h),

                  // AppButton(text: 'Save', backgroundColor: _controller.text.isEmpty ? Colors.black: Colors.grey, textColor: Colors.white)
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
          child: viewModel.resetPasswordState.isLoading
              ? AppLoadingIndicator()
              : AppButton(
                  onPressed: (viewModel.areTextFieldsFilled() &&
                          _formKey.currentState!.validate())
                      ? () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => PasswordResetSuccessful()));
                          viewModel.resetPassword();
                        }
                      : null,
                  text: 'Reset password',
                  width: double.infinity,
                  backgroundColor: viewModel.areTextFieldsFilled()
                      ? Colors.black
                      : Color(0xffEBECEF),
                  textColor: viewModel.areTextFieldsFilled()
                      ? Colors.white
                      : Color(0xff828491),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
