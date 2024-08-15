import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/record_monologue/application_monologue_vm.dart';
import 'package:nitoons/UI%20Actor/record_monologue/application_success.dart';
import 'package:nitoons/UI%20Actor/record_monologue/record_monologue_vm.dart';
import 'package:nitoons/components/app_textfield.dart';
import 'package:nitoons/components/back_button.dart';

import '../../components/app_button.dart';
import '../../gen/assets.gen.dart';

class RecordedPost extends ConsumerWidget {
  RecordedPost({super.key});


  @override
  Widget build(BuildContext context, ref) {
    final viewModel = RecordMonologueViewModel(ref);

    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                viewModel.thumbnailPath != null
                    ?  Container(
                  height: 510.h,
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Image.file(File(viewModel.thumbnailPath!),fit: BoxFit.cover,),
                ):
                Container(
                  height: 510.h,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
                SvgPicture.asset(Assets.svgs.play, height: 52.h, width: 52.w,),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            AppTextField(
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                controller: viewModel.description, hintText: ''),
            SizedBox(
              height: 36.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  AppButton(
                      width: double.infinity,
                      text: 'Create Post',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      onPressed:viewModel.createPostState.isLoading? null: (){
                        viewModel.createPost();
                      }
                  ),
                  SizedBox(height: 13.h),
                  AppButton(
                    width: double.infinity,
                    text: 'Reselect',
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
    );
  }
}
