import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nitoons/UI%20Actor/record_monologue/recorded_monologue.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/main.dart';
import 'package:nitoons/utilities/base_notifier.dart';
import 'package:nitoons/utilities/base_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/monologue_script_model.dart';
import 'application_success.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as videoThumbnail;// import

class ApplicationMonologueViewModel {
  final WidgetRef ref;

  ApplicationMonologueViewModel(this.ref);

  Timer? _timer;
  final picker = ImagePicker();


  // final scrollController = ScrollController();
  // final textKey = GlobalKey();
  static final getMonologueScriptProvider = FutureProvider.family.autoDispose<MonologueScriptModel, String>((ref, projectId) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getMonologueScriptProjectId(projectId);
  });
  static final scrollControllerProvider = Provider((ref) => ScrollController());
  static final textKeyProvider = Provider((ref) => GlobalKey());
  static final mediaUploadProvider = StateProvider((ref) => '');
static final thumbnailProvider = StateProvider<String?>((ref)=> '');
  static final videoFileProvider = StateProvider<XFile?>((ref) => null);
  static final isRecordingProvider = StateProvider.autoDispose((ref) => false);
  static final timerProvider = StateProvider.autoDispose<int>((ref) => 0);
  static final cameraControllerProvider =
  FutureProvider.autoDispose<CameraController>((ref) async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front);
    final backCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back);
    final controller = CameraController(backCamera, ResolutionPreset.medium);
    await controller.initialize();
    return controller;
  });
  ScrollController get scrollController => ref.watch(scrollControllerProvider);


  void startAutoScroll(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.watch(scrollControllerProvider).hasClients) {
        final textHeight = ref.watch(textKeyProvider).currentContext?.size?.height ?? 0;
        final screenHeight = MediaQuery.of(context).size.height;

        // Start from the bottom
        ref.read(scrollControllerProvider).jumpTo(textHeight - screenHeight);

        // Animate to the top
        ref.read(scrollControllerProvider).animateTo(
          0, // Scroll to the top (0 position)
          duration: Duration(seconds: 30),
          curve: Curves.linear,
        );
      }
    });
  }







  static final descriptionProvider =
  Provider.autoDispose((ref) => TextEditingController());

  static final createApplicationNotifierProvider =
  StateNotifierProvider<CreateApplicationProjectIdNotifier, CreateApplicationProjectIdState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    final navigatorKey = ref.read(navigatorKeyProvider);
    return CreateApplicationProjectIdNotifier(
      apiService,
          () {
        navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => ApplicationSuccess()));
      },
    );
  });



  // Future<void> createApplication(String roleId) async {
  //   final media = ref.watch(videoFileProvider);

  //   ref
  //       .read(createApplicationNotifierProvider.notifier)
  //       .createApplication(roleId,);
  // }

 Future<void> createApplication(String roleId) async {
    final media = ref.watch(videoFileProvider);

    ref
        .read(createApplicationNotifierProvider.notifier)
        .createApplication(roleId, media!.path);
  }


  static final cameraDescriptionsProvider =
  FutureProvider<List<CameraDescription>>((ref) async {
    return await availableCameras();
  });

  static final frontCameraProvider = Provider<CameraDescription>((ref) {
    final cameras = ref.watch(cameraDescriptionsProvider).value;
    if (cameras != null) {
      return cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front);
    }
    throw Exception('No cameras available');
  });

  static final backCameraProvider = Provider<CameraDescription>((ref) {
    final cameras = ref.watch(cameraDescriptionsProvider).value;
    if (cameras != null) {
      return cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back);
    }
    throw Exception('No cameras available');
  });

  // static final switchCameraProvider =
  //     FutureProvider.autoDispose<CameraController>((ref) async {
  //   // Dispose the old controller
  //   ref.read(cameraControllerProvider).value?.dispose();
  //
  //   // Get the list of available cameras
  //   final cameras = await availableCameras();
  //
  //   // Determine the new camera
  //   CameraDescription newCamera;
  //   final oldCamera = ref.read(cameraControllerProvider).value?.description;
  //   if (oldCamera != null &&
  //       oldCamera.lensDirection == CameraLensDirection.back) {
  //     newCamera = cameras.firstWhere(
  //         (camera) => camera.lensDirection == CameraLensDirection.front);
  //   } else {
  //     newCamera = cameras.firstWhere(
  //         (camera) => camera.lensDirection == CameraLensDirection.back);
  //   }
  //
  //   // Create and initialize the new controller
  //   final newController = CameraController(newCamera, ResolutionPreset.medium);
  //   await newController.initialize();
  //
  //   return newController;
  // });

  static final switchCameraProvider = FutureProvider.family
      .autoDispose<CameraController, CameraDescription>(
          (ref, cameraDescription) async {
        final controller =
        CameraController(cameraDescription, ResolutionPreset.medium);
        await controller.initialize();
        // ref.watch(cameraControllerProvider).value?.dispose();
        return controller;
      });

  CameraController? get controller => ref.watch(cameraControllerProvider).value;

  CameraDescription get frontCamera => ref.watch(frontCameraProvider);

  CameraDescription get backCamera => ref.watch(backCameraProvider);

  String get mediaUpload => ref.watch(mediaUploadProvider);

  List<CameraDescription>? get cameras =>
      ref.watch(cameraDescriptionsProvider).value;

  int get timerValue => ref.watch(timerProvider);

  XFile? get recordedVideo => ref.watch(videoFileProvider);

  bool get isRecording => ref.watch(isRecordingProvider);

  String? get thumbnailPath => ref.watch(thumbnailProvider);

  void startTimer() {
    ref.read(timerProvider.notifier).state = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      ref.read(timerProvider.notifier).state++;
    });
  }

  void stopTimer() {
    print('timer stopped');
    if (_timer != null) {
      _timer!.cancel();
      print('timer cancelled');
      _timer = null;
    }
    ref.read(timerProvider.notifier).state = 0;
    print('Timer state: ${ref.read(timerProvider.notifier).state}');
  }

  Future<void> startRecordingVideo() async {
    if (controller == null) {
      throw Exception('Controller is not initialized');
    }
    if (!controller!.value.isInitialized) {
      throw Exception('Camera is not initialized');
    }
    if (controller!.value.isRecordingVideo) {
      throw Exception('A video recording is already in progress');
    }

    try {
      await controller!.startVideoRecording();
      ref.read(isRecordingProvider.notifier).state = true;
      // startTimer();
    } on CameraException {
      rethrow;
    }
  }

  Future<void> stopRecordingVideo(String roleId) async {


    if (controller == null) {
      throw Exception('Controller is not initialized');
    }
    if (!controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      final videoFile = await controller!.stopVideoRecording();
       final videoFilePath = videoFile.path;
      ref.read(videoFileProvider.notifier).state = videoFile;
      ref.read(isRecordingProvider.notifier).state = false;
      final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recordedVideoPath', videoFilePath);
      print(
          'Recorded video file: ${recordedVideo?.path}');
      final thumbnail = await generateThumbnail(recordedVideo!.path);
      ref.read(thumbnailProvider.notifier).state = thumbnail;
      // uploadPostMedia(videoFile);
      stopTimer();
      Navigator.of(ref.context)
          .push(MaterialPageRoute(builder: (context) => RecordedMonolgue(roleId: roleId)));
    } on CameraException {
      rethrow;
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }


  // void switchCamera() async {
  //   final cameras = await availableCameras();
  //   if (cameras.isEmpty) {
  //     print('No cameras available');
  //     return;
  //   }
  //
  //   CameraDescription newCamera;
  //   final currentCamera = controller?.description;
  //
  //   if (currentCamera == null) {
  //     print('Current camera is null');
  //     newCamera = cameras.first;
  //   } else {
  //     newCamera = cameras.firstWhere(
  //           (camera) => camera.lensDirection != currentCamera.lensDirection,
  //       orElse: () => cameras.first,
  //     );
  //   }
  //
  //   try {
  //     final newController = CameraController(newCamera, ResolutionPreset.medium);
  //     await newController.initialize();
  //
  //     if (controller != null) {
  //       await controller!.dispose();
  //     }
  //
  //     ref.read(cameraControllerProvider).value = AsyncValue.data(newController);
  //   } catch (e) {
  //     print('Error switching camera: $e');
  //   }
  // }

  void switchCamera() async {
    CameraDescription newDescription;
    final controller = ref.read(cameraControllerProvider).value;

    if (controller == null) {
      throw Exception('Controller is not initialized');
    }

    // ref.read(cameraControllerProvider).value?.dispose();

    if (controller.description.lensDirection == CameraLensDirection.back) {
      newDescription = ref.read(frontCameraProvider);
    } else {
      newDescription = ref.read(backCameraProvider);
    }

    final newController =
    await ref.read(switchCameraProvider(newDescription).future);
    // ref.read(cameraControllerProvider.future) = newController;
  }


  Future<String?> generateThumbnail(String videoPath) async {
    final thumbnail = await videoThumbnail.VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: videoThumbnail.ImageFormat.PNG,
      maxHeight: 64,
      quality: 75,
    );
    return thumbnail;
  }

  void displayThumbnail(String thumbnailPath) {
    Image.file(File(thumbnailPath));
  }


  // Future uploadPostMedia(XFile? file) async {
  //   // late FileUploadModel fileUploadModel;
  //
  //   try {
  //     final url = Uri.https(ApiUrls.baseUrl, ApiUrls.createNewApplicationRoleId);
  //     final request = new http.MultipartRequest('POST', url);
  //     request.headers['Authorization'] = 'Bearer ${await SecureStorageHelper.getAccessToken()}';
  //     request.headers['Content-Type'] = 'multipart/form-data';
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'media',
  //         file!.path,
  //         filename: basename(file.path),
  //       ),
  //     );
  //
  //     print('Request: $request');
  //     final response = await request.send();
  //     final responseBody = await response.stream.bytesToString();
  //     print('Full response: $responseBody');
  //     // final response = await ApiLayer.makeApiCall(ApiUrls.uploadMedia,
  //     //     method: HttpMethod.post,
  //     //     requireAccess: true,
  //     //     userAccessToken: await SecureStorageHelper.getAccessToken(),
  //     //     body: {"file": file});
  //
  //     if (response.statusCode == 200) {
  //       print('File uploaded successfully');
  //       print('Response code: ${response.statusCode}');
  //       final data = json.decode(responseBody);
  //       print('multipart response: $data');
  //       // final message = data['message'];
  //       ref.read(mediaUploadProvider.notifier).state =
  //       data['data']['media_upload']['_id'];
  //       // data['data']['mediaUpload']['id'];
  //       // AppUtils.debug(message);
  //       print(ref.read(mediaUploadProvider.notifier).state);
  //       // fileUploadModel = FileUploadModel.fromJson(data);
  //       // Fluttertoast.showToast(msg: message);
  //     } else {
  //       final data = json.decode(responseBody);
  //       print('multipart response: $data');
  //       // final message = data['message'];
  //       // fileUploadModel = FileUploadModel.fromJson(data);
  //       print('File upload failed with status: ${response.statusCode}');
  //       print('Response body: $responseBody');
  //       print(response.statusCode);
  //       // Fluttertoast.showToast(msg: message);
  //     }
  //     return response;
  //   } catch (e) {
  //     print(e);
  //     AppUtils.debug(e.toString());
  //     throw Exception(e);
  //   }
  // }

