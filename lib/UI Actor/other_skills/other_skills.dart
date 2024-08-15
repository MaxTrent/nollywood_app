import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/other_skills/other_skills_vm.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/components/components.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../gen/assets.gen.dart';

class OtherSkills extends StatelessWidget {
static String routeName = "/otherSkills";
  @override
  Widget build(BuildContext context) {
    return MVVM<OtherSkillsViewModel>.builder(
        viewModel: locator<OtherSkillsViewModel>(),
        disposeVM: false,
        viewBuilder: (_, viewModel) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: IconButton(
                  icon: SvgPicture.asset(
                    Assets.svgs.back,
                    colorFilter:
                        ColorFilter.mode(Colors.black, BlendMode.srcIn),
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
                        'Other Skills',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'Apart from acting, what other skills do you possess?',
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
                          hintText: 'e.g Drawing',
                          labelText: 'Skill'),
                      SizedBox(height: 13.h),
                      Column(
                        children: viewModel.textFields
                            .map((textField) => textField)
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
              floatingActionButton: Padding(
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          );
        });
  }
}
