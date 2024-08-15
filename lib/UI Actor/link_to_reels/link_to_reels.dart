import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/link_to_reels/link_to_reels_vm.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../components/app_loading_indicator.dart';
import '../../components/components.dart';
import '../../gen/assets.gen.dart';
import '../../locator.dart';

class LinkToReels extends StatelessWidget {
   static String routeName = "/linkToReels";
  const LinkToReels({super.key});

 @override
  Widget build(BuildContext context) {
    return MVVM<LinkToReelsViewModel>.builder(
        disposeVM: false,
        viewModel: locator<LinkToReelsViewModel>(),
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
                  'Link to Reels',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Add a link to your reels so producers and casting directors can see your previous and most recent works',
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
                  hintText: 'e.g https://www.youtube.com',
                  labelText: 'Link',
                ),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, ),
    );
  }
}
