import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Actor/project/project_view_model.dart';
import 'package:nitoons/UI%20Actor/record_monologue/record_monologue.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/components/back_button.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';

import '../record_monologue/application_monologue.dart';

class ProjectPage extends ConsumerWidget {
  static String routeName = "/projectPage";
  ProjectPage({Key? key, required this.projectId, required this.roleId}) : super(key: key);

  String projectId;
  String roleId;

  @override
  Widget build(BuildContext context, ref) {
    final project =
        ref.watch(ProjectPageViewModel.getProjectProvider(projectId));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: AppBackButton(),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
          child: project.when(data: (projectInfo) {
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                BaseText(
                  // 'House of secrets',
                  projectInfo.data!.projectName,
                  fontSize: TextSizes.textSize32SP,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing18.h,
                ),
                Image(
                  image: NetworkImage(
                    projectInfo.data!.thumbnailUrl,
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
                BaseText(
                  // 'Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.',
                  projectInfo.data!.description,
                  fontSize: TextSizes.textSize14SP,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing30.h,
                ),
                MainButton(
                  text: 'Apply now',
                  buttonColor: black,
                  textColor: white,
                  press: () {
                    showModalBottomSheet(
                      backgroundColor: white,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Spacings.spacing24.w,
                                  vertical: Spacings.spacing45.h),
                              child: Column(
                                children: [
                                  BaseText(
                                    'Are you sure?',
                                    fontSize: TextSizes.textSize24SP,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                  SizedBox(
                                    height: Spacings.spacing18.h,
                                  ),
                                  BaseText(
                                    'You’ll be requested to record and submit a monologue to apply for ${projectInfo.data!.projectName}.',
                                    fontSize: TextSizes.textSize16SP,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                  SizedBox(
                                    height: Spacings.spacing47.h,
                                  ),
                                  MainButton(
                                    buttonColor: black,
                                    textColor: white,
                                    text: 'Yes, proceed.',
                                    press: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ApplicationMonologue(roleId: roleId,)));
                                    },
                                  ),
                                  SizedBox(
                                    height: Spacings.spacing20.h,
                                  ),
                                  MainButton(
                                    buttonColor: white,
                                    textColor: black,
                                    text: 'No, cancel.',
                                    borderColor: black,
                                    press: () {
                                      Navigator.pop(context);
                                      // Navigator.pushNamed(
                                      //     context, "/friendPage");
                                    },
                                  ),
                                  SizedBox(
                                    height: Spacings.spacing30.h,
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
                  },
                ),
                SizedBox(
                  height: Spacings.spacing40.h,
                ),
              ],
            );
          }, error: (error, _) {
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                BaseText(
                  // 'House of secrets',
                  error.toString(),
                  fontSize: TextSizes.textSize32SP,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ],
            );
          }, loading: () {
            return Center(child: AppLoadingIndicator());
          })
          // ListView(
          //   physics: BouncingScrollPhysics(),
          //   children: [
          //     BaseText(
          //       'House of secrets',
          //       fontSize: TextSizes.textSize32SP,
          //       fontWeight: FontWeight.w700,
          //       color: black,
          //     ),
          //     SizedBox(
          //       height: Spacings.spacing18.h,
          //     ),
          //     Image(
          //       image: AssetImage(
          //         Pngs.projectImage,
          //       ),
          //       width: Spacings.spacing318.w,
          //       height: Spacings.spacing386.h,
          //     ),
          //     SizedBox(
          //       height: Spacings.spacing45.h,
          //     ),
          //     BaseText(
          //       'Description',
          //       fontSize: TextSizes.textSize16SP,
          //       fontWeight: FontWeight.w700,
          //       color: black,
          //     ),
          //     SizedBox(
          //       height: Spacings.spacing6.h,
          //     ),
          //     BaseText(
          //       'Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.',
          //       fontSize: TextSizes.textSize14SP,
          //       fontWeight: FontWeight.w400,
          //       color: black,
          //     ),
          //     SizedBox(
          //       height: Spacings.spacing30.h,
          //     ),
          //     MainButton(
          //       text: 'Apply now',
          //       buttonColor: black,
          //       textColor: white,
          //       press: () {
          //         showModalBottomSheet(
          //           backgroundColor: white,
          //           context: context,
          //           builder: (BuildContext context) {
          //             return Container(
          //                 height: MediaQuery.of(context).size.height * 0.45,
          //                 child: Padding(
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal: Spacings.spacing24.w,
          //                       vertical: Spacings.spacing45.h),
          //                   child: Column(
          //                     children: [
          //                       BaseText(
          //                         'Are you sure?',
          //                         fontSize: TextSizes.textSize24SP,
          //                         fontWeight: FontWeight.w700,
          //                         color: black,
          //                       ),
          //                       SizedBox(
          //                         height: Spacings.spacing18.h,
          //                       ),
          //                       BaseText(
          //                         'You’ll be requested to record and submit a monologue to apply for House of secrets.',
          //                         fontSize: TextSizes.textSize16SP,
          //                         fontWeight: FontWeight.w400,
          //                         color: black,
          //                       ),
          //                       SizedBox(
          //                         height: Spacings.spacing47.h,
          //                       ),
          //                       MainButton(
          //                         buttonColor: black,
          //                         textColor: white,
          //                         text: 'Yes, proceed.',
          //                         press: () {
          //                           Navigator.pushNamed(
          //                               context, "/InvitaionPage");
          //                         },
          //                       ),
          //                       SizedBox(
          //                         height: Spacings.spacing20.h,
          //                       ),
          //                       MainButton(
          //                         buttonColor: white,
          //                         textColor: black,
          //                         text: 'No, cancel.',
          //                         borderColor: black,
          //                         press: () {
          //                           Navigator.pushNamed(context, "/friendPage");
          //                         },
          //                       ),
          //                       SizedBox(
          //                         height: Spacings.spacing30.h,
          //                       ),
          //                     ],
          //                   ),
          //                 ));
          //           },
          //         );
          //       },
          //     ),
          //     SizedBox(
          //       height: Spacings.spacing40.h,
          //     ),
          //   ],
          // ),

          ),
    );
  }
}
