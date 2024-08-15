import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/UI Actor/headshots/headshot_viewmodel.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

class GroupIconUploadPage extends StatefulWidget {
  static String routeName = "/groupIconUploadPage";
  const GroupIconUploadPage({super.key});

  @override
  State<GroupIconUploadPage> createState() => _GroupIconUploadPageState();
}

class _GroupIconUploadPageState extends State<GroupIconUploadPage> {
  
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
                icon: Icon(Icons.arrow_back_ios),
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
                  "Group Icon",
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
                        borderRadius: BorderRadius.all(Radius.circular(26.r),
                        ),
                      ),
                    child: Stack(
                      children: [
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
                          child: SvgPicture.asset(
                            Svgs.cameraHeadshot,
                            height: 87.h,
                            width: 87.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Spacings.spacing26.h,
                ),
                MainButton(buttonColor: containerColor, textColor: LightTextColor, text: 'Continue',),
              SizedBox(
                  height: Spacings.spacing40.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
