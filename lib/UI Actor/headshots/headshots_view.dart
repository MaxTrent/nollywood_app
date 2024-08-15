import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/UI Actor/headshots/headshot_viewmodel.dart';
import 'package:nitoons/UI%20Actor/CameraView/camera_view.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import '../CameraView/camera_sideshot.dart';

class HeadShotPage extends StatefulWidget {
  static String routeName = "/headShotPage";
  final String? imagePath;
  final String? imageSideshotPath;
  const HeadShotPage({super.key, this.imagePath, this.imageSideshotPath});

  @override
  State<HeadShotPage> createState() => _HeadShotPageState();
}

class _HeadShotPageState extends State<HeadShotPage> {
  bool _dialogShown = false;
  @override
  void initState() {
    super.initState();

    // Show dialog when the page is opened
    if (_dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              contentPadding: EdgeInsets.zero, // Remove padding
              content: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Svgs.cau,
                      height: Spacings.spacing90.h,
                      width: Spacings.spacing90.w,
                    ),
                    SizedBox(
                      height: Spacings.spacing30.h,
                    ),
                    BaseText(
                      'Incomplete profiles may not be recommended to producers, but you can always return to your profile later to complete this step and improve its visibility.',
                      fontSize: TextSizes.textSize18SP,
                      fontWeight: FontWeight.w400,
                      color: white,
                    ),
                    SizedBox(
                      height: Spacings.spacing52.h,
                    ),
                    Container(
                      height: Spacings.spacing40.h,
                      width: Spacings.spacing116.w,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(selectColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Spacings.spacing8.sp),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: BaseText(
                          textAlign: TextAlign.center,
                          'Understood!',
                          color: white,
                          fontSize: TextSizes.textSize14SP,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Spacings.spacing20.h,
                    ),
                    Container(
                      height: Spacings.spacing40.h,
                      width: Spacings.spacing116.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Spacings.spacing8.sp),
                              side: BorderSide(
                                color: white,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        child: BaseText(
                          'Cancel',
                          fontSize: TextSizes.textSize14SP,
                          fontWeight: FontWeight.w400,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).then((_) {
          setState(() {
            _dialogShown = true;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MVVM<HeadshotViewmodel>.builder(
      viewModel: locator<HeadshotViewmodel>(),
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
            actions: [
              Padding(
                padding: EdgeInsets.only(right: Spacings.spacing18.w),
                child: Center(
                  child: BaseText(
                    'Skip for now',
                    fontSize: TextSizes.textSize18SP,
                    fontWeight: FontWeight.w400,
                    color: black,
                  ),
                ),
              )
            ],
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
                                  builder: (context) => CameraHeadshot()));
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
                  height: Spacings.spacing26.h,
                ),
                Center(
                  child: Container(
                    height: Spacings.spacing254.h,
                    width: Spacings.spacing254.w,
                    decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.all(Radius.circular(26.sp))),
                    child: Stack(children: [
                      Center(
                        child: widget.imageSideshotPath != null
                            ? Image.file(
                                File(widget.imageSideshotPath.toString()),
                                height: 198.h,
                                width: 198.w,
                              )
                            : SvgPicture.asset(
                                Svgs.sideshot,
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
                                  builder: (context) => CameraSideshot()));
                            },
                            child: SvgPicture.asset(
                              Svgs.cameraSideshot,
                              height: 87.h,
                              width: 87.w,
                            ),
                          )),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                MainButton(
                  buttonColor: black,
                  textColor: white,
                  text: 'Continue',
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
