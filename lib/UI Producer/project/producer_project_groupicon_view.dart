import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/UI%20Producer/project/producer_project_viewmodel.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import '../project_details/project_details.dart';

class ProducerProjectGroupIconUploadPage extends StatefulWidget {
  static String routeName = "/producerProjectGroupIconUploadPage";

  const ProducerProjectGroupIconUploadPage({super.key});

  @override
  State<ProducerProjectGroupIconUploadPage> createState() =>
      _ProducerProjectGroupIconUploadPageState();
}

class _ProducerProjectGroupIconUploadPageState
    extends State<ProducerProjectGroupIconUploadPage> {
  @override
  Widget build(BuildContext context) {
    return MVVM<ProducerProjectViewmodel>.builder(
      viewModel: locator<ProducerProjectViewmodel>(),
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
            child: ListView(physics: BouncingScrollPhysics(), children: [
              SizedBox(
                height: Spacings.spacing10.h,
              ),
              BaseText(
                "Project Thumbnail",
                fontSize: TextSizes.textSize24SP,
                fontWeight: FontWeight.w700,
                color: black,
              ),
              SizedBox(
                height: Spacings.spacing8.h,
              ),
              BaseText(
                "Choose a profile picture from your gallery ot take a headshot with your camera.",
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
                      Radius.circular(26.r),
                    ),
                  ),
                  child: Stack(
                    children: [
                      viewModel.image != null ?
                        Center(
                          child: Image.file(
                            File(viewModel.image!.path),
                            fit: BoxFit.contain,
                          ),
                        ):
                        Center(
                          child: SvgPicture.asset(
                            Svgs.media,
                            height: 54.h,
                            width: 54.w,
                          ),
                        ),
                      Positioned(
                        bottom: -0,
                        right: -0,
                        child: GestureDetector(
                          onTap: () {
                            viewModel.uploadThumbnail();
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
                height: Spacings.spacing30.h,
              ),
            ]),
          ),
          floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
                child: MainButton(
                  loading: viewModel.loading,
                  press: () {
                    viewModel.createProducerProject(context,viewModel.image!.path);
                  },
                  text: 'Create my project',
                  buttonColor:
                      viewModel.isButtonActive ? black : buttonNotActive,
                  textColor: viewModel.isButtonActive ? white : textNotActive,
                ),
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