// Future<void> saveVideo(XFile video) async {
//
//   try {
//
//       ref.read(videoFileProvider.notifier).state = XFile(video.path);
//       AppUtils.debug('Video Path: ${ref.watch(videoFileProvider)!.path}');
//       await uploadPostMedia(video);
//       // createPost();
//
//   } catch (e) {
//     print(e);
//     throw Exception(e);
//   }
// }


// Future<void> pickVideo() async {
//   final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
//
//   try {
//     if (pickedFile != null) {
//       ref.read(videoFileProvider.notifier).state = XFile(pickedFile.path);
//       AppUtils.debug('Video Path: ${ref.watch(videoFileProvider)!.path}');
//       uploadPostMedia(ref.watch(videoFileProvider.notifier).state);
//       // createPost();
//     } else {
//       AppUtils.debug('No video selected');
//     }
//   } catch (e) {
//     print(e);
//     throw Exception(e);
//   }
// }

//   void _uploadFile() async {
//   if (_file != null) {
//     await uploadFile(_file!);
//   }
// }
}

class CreateApplicationProjectIdState extends BaseState {
  final dynamic data;

  CreateApplicationProjectIdState(
      {required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);
}

Future<void> storeRoleId(String roleId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('roleId', roleId);
}

class CreateApplicationProjectIdNotifier extends BaseNotifier<CreateApplicationProjectIdState> {
  CreateApplicationProjectIdNotifier(ApiServices apiServices, VoidCallback onSuccess)
      : super(apiServices, onSuccess,
      CreateApplicationProjectIdState(isLoading: false));

  Future<void> createApplication(String roleId, String mediaUpload) async {
    await execute(
          () async {
        final result = await apiService.createNewApplicationRoleId(roleId, mediaUpload);
        print('resultt: $result');
        if (result) {
          onSuccess();
          return true;
        }
        return false;
          },
      loadingState: CreateApplicationProjectIdState(isLoading: true),
      dataState: (data) =>
          CreateApplicationProjectIdState(isLoading: false, data: data),
    );
  }

  @override
  CreateApplicationProjectIdState errorState(dynamic error) {
    return CreateApplicationProjectIdState(
        isLoading: false, error: error.toString());
  }
}