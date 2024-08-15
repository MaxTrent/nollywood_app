import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/UI%20Producer/create_roles/create_roles.dart';
import 'package:nitoons/UI%20Producer/project/producer_project_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../components/app_button.dart';
import '../../data/app_storage.dart';
import '../../gen/assets.gen.dart';
import '../../models/producer_just_created_project_model.dart';
import '../application_criteria/application_criteria.dart';
import '../project_casting_period/producer_monologue_casting_time.dart';
import '../update_create_roles/create_roles_update.dart';
import '../update_project_details/producer_project_update_viewmodel.dart';

class ProjectDetailsRolesView extends StatelessWidget {
  static String routeName = "/projectDetailsRolesView";
  const ProjectDetailsRolesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerProjectUpdateOverviewView(),
      viewModel: locator<ProducerProjectUpdateViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerProjectUpdateOverviewView
    extends StatelessView<ProducerProjectUpdateViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BaseText(
          'Project Details',
          color: black,
          fontSize: TextSizes.textSize16SP,
          fontWeight: FontWeight.w600,
        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Spacings.spacing20,
              ),
              FutureBuilder<PostCreatedProjectModel>(
                future: viewModel.fetchUpdatedProject(),
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
                    SharedPreferencesHelper.storeProducerProjectImage(
                      viewModel.getCreatedProjectModel.data!.thumbnail
                          .toString(),
                    );
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
                          padding:
                              EdgeInsets.only(bottom: Spacings.spacing24.h),
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
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
          onTap: () => showModalBottomSheet(
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
                                      padding: EdgeInsets.symmetric(
                                          vertical: 21.h, horizontal: 24.w),
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
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          SizedBox(height: 10.h),
                                          Text(
                                            'This action enables you to filter prospects for each role you\'ve created, ensuring that only individuals who meet your criteria will apply.',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          SizedBox(height: 16.h),
                                          AppButton(
                                            onPressed: () => Navigator.of(
                                                    context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ApplicationCriteria())),
                                            height: 41,
                                            width: double.infinity,
                                            text: 'Yes, I do',
                                            backgroundColor: selectColor,
                                            textColor: Colors.white,
                                            fontweight: FontWeight.w400,
                                          ),
                                          SizedBox(height: 9.h),
                                          AppButton(
                                            height: 41,
                                            width: double.infinity,
                                            onPressed: () {},
                                            text: 'No, Just publish',
                                            backgroundColor: Colors.white,
                                            textColor: Colors.black,
                                            borderColor: borderColor,
                                            fontweight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            child: Text('View applicants',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              final id = viewModel
                                  .getCreatedProjectModel.data!.id
                                  .toString();
                              final producerId = viewModel
                                  .getCreatedProjectModel.data!.producerId
                                  .toString();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProducerMonologueCastingTime(
                                              projectId: id,
                                              producerId: producerId)));
                            },
                            child: Text('Publish for casting',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              // SharedPreferencesHelper.storeProjectName(
                              //     projectName!);
                              SharedPreferencesHelper.getProjectName();
                              viewModel.toUpdateNamePage(
                                context,
                                viewModel
                                    .getCreatedProjectModel.data!.description
                                    .toString(),
                                viewModel
                                    .getCreatedProjectModel.data!.projectName
                                    .toString(),
                                viewModel.getCreatedProjectModel.data!.id
                                    .toString(),
                              );
                              //  SharedPreferencesHelper.storeProducerProjectId(projectId!);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         ProducerProjectUpdateNameView(
                              //           projectDescription: viewModel
                              //               .getCreatedProjectModel
                              //               .data!
                              //               .description
                              //               .toString(),
                              //           projectName:projectName.toString(),
                              //           projectId:projectId.toString(),
                              //         )));
                            },
                            child: Text('Update project details',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                    ),
                  )),
          child: Container(
            height: 49.h,
            width: 49.h,
            decoration: BoxDecoration(
              color: selectColor,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: SvgPicture.asset(
                Assets.svgs.window,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          )),
    );
  }
}
