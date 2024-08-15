import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/language/language_vm.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../components/components.dart';
import '../../../constants/app_colors.dart';
import '../../../gen/assets.gen.dart';
import '../../../widgets/main_button.dart';
import 'language_edit_viewmodel.dart';

class LanguageEdit extends StatelessWidget {
  static String routeName = "/languageEdit";
  const LanguageEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<LanguageEditViewmodel>.builder(
        disposeVM: false,
        viewModel: locator<LanguageEditViewmodel>(),
        viewBuilder: (_, viewModel) =>Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              Assets.svgs.back,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              height: 24.h,
              width: 24.w,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What do you speak?',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 38.h,
                ),
                Column(
                  children: [
                    AppTextField(
                      controller: viewModel.primaryLanguageController,
                      hintText: 'e.g English',
                      labelText: 'Primary Language',
                    ),
                    SizedBox(
                  height: 14.h,
                ),
                AppTextField(
                  controller: viewModel.otherLanguagesController,
                  hintText: 'e.g French, Spanish',
                  labelText: 'Other Languages',
                ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
          child: MainButton(
              text: 'Save',
              loading: viewModel.loading,
              buttonColor: viewModel.isButtonActive ? black : buttonNotActive,
              textColor: viewModel.isButtonActive ? white : textNotActive,
              press: viewModel.isButtonActive
                  ? () {
                      viewModel.submitData();
                    }
                  : null,
            ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
