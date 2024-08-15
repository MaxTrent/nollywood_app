import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import 'camera_view_headshot.dart';
import 'headshot_vm.dart';

class HeadshotView extends StatefulWidget {
  static String routeName = "/headshotView";
  final String? imagePath;
  final String? imageSideshotPath;
  const HeadshotView({super.key, this.imagePath, this.imageSideshotPath});

  @override
  State<HeadshotView> createState() => _HeadshotViewState();
}

class _HeadshotViewState extends State<HeadshotView> {
  bool _dialogShown = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MVVM<HeadshotVm>.builder(
      viewModel: locator<HeadshotVm>(),
      disposeVM: false,
      viewBuilder: (_, viewModel) {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: black,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: Spacings.spacing10.h,
                ),
                BaseText(
                  "Add headshots",
                  fontSize: TextSizes.textSize24SP,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing8.h,
                ),
                BaseText(
                  "The app needs you to take a front and side headshot to complete your profile.",
                  fontSize: TextSizes.textSize14SP,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing44.h,
                ),
                Center(
                  child: Container(
                    height: Spacings.spacing254.h,
                    width: Spacings.spacing254.w,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(26.sp),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: widget.imagePath != null
                              ? Image.file(
                                  File(widget.imagePath.toString()),
                                  height: 198.h,
                                  width: 198.w,
                                )
                              : SvgPicture.asset(
                                  Svgs.selfieshot,
                                  height: 198.h,
                                  width: 198.w,
                                ),
                        ),
                        Positioned(
                          bottom: -0,
                          right: -0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CameraViewHeadshot()));
                              // CameraHeadshot();
                            },
                            child: SvgPicture.asset(
                              Svgs.cameraHeadshot,
                              height: 87.h,
                              width: 87.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 200.h,
                ),
                MainButton(
                  loading: viewModel.loading,
                  buttonColor: black,
                  textColor: white,
                  text: 'Continue',
                  press: () {
                    viewModel.submitData(context, widget.imagePath.toString());
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
