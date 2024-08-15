import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/height/height_vm.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../components/app_textfield.dart';
import '../../../gen/assets.gen.dart';
import '../../../locator.dart';
import '../../../widgets/main_button.dart';
import '../awards_edit_section/awards_edit_viewmodel.dart';
import 'height_edit_viewmodel.dart';

class   HeightEdit extends StatelessWidget {
  static String routeName = "/heightEdit";
  const   HeightEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<HeightEditViewmodel>.builder(
        disposeVM: false,
        viewModel: locator<HeightEditViewmodel>(),
        viewBuilder: (_, viewModel) => Scaffold(
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
                  'How tall are you?',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),

                SizedBox(
                  height: 38.h,
                ),
                Form(
                  key: viewModel.formKey,
                  child: AppTextField(
                    controller: viewModel.heightController,
                    hintText: 'e.g 6’9',
                    labelText: 'Height',
                  ),
                ),

                // AppButton(text: 'Save', backgroundColor: _controller.text.isEmpty ? Colors.black: Colors.grey, textColor: Colors.white)
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
