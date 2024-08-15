import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Actor/Invitations/invitation_vm.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/components/back_button.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:shimmer/shimmer.dart';

class InvitationPage extends ConsumerWidget {
  static String routeName = '/InvitaionPage';
  const InvitationPage({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final invitations =
        ref.watch(InvitationPageViewModel.getAllInvitationsProvider);

    return Scaffold(
        appBar: AppBar(
            title: BaseText(
              'My Invitations',
              fontSize: TextSizes.textSize24SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            leading: AppBackButton()),
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacings.spacing24.w,
            ),
            child: invitations.when(data: (invitation) {
              return Expanded(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: invitation.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final invitationData = invitation.data![index];

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 44.h),
                          child: Row(
                            children: [
                              Image(
                                image:
                                    NetworkImage(invitationData.thumbnailUrl),
                                width: Spacings.spacing97.w,
                                height: Spacings.spacing116.h,
                              ),
                              SizedBox(width: Spacings.spacing12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      // 'Niyi Akinmolayan invited you to apply for House of Secrets as Village Witch',
                                      invitationData.congratsMessage,
                                      style: TextStyle(
                                        fontSize: TextSizes.textSize14SP.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Satoshi',
                                        color: black,
                                      ),
                                    ),
                                    SizedBox(height: Spacings.spacing14.h),
                                    Row(
                                      children: [
                                        AppButton(
                                          height: Spacings.spacing30.h,
                                          width: Spacings.spacing87.w,
                                          text: 'Accept',
                                          backgroundColor: black,
                                          textColor: white,
                                          onPressed: () {
                                            // Navigator.pushNamed(
                                            //     context, "/newGroupPage");
                                          },
                                        ),
                                        SizedBox(width: 8.w),
                                        AppButton(
                                          height: Spacings.spacing30.h,
                                          width: Spacings.spacing87.w,
                                          text: 'Reject',
                                          backgroundColor: white,
                                          textColor: selectColor,
                                          borderColor: selectColor,
                                          onPressed: () {
                                            // Navigator.pushNamed(context,
                                            //     "/groupIconUploadPage");
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }, error: (error, _) {
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 44.h),
                      child: Text(
                        // 'Niyi Akinmolayan invited you to apply for House of Secrets as Village Witch',
                        error.toString(),
                        style: TextStyle(
                          fontSize: TextSizes.textSize14SP.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Satoshi',
                          color: black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }, loading: () {
              return Expanded(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5, // Adjust for number of shimmer items
                  itemBuilder: (BuildContext context, int index) {
                    return loadingInvitations();
                  },
                ),
              );
            })

            // Expanded(
            //   child: ListView.builder(
            //     physics: NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: 50,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Column(
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(bottom: 44.h),
            //             child: Row(
            //               children: [
            //                 Image(
            //                   image: AssetImage(Pngs.projectImage),
            //                   width: Spacings.spacing97.w,
            //                   height: Spacings.spacing116.h,
            //                 ),
            //                 SizedBox(width: Spacings.spacing12.w),
            //                 Expanded(
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     mainAxisAlignment: MainAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         'Niyi Akinmolayan invited you to apply for House of Secrets as Village Witch',
            //                         style: TextStyle(
            //                           fontSize: TextSizes.textSize14SP.sp,
            //                           fontWeight: FontWeight.w400,
            //                           fontFamily: 'Satoshi',
            //                           color: black,
            //                         ),
            //                       ),
            //                       SizedBox(height: Spacings.spacing14.h),
            //                       Row(
            //                         children: [
            //                           AppButton(
            //                             height: Spacings.spacing30.h,
            //                             width: Spacings.spacing87.w,
            //                             text: 'Accept',
            //                             backgroundColor: black,
            //                             textColor: white,
            //                             onPressed: () {
            //                               Navigator.pushNamed(
            //                                   context, "/newGroupPage");
            //                             },
            //                           ),
            //                           SizedBox(width: 8.w),
            //                           AppButton(
            //                             height: Spacings.spacing30.h,
            //                             width: Spacings.spacing87.w,
            //                             text: 'Reject',
            //                             backgroundColor: white,
            //                             textColor: selectColor,
            //                             borderColor: selectColor,
            //                             onPressed: () {
            //                               Navigator.pushNamed(
            //                                   context, "/groupIconUploadPage");
            //                             },
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),

            ));
  }

  Shimmer loadingInvitations() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 44.h),
            child: Row(
              children: [
                Container(
                  width: Spacings.spacing97.w,
                  height: Spacings.spacing116.h,
                  color: Colors.white,
                ),
                SizedBox(width: Spacings.spacing12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: TextSizes.textSize14SP.sp,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      SizedBox(height: Spacings.spacing14.h),
                      Row(
                        children: [
                          Container(
                            height: Spacings.spacing30.h,
                            width: Spacings.spacing87.w,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            height: Spacings.spacing30.h,
                            width: Spacings.spacing87.w,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
