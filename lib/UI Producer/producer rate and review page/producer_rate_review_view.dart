import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/custom_Text_Form_Field.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:nitoons/widgets/stars_component.dart';
import 'package:pmvvm/pmvvm.dart';

import '../Producer profile/producer_profile_view.dart';
import 'producer_rate_review_viewmodel.dart';

class ProducerRateandReviewPage extends StatefulWidget {
  static String routeName = "/producerRateAndReviewPage";
  const ProducerRateandReviewPage({super.key});

  @override
  State<ProducerRateandReviewPage> createState() =>
      _ProducerRateandReviewPageState();
}

class _ProducerRateandReviewPageState extends State<ProducerRateandReviewPage> {
  @override
  Widget build(BuildContext context) {
    return MVVM<ProducerRateAndReviewViewmodel>.builder(
      viewModel: locator<ProducerRateAndReviewViewmodel>(),
      disposeVM: false,
      viewBuilder: (_, viewModel) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: white,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios,color: black,size: 24,),
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
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing26.h,
                ),
                CustomTextFormField(
                  controller: viewModel.ProducerActorReviewController,
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
                          viewModel.ProducerActorReviewController.clear();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProducerProfileView()));
                        }
                      : null,
                ),
                SizedBox(
                  height: Spacings.spacing32.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
