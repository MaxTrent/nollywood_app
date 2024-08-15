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
import 'camera_view_sideshot.dart';
import 'headshot_vm.dart';
import 'sideshot_vm.dart';

class Headsideshot extends StatefulWidget {
  static String routeName = "/headsideshot";
  final String? imagePath;
  final String? imageSideshotPath;
  const Headsideshot({super.key, this.imagePath, this.imageSideshotPath});

  @override
  State<Headsideshot> createState() => _HeadsideshotState();
}

class _HeadsideshotState extends State<Headsideshot> {
  bool _dialogShown = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MVVM<SideshotVm>.builder(
      viewModel: locator<SideshotVm>(),
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
                  "Add sideshots",
                  fontSize: TextSizes.textSize24SP,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing8.h,
                ),
                BaseText(
                  "The app needs you to take a sideshot to complete your profile.",
                  fontSize: TextSizes.textSize14SP,
                  fontWeight: FontWeight.w400,
                  color: black,
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
                                  builder: (context) => CameraViewSideshot()));
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
                  height: 200.h,
                ),
                MainButton(
                    loading: viewModel.loading,
                    buttonColor: black,
                    textColor: white,
                    text: 'Continue',
                    press: () {
                      viewModel.submitSideShotData(widget.imageSideshotPath);
                    }),
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
