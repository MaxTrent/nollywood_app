import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../../widgets/custom_form_date_picker.dart';
import '../publish_successful/publish_successful.dart';
import '../producer monologue/producers_monologues_roles_viewmodel.dart';
import 'producer_monologue_casting_time_viewmodel.dart';

class ProducerMonologueCastingTime extends StatelessWidget {
  static String routeName = "/producerMonologueCastingTime";
  final String projectId;
  final String producerId;
  const ProducerMonologueCastingTime( {
    Key? key,
    required this.projectId,
    required this.producerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerMonologueCastingTime(
        projectId: projectId,
        producerId: producerId,
      ),
      viewModel: locator<ProducerMonologueCastingTimeViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerMonologueCastingTime
    extends StatelessView<ProducerMonologueCastingTimeViewmodel> {
  final String projectId;
  final String producerId;

  _ProducerMonologueCastingTime(
      {super.key,
      super.reactive,
      required this.projectId,
      required this.producerId});
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            BaseText(
              'How long should the open casting last?',
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing30.h,
            ),
             Form(
                key: viewModel.Keyform,
                child: Column(
                  children: [
                    TextFormField(
                controller: viewModel.castingStartDateController,
                 readOnly: true, 
                cursorColor: black,
                decoration: InputDecoration(
        labelText: 'From',
        labelStyle: TextStyle(
          color: LightTextColor,
          fontWeight: FontWeight.w400,
          fontFamily: "Satoshi",
          fontSize: TextSizes.textSize14SP,
        ),
        hintText: 'YYYY-MM-DD',
        hintStyle: TextStyle(
          color: LightTextColor,
          fontWeight: FontWeight.w600,
          fontSize: TextSizes.textSize14SP,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LightTextColor),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: black),
        ),
        suffixIcon: IconButton(
          onPressed: () =>viewModel.selectDate(context),
          icon: Icon(
            Icons.calendar_today,
            color: black,
          ),
        ),
                ),
              ),
              SizedBox(height: 20.h,),
              TextFormField(
                controller: viewModel.castingStopDateController,
                 readOnly: true, 
                cursorColor: black,
                decoration: InputDecoration(
        labelText: 'To',
        labelStyle: TextStyle(
          color: LightTextColor,
          fontWeight: FontWeight.w400,
          fontFamily: "Satoshi",
          fontSize: TextSizes.textSize14SP,
        ),
        hintText: 'YYYY-MM-DD',
        hintStyle: TextStyle(
          color: LightTextColor,
          fontWeight: FontWeight.w600,
          fontSize: TextSizes.textSize14SP,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LightTextColor),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: black),
        ),
        suffixIcon: IconButton(
          onPressed: () =>viewModel.selectEndDate(context),
          icon: Icon(
            Icons.calendar_today,
            color: black,
          ),
        ),
                ),
              ),
            // CustomTextFormDateField(
            //   controller: viewModel.castingStartDateController,
            //   labelText: 'From',
            //   hintText: 'YYYY-MM-DD',
            // ),
            // SizedBox(
            //   height: Spacings.spacing20.h,
            // ),
            // CustomTextFormDateField(
            //   controller: viewModel.castingStopDateController,
            //   labelText: 'To',
            //   hintText: 'YYYY-MM-DD',
            // ),
            SizedBox(
              height: Spacings.spacing60.h,
            ),
            MainButton(
              press: viewModel.isButtonActive? () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    content: Center(
                      child: Container(
                         height: 400.h,
                        width: 263.w,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Spacings.spacing20.h,
                              horizontal: Spacings.spacing24.w),
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
                                'Publish Project',
                                fontSize: TextSizes.textSize16SP,
                                fontWeight: FontWeight.w700,
                                color: black,
                              ),
                              SizedBox(
                                height: Spacings.spacing8.h,
                              ),
                              BaseText(
                                'This action will publish your project for all eligible actors to apply for roles.',
                                fontSize: TextSizes.textSize14SP,
                                fontWeight: FontWeight.w400,
                                color: black,
                              ),
                              SizedBox(
                                height: Spacings.spacing10.h,
                              ),
                              MainButton(
                                loading: viewModel.publishMonologueLoading,
                                press: (){
                                  
                                        viewModel.publishProject(
                                            projectId, producerId);
                                      
                                },
                                text: 'Yes, publish',
                                buttonColor: selectColor,
                                 textColor: white
                                 ),
                              // Container(
                              //   height: Spacings.spacing40.h,
                              //   width: double.infinity,
                              //   child: ElevatedButton(
                              //     style: ButtonStyle(
                              //       backgroundColor:
                              //           MaterialStateProperty.all<Color>(
                              //               selectColor),
                              //       shape: MaterialStateProperty.all<
                              //           RoundedRectangleBorder>(
                              //         RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(
                              //               Spacings.spacing8.sp),
                              //         ),
                              //       ),
                              //     ),
                              //     onPressed: v () {
                              //           viewModel.publishProject(
                              //               projectId, producerId);
                              //         },
                              //     child: Padding(
                              //       padding: EdgeInsets.symmetric(
                              //         vertical: 10.h,
                              //       ),
                              //       child: BaseText(
                              //         textAlign: TextAlign.center,
                              //         'Yes, publish',
                              //         color: white,
                              //         fontSize: TextSizes.textSize14SP,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: Spacings.spacing20.h,
                                width: double.infinity,
                              ),
                              Container(
                                height: Spacings.spacing40.h,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Spacings.spacing8.sp),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                    ),
                                    child: BaseText(
                                      'No, Cancel',
                                      fontSize: TextSizes.textSize14SP,
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ):null,
              text: 'Proceed',
              buttonColor:viewModel.isButtonActive?black: buttonColor2,
              textColor: viewModel.isButtonActive?white: textNotActive,
            ),
            SizedBox(
              height: Spacings.spacing20.h,
            ),
            MainButton(
              press: () => Navigator.pushNamed(context, "/"),
              text: 'Don’t set a duration',
              buttonColor: white,
              textColor: black,
              borderColor: black,
            ),
            SizedBox(
              height: Spacings.spacing30.h,
            ),
          ],
        ),
      ),
      
    ])));
  }
}
