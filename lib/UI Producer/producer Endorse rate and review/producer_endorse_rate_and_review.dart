import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Producer/producer%20Endorse%20rate%20and%20review/producer_endorse_rate_and_review_viewmodel.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/components/back_button.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:nitoons/widgets/app_star_rating.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/custom_Text_Form_Field.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:nitoons/widgets/stars_component.dart';

class ProducerEndorseRateandReviewPage extends ConsumerWidget {
  static String routeName = "/producerEndorseRateAndReviewPage";
  const ProducerEndorseRateandReviewPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ProducerEndorseRateAndReviewViewmodel(ref);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: white,
            leading: AppBackButton()),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
          child: Column(
            // physics: BouncingScrollPhysics(),
            children: [
              BaseText(
                "Endorse Adesuwa",
                fontSize: TextSizes.textSize24SP,
                fontWeight: FontWeight.w700,
                color: black,
              ),
              SizedBox(
                height: Spacings.spacing8.h,
              ),
              BaseText(
                "Write something inspiring about Adesuwa to boost her chances with producers",
                fontSize: TextSizes.textSize14SP,
                fontWeight: FontWeight.w400,
                color: black,
              ),
              SizedBox(
                height: Spacings.spacing26.h,
              ),
              CustomTextFormField(
                controller: viewModel.controller,
                labelText: "Endorsement review",
                hintText: "Write your review here",
                maxLines: 6,
                maxLength: 500,
              ),
              SizedBox(
                height: Spacings.spacing26.h,
              ),
              BaseText(
                "How would you rate the Adesuwa?",
                fontSize: TextSizes.textSize16SP,
                fontWeight: FontWeight.w700,
                color: black,
              ),
              SizedBox(
                height: Spacings.spacing10.h,
              ),
              AppStarRating(
                numberOfStars: 5,
                starColor: switchNotActive,
                onRatingChanged: (rating) => viewModel.onRatingChanged(rating),
              ),
              SizedBox(
                height: Spacings.spacing32.h,
              ),
              viewModel.createEndorsementState.isLoading
                  ? AppLoadingIndicator()
                  : MainButton(
                      text: 'Save',
                      buttonColor:
                          viewModel.isButtonActive() ? black : buttonNotActive,
                      textColor:
                          viewModel.isButtonActive() ? white : textNotActive,
                      press: viewModel.isButtonActive()
                          ? () {
                              viewModel.createEndorsement();
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => ProducerProfileScreen()));
                            }
                          : null,
                    ),
              SizedBox(
                height: Spacings.spacing32.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
