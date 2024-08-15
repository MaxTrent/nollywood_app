import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/constants/app_colors.dart';

import '../../gen/assets.gen.dart';
import 'application_monologue_vm.dart';

class ApplicationMonologue extends ConsumerWidget {
  static String routeName = "/recordMonologue";
  ApplicationMonologue({required this.roleId, super.key});

  String roleId;

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ApplicationMonologueViewModel(ref);
    final monologueScript = ref.watch(ApplicationMonologueViewModel.getMonologueScriptProvider('668c677287e5b2e8d22a8886'));



    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:  viewModel.controller == null
              ? Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey),
          ) // Show a loading spinner or some placeholder widget
              : FittedBox(
            fit: BoxFit.cover,
                child: SizedBox(
                width: viewModel.controller!.value.previewSize!.height,
                height: viewModel.controller!.value.previewSize!.width,
                child: CameraPreview(viewModel.controller!)),
              ),
        ),
          ListView(
              controller: viewModel.scrollController,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.w),
                  child: monologueScript.when(data: (script){
                    return Text(
                      script.data?.script ?? script.message,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                    );
    }, error: (error, _){
                    return Text(
                      'Failed to load script: $error',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                    );
                  }, loading: (){
                    return Center(child: AppLoadingIndicator());
                  })

                  // Text(
                  //   'Lopakhin: I bought it…I bought it! One moment…wait…if you would, ladies and gentlemen… My head’s going round and round, I can’t speak… (laughs). So now the cherry orchard is mine! Mine! (he gives a shout of laughter) Great God in heaven – the cherry orchard is mine! Tell me I’m drunk – I’m out of my mind – tell me it’s all an illusion…Don’t laugh at me! If my father and grandfather could rise from their graves and see it all happening –if they could see me, their Yermolay, their beaten, half-literate Yermolay, who ran barefoot in winter – if they could see this same Yermolay buying the estate…The most beautiful thing in the entire world! I have bought the estate where my father and grandfather were slaves, where they weren’t even allowed into the kitchens. I’m asleep – this is all just inside my head – a figment of the imagination. Hey, you in the band! Play away! I want to hear you! Everyone come and watch Yermolay Lopakhin set about the cherry orchard with his axe! Watch these trees come down! Weekend houses, we’ll build weekend houses, and our grandchildren and our great grandchildren will see a new life here…Music! Let’s hear the band play! Let’s have everything the way I want it. Here comes the new landlord, the owner of the cherry orchard!',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .displayLarge!
                  //       .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                  // ),
                ),
              ]),
          Positioned(
            bottom: 10.h,
            left: 21.w,
            right: 21.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTimer(context, viewModel),
                    GestureDetector(
                        onTap: () async {
                          if (viewModel.controller != null &&
                              viewModel.controller!.value.isRecordingVideo) {
                            await viewModel.stopRecordingVideo(roleId);
                            viewModel.stopTimer();

                          } else {
                            await viewModel.startRecordingVideo();
                            viewModel.startTimer();
                            viewModel.startAutoScroll(context);
                          }
                        },
                        child: viewModel.isRecording
                            ? SvgPicture.asset(Assets.svgs.cameraStop)
                            : SvgPicture.asset(Assets.svgs.cameraStart)),
                    GestureDetector(
                        onTap: () {
                          viewModel.switchCamera();
                        },
                        child: SvgPicture.asset(Assets.svgs.camera)),
                    // GestureDetector(
                    //   // onTap: () async => await viewModel.pickVideo(),
                    //   child: SvgPicture.asset(Assets.svgs.gallery),
                    // )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 29.w, vertical: 11.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(Assets.svgs.mono1),
                        SvgPicture.asset(Assets.svgs.mono2),
                        SvgPicture.asset(Assets.svgs.mono3),
                        SvgPicture.asset(Assets.svgs.mono4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildTimer(
      BuildContext context, ApplicationMonologueViewModel viewModel) {
    return Container(
      height: 41.h,
      width: 62.w,
      decoration: BoxDecoration(
        color: selectColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
          child: Text(
            viewModel.formatDuration(Duration(seconds: viewModel.timerValue)),
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          )),
    );
  }
}
