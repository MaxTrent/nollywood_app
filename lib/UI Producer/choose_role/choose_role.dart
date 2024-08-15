import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../gen/assets.gen.dart';
import '../invitation_success/invitation_success.dart';
import 'choose_role_vm.dart';

class ChooseRole extends StatelessWidget {
  final String? projectId;
  final String? projectName;
  ChooseRole({super.key,  this.projectId, this.projectName});

  @override
  Widget build(BuildContext context) {
    return MVVM<ChooseRoleViewModel>.builder(
        disposeVM: false,
        viewModel: locator<ChooseRoleViewModel>(),
        viewBuilder: (_, viewModel) {
          return
           Scaffold(
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
                      'Choose role',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Which of your created roles in $projectName would you like to add to apply for?',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Column(
                        children: List.generate(
                      5,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                            right: index % 2 == 0 ? 11.w : 0, bottom: 35.h),
                        child: GestureDetector(
                          onTap: () => viewModel.selectRole(index),
                          child: Container(
                              clipBehavior: Clip.hardEdge,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: viewModel.isSelected(index)
                                        ? selectColor
                                        : Color(0xffE8E6EA),
                                    width: 1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 18.h),
                                child: Text(
                                  'Adaeze Johnson',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              )),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
              child: AppButton(
                width: double.infinity,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InvitationSuccess())),
                text: 'Invite to apply',
                backgroundColor: true ? Colors.black : Color(0xffEBECEF),
                textColor: true ? Colors.white : Color(0xff828491),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        });
  }
}
