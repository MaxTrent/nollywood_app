import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/actor_lookalikes/actorlookalike_viewmodel.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../components/app_loading_indicator.dart';
import '../../components/components.dart';
import '../../gen/assets.gen.dart';
import '../awards/awards_vm.dart';

class ActorlookalikeScreen extends StatelessWidget {
  static String routeName = "/actorlookalikeScreen";
  ActorlookalikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ActorlookalikeScreen(),
      viewModel: locator<ActorlookalikeViewModel>(),
      disposeVM: false,
    );
  }
}

class _ActorlookalikeScreen extends StatelessView<ActorlookalikeViewModel> {
  @override
  Widget render(context, viewModel) => Scaffold(
        resizeToAvoidBottomInset: true,
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
                  'Actor lookalikes',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Select a few of your preferred roles and let producers know what you’re interested about.',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 38.h,
                ),
                SizedBox(height: 13.h),
                Column(
                  children: viewModel.textFields.map((textField) => textField)
                      .toList(),
                ),
                SizedBox(height: 24.h),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      viewModel.addTextField();
                    },
                    child: Text(
                      'Add more',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),

                // AppButton(text: 'Save', backgroundColor: _controller.text.isEmpty ? Colors.black: Colors.grey, textColor: Colors.white)
              ],
            ),
          ),
        ),
        floatingActionButton:Padding(
                padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
                child:viewModel.loading? AppLoadingIndicator(): AppButton(
                  onPressed: viewModel.areAllTextFieldsFilled()
                      ? () => viewModel.submitData()
                      : null,
                  text: 'Save',
                  width: double.infinity,
            backgroundColor: viewModel.areAllTextFieldsFilled()
                ? Colors.black
                : Color(0xffEBECEF),
            textColor: viewModel.areAllTextFieldsFilled()
                ? Colors.white
                : Color(0xff828491),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}
