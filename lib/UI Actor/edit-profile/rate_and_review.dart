import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/edit-profile/edit-profile_viewmodel.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/custom_Text_Form_Field.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:nitoons/widgets/stars_component.dart';
import 'package:pmvvm/pmvvm.dart';

class RateandReviewPage extends StatefulWidget {
  static String routeName = "/rateAndReviewPage";
  const RateandReviewPage({super.key});

  @override
  State<RateandReviewPage> createState() => _RateandReviewPageState();
}

class _RateandReviewPageState extends State<RateandReviewPage> {
  @override
  Widget build(BuildContext context) {
    return MVVM<EditProfileViewmodel>.builder(
      viewModel: locator<EditProfileViewmodel>(),
      disposeVM: false,
      viewBuilder: (_, viewModel) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: white,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: black,
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
                  "Rate and review",
                  fontSize: TextSizes.textSize24SP,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing8.h,
                ),
                BaseText(
                  "How would you rate your experience?",
                  fontSize: TextSizes.textSize14SP,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing47.h,
                ),
                CustomTextFormField(
                  controller: viewModel.reviewController,
                  labelText: "Review",
                  hintText: "Write your review here",
                  maxLines: 6,
                  maxLength: 500,
                ),
                SizedBox(
                  height: Spacings.spacing26.h,
                ),
                BaseText(
                  "How would you rate the App?",
                  fontSize: TextSizes.textSize16SP,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing10.h,
                ),
                StarRatingButton(numberOfStars: 5, starColor: switchNotActive),
                SizedBox(
                  height: Spacings.spacing32.h,
                ),
                MainButton(
                  text: 'Save',
                  buttonColor:
                      viewModel.isButtonActive ? black : buttonNotActive,
                  textColor: viewModel.isButtonActive ? white : textNotActive,
                  press: viewModel.isButtonActive
                      ? () {
                          setState(() {
                            viewModel.isButtonActive = false;
                          });
                          viewModel.reviewController.clear();
                          Navigator.pushNamed(context, '/producerProjectPage');
                        }
                      : null,
                ),
                SizedBox(
                  height: Spacings.spacing30.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
