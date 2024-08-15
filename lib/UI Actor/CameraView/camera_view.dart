import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Actor/headshots/headshots_view.dart';
import 'package:nitoons/components/back_button.dart';
import 'package:nitoons/constants/app_colors.dart';

import '../../constants/spacings.dart';
import '../../widgets/main_button.dart';

class CameraHeadshot extends StatefulWidget {
  const CameraHeadshot({
    super.key,
  });

  @override
  State<CameraHeadshot> createState() => _CameraHeadshotState();
}

late CameraController controller;

class _CameraHeadshotState extends State<CameraHeadshot> {
  late CameraController controller;

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: AppBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: initializationCamera(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: CameraPreview(controller),
                      ),
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Image.asset(
                          'assets/png/camera-overlay.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: Spacings.spacing30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacings.spacing24.w,
              ),
              child: MainButton(
                text: 'Save headshot',
                buttonColor: black,
                textColor: white,
                press: () async {
                  try {
                    // Ensure that the camera is initialized.
                    await initializationCamera();

                    // Attempt to take a picture and get the file `image`
                    // where it was saved.
                    final image = await controller.takePicture();

                    if (!context.mounted) return;

                    // If the picture was taken, display it on a new screen.
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HeadShotPage(
                          // Pass the automatically generated path to
                          // the DisplayPictureScreen widget.
                          imagePath: image.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  } // Navigator.pushNamed(context, '/houseRulesPage');
                },
              ),
            ),
            SizedBox(
              height: Spacings.spacing20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacings.spacing24.w,
              ),
              child: MainButton(
                text: 'Delete and retake',
                buttonColor: white,
                textColor: black,
                borderColor: black,
                press: () {
                  Navigator.pop(
                      context); // Navigator.pushNamed(context, '/houseRulesPage');
                },
              ),
            ),
            SizedBox(
              height: Spacings.spacing30.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initializationCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
      cameras[EnumCameraDescription.back.index],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await controller.initialize();
  }

  // void onTakePicture() async {
  //   await controller.takePicture().then((XFile xfile) {
  //     if (mounted) {
  //       if (xfile != null) {
  //         // showDialog(
  //         //   context: context,
  //         //   builder: (context) => AlertDialog(
  //         //     title: Text('Ambil Gambar'),
  //         //     content: SizedBox(
  //         //       width: 200.0,
  //         //       height: 200.0,
  //         //       child: CircleAvatar(
  //         //         backgroundImage: Image.file(
  //         //           File(xfile.path),
  //         //         ).image,
  //         //       ),
  //         //     ),
  //         //   ),
  //         // );
  //       }
  //     }
  //     return;
  //   });
  // }
}

enum EnumCameraDescription { front, back }
