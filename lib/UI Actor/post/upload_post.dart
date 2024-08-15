import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/components/components.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/mvvm_builder.widget.dart';

import '../../components/back_button.dart';
import 'upload_post_viewmodel.dart';

class ActorUploadPost extends StatelessWidget {
  static String routeName = "/actorUploadPost";
  const ActorUploadPost({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<ActorUploadPostViewmodel>.builder(
      viewModel: locator<ActorUploadPostViewmodel>(),
      disposeVM: false,
      viewBuilder: (_, viewModel) => Scaffold(
        appBar: AppBar(
          leading: AppBackButton(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: viewModel.selectedFiles.isEmpty
                    ? Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: 510.h,
                            decoration: BoxDecoration(color: Colors.grey),
                          ),
                          SvgPicture.asset(Svgs.iconPlay, 
                            height: 52.h,
                            width: 52.w,
                          ),
                        ],
                      )
                    : viewModel.thumbnail != null
                        ? Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                height: 510.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(viewModel.thumbnail!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                Svgs.iconPlay,
                                height: 52.h,
                                width: 52.w,
                              ),
                            ],
                          )
                        : Center(child: CircularProgressIndicator()),
              ),
              // Container(
              //   child: viewModel.selectedFiles.isEmpty? Stack(
              //   alignment: AlignmentDirectional.center,
              //   children: [
              //     Container(
              //       height: 510.h,
              //       decoration: BoxDecoration(color: Colors.grey),
              //     ),
              //     SvgPicture.asset(Assets.svgs.play, height: 52.h, width: 52.w,),
              //   ],
              // ):viewModel.selectedFiles.first,
              // ),

              SizedBox(
                height: 36.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    AppButton(
                      width: double.infinity,
                      text: 'Upload a file',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        viewModel.uploadFile();
                      },
                    ),
                    SizedBox(height: 13.h),
                    AppButton(
                      width: double.infinity,
                      text: 'Submit',
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      borderColor: Colors.black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
