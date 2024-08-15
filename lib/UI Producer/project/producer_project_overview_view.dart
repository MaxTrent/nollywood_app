import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

import '../../models/producer_just_created_project_model.dart';
import 'producer_project_overview_viewmodel.dart';

class ProducerProjectOverviewPage extends StatelessWidget {
  static String routeName = "/producerProjectOverviewPage";
  const ProducerProjectOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerProjectOverviewPage(),
      viewModel: locator<ProducerProjectOverviewViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerProjectOverviewPage
    extends StatelessView<ProducerProjectOverviewViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          // leading: Padding(
          //   padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
          //   child: IconButton(
          //     icon: Icon(Icons.arrow_back_ios,color: black,size: 24,),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
          ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: Spacings.spacing20,
            ),
            FutureBuilder<PostCreatedProjectModel>(
              future: viewModel.fetchProject(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(black),
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        'Title: ${viewModel.getCreatedProjectModel.data!.projectName.toString()}',
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
                        padding: EdgeInsets.only(bottom: Spacings.spacing30.h),
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
      floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
            child: MainButton(
              press: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  CreateRoles())),
              //Navigator.pushNamed(context, "/createRoles"),
              text: 'Create roles',
              buttonColor: white,
              textColor: black,
              borderColor: black,
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
