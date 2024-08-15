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
import 'package:pmvvm/pmvvm.dart';
import 'package:pmvvm/view_model.dart';
import '../../components/app_button.dart';
import '../../gen/assets.gen.dart';
import '../../models/producer_just_created_project_model.dart';
import '../../widgets/main_button.dart';
import '../application_criteria/application_criteria.dart';
import '../project_casting_period/producer_monologue_casting_time.dart';
import '../project_details/project_details.dart';
import '../project_details_roles/project_details_roles_view.dart';
import 'producers_monologues_roles_viewmodel.dart';

class ProducerMonologueProjectDetailsPage extends StatelessWidget {
  static String routeName = "/producerMonologueProjectDetailsPage";

  const ProducerMonologueProjectDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerMonologueProjectDetailsPage(),
      viewModel: locator<ProducerMonologueRolesviewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerMonologueProjectDetailsPage
    extends StatelessView<ProducerMonologueRolesviewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: BaseText('Project Details',
        fontSize: TextSizes.textSize16SP,
        fontWeight: FontWeight.w600,
        color: black,
        ),
        // leading: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back_ios,
        //       color: black,
        //       size: 24,
        //     ),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 18.w),
        //     child: Row(
        //       children: [
        //         BaseText(
        //           'Project Status',
        //           fontSize: TextSizes.textSize12SP,
        //           fontWeight: FontWeight.w700,
        //           color: black,
        //         ),
        //         SizedBox(
        //           width: Spacings.spacing8.w,
        //         ),
        //         Container(
        //           decoration: BoxDecoration(
        //             color: white,
        //             borderRadius: BorderRadius.all(Radius.circular(45.r)),
        //             border: Border.all(
        //               color: borderColor,
        //               width: 1,
        //             ),
        //           ),
        //           child: Padding(
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: Spacings.spacing16.w,
        //                 vertical: Spacings.spacing4.h),
        //             child: BaseText(
        //               'I want different scripts',
        //               fontSize: TextSizes.textSize14SP,
        //               fontWeight: FontWeight.w400,
        //               color: optionTextColor,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Spacings.spacing24.w, vertical: Spacings.spacing20.h),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: Spacings.spacing20.h,
            ),
            FutureBuilder<PostCreatedProjectModel>(
              future: viewModel.fetchCreatedProject(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      Center(
                          child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(black),
                      )),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        viewModel.getCreatedProjectModel.data!.projectName
                            .toString(),
                        fontSize: TextSizes.textSize24SP,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                      SizedBox(
                        height: Spacings.spacing30.h,
                      ),
                      Image(
                        image: NetworkImage(
                          viewModel.getCreatedProjectModel.data!.thumbnail
                              .toString(),
                        ),
                        width: Spacings.spacing318.w,
                        height: Spacings.spacing386.h,
                      ),
                      SizedBox(
                        height: Spacings.spacing45.h,
                      ),
                      BaseText(
                        'Description',
                        fontSize: TextSizes.textSize16SP,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                      SizedBox(
                        height: Spacings.spacing6.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Spacings.spacing24.h),
                        child: BaseText(
                          viewModel.getCreatedProjectModel.data!.description
                              .toString(),
                          fontSize: TextSizes.textSize14SP,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      SizedBox(
                        height: Spacings.spacing70.h,
                      ),
                    ],
                  );
                } else {
                  return Center(child: BaseText('No project found'));
                }
              },
            ),
            SizedBox(
              height: Spacings.spacing30.h,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: selectColor,
        onPressed: () => showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => Container(
                  height: 233.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 33.h),
                        Text('What do you want to do?',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontSize: TextSizes.textSize18SP,
                                    fontWeight: FontWeight.w700)),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return buildApplicantsCriteriaDialog(
                                  context, viewModel);
                            },
                          ),
                          child: Text('Publish for casting',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.w400)),
                        ),
                        SizedBox(height: 20.h),
                        BaseText(
                          'Update project details',
                          fontSize: TextSizes.textSize16SP,
                          color: black,
                          fontWeight: FontWeight.w400,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ProjectDetailsRolesView()));
                          },
                        ),
                      ],
                    ),
                  ),
                )),
        child: Center(
          child: SvgPicture.asset(
            Svgs.floationOptions,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        shape: CircleBorder(),
      ),
    );
  }

  Dialog buildApplicantsCriteriaDialog(
      BuildContext context, ProducerMonologueRolesviewmodel ViewModel) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      // height: 403.h,
      // width: 263.w,
      // decoration: BoxDecoration(
      //   color: Colors.white,

      // ),
      child: Container(
        width: 263.w,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Assets.svgs.caution),
              SizedBox(height: 16.h),
              Text(
                'Do you wish to set criteria for applicants?',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Text(
                'This action enables you to filter prospects for each role you\'ve created, ensuring that only individuals who meet your criteria will apply.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16.h),
              AppButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ApplicationCriteria()));
                },
                height: 41,
                width: double.infinity,
                text: 'Yes, I do',
                backgroundColor: selectColor,
                textColor: Colors.white,
                fontweight: FontWeight.w400,
              ),
              SizedBox(height: 9.h),
              MainButton(
                text: 'No, Just publish',
                loading: ViewModel.publishMonologueLoading,
                press: () {
                  final id =
                      ViewModel.getCreatedProjectModel.data!.id.toString();
                  final producerId = ViewModel
                      .getCreatedProjectModel.data!.producerId
                      .toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProducerMonologueCastingTime(
                              projectId: id, producerId: producerId)));
                },
                buttonColor: Colors.white,
                textColor: Colors.black,
                borderColor: borderColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
