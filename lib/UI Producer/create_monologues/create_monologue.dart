import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/constants/app_colors.dart';

import '../../../gen/assets.gen.dart';
import '../invitation_success/invitation_success.dart';
import 'create_monologue_vm.dart';

class CreateMonologue extends ConsumerWidget {
  CreateMonologue({super.key});


  @override
  Widget build(BuildContext context, ref) {
    final viewModel = CreateMonologuesViewModel(ref);
    return Scaffold(
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
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 24.w),
            child: Container(
              height: 29.h,
              width: 157.w,
              decoration: BoxDecoration(
                color: selectColor.withOpacity(0.15),
                border: Border.all(
                  color: selectColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(154.r),
              ),
              child: Center(
                child: Text(
                  'I want a single script',
                  style: Theme
                      .of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(
                      fontWeight: FontWeight.w400, color: selectColor),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Monologue',
                style: Theme
                    .of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Create monologues for all the roles in this project that you are casting for.',
                style: Theme
                    .of(context)
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
                        (index) =>
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 35.h),
                          child: GestureDetector(
                            onTap: () {
                              viewModel.selectMonologueTile(index);
                            },
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        'Adaeze Johnson',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      GestureDetector(
                                        // onTap: ()=> Navigator.pushNamed(context, '/producerCurrentRolePage'),
                                        child: SvgPicture.asset(
                                          Assets.svgs.chevron,
                                          height: 20.h,
                                          width: 20.w,
                                          colorFilter: ColorFilter.mode(
                                              viewModel.isSelected(index)
                                                  ? selectColor
                                                  : Color(0xffADAFBB),
                                              BlendMode.srcIn),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton:
      Padding(
        padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
        child: AppButton(
          width: double.infinity,
          onPressed: () =>
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InvitationSuccess())),
          text: 'Invite to apply',
          backgroundColor: true ? Colors.black : Color(0xffEBECEF),
          textColor: true ? Colors.white : Color(0xff828491),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
