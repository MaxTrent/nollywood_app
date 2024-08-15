import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Actor/forgot_password_email/forgot_password_email_vm.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/components/back_button.dart';
import 'package:nitoons/utilities/validators.dart';

import '../../components/components.dart';

class ForgotPasswordEmail extends ConsumerWidget {
  static String routeName = "/forgot_password_email";
  ForgotPasswordEmail({super.key});

  final _formKey = GlobalObjectKey<FormState>('form');

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ForgotPasswordEmailViewModel(ref);

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
                    'Forgot Password',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Please enter the email address associated with your account. We will send you a 6-digit code to reset your password.',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  AppTextField(
                    controller: viewModel.controller,
                    hintText: 'johndoe@gmail.com',
                    labelText: 'Email',
                    validator: (val) {
                      if (!val!.isValidEmail || val.isEmpty) {
                        return 'Enter valid email address';
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
          child: viewModel.requestPasswordResetState.isLoading
              ? AppLoadingIndicator()
              : AppButton(
                  onPressed: (viewModel.isTextFieldFilled() &&
                          _formKey.currentState!.validate())
                      ? () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => ForgotPasswordOtp()));
                          viewModel.requestPasswordResetOtp();
                        }
                      : null,
                  text: 'Send the reset link',
                  width: double.infinity,
                  backgroundColor: viewModel.isTextFieldFilled()
                      ? Colors.black
                      : Color(0xffEBECEF),
                  textColor: viewModel.isTextFieldFilled()
                      ? Colors.white
                      : Color(0xff828491),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
