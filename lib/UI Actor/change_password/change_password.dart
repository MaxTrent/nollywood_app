import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/components/back_button.dart';

import '../../components/app_button.dart';
import '../../components/app_textfield.dart';
import 'change_password_vm.dart';

class ChangePassword extends ConsumerWidget {
  const ChangePassword({super.key});


  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ChangePasswordViewModel(ref);


    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: AppBackButton(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change password',
                  style: Theme
                      .of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text('Change your password',
                  style: Theme
                      .of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 38.h,
                ),
                AppTextField(controller: viewModel.oldPasswordController,
                  labelText: 'Old password', hintText: '',),
                SizedBox(height: 11.h),
                AppTextField(controller: viewModel.newPasswordController,
                  labelText: 'New password', hintText: '',),
                SizedBox(height: 11.h),
                AppTextField(controller: viewModel.confirmPasswordController,
                  labelText: 'Confirm password', hintText: '',),
                SizedBox(height: 11.h),


              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
          child: AppButton(
            onPressed: viewModel.areTextFieldsFilled() ? () =>
                Navigator.pop(context) : null,
            text: 'Save',
            width: double.infinity,
            backgroundColor:
            viewModel.areTextFieldsFilled() ? Colors.black : Color(0xffEBECEF),
            textColor: viewModel.areTextFieldsFilled() ? Colors.white : Color(
                0xff828491),
          ),
        ),
       )
      ,
    );
  }
}
