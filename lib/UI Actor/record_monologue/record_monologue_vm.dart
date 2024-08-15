import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nitoons/UI%20Actor/record_monologue/recorded_monologue.dart';
import 'package:nitoons/UI%20Actor/recorded_post.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/main.dart';
import 'package:nitoons/models/file_upload_model.dart';
import 'package:nitoons/models/post_model.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:nitoons/utilities/base_notifier.dart';
import 'package:nitoons/utilities/base_state.dart';
import 'package:path/path.dart';

import '../../models/application_project_model.dart';

class RecordMonologueViewModel {
  final WidgetRef ref;

  RecordMonologueViewModel(this.ref);

  Timer? _timer;
  final picker = ImagePicker();



  static final scrollControllerProvider = Provider((ref) => ScrollController());
  static final textKeyProvider = Provider((ref) => GlobalKey());
  static final mediaUploadProvider = StateProvider((ref) => '');

  static final videoFileProvider = StateProvider<XFile?>((ref) => null);
  static final isRecordingProvider = StateProvider.autoDispose((ref) => false);
  static final timerProvider = StateProvider.autoDispose<int>((ref) => 0);
  static final thumbnailProvider = StateProvider<String?>((ref)=> '');
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

  void startAutoScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.watch(scrollControllerProvider).hasClients) {
        final textHeight = ref.watch(textKeyProvider).currentContext?.size?.height ?? 0;
        final screenHeight = WidgetsBinding.instance.window.physicalSize.height / WidgetsBinding.instance.window.devicePixelRatio;

        ref.read(scrollControllerProvider).animateTo(
          textHeight - screenHeight,
          duration: Duration(seconds: 60),
          curve: Curves.linear,
        );
      }
    });
  }




  static final descriptionProvider =
      Provider.autoDispose((ref) => TextEditingController());

TextEditingController get description => ref.watch(descriptionProvider);
  static final createPostNotifierProvider =
      StateNotifierProvider<CreatePostNotifier, CreatePostState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    final navigatorKey = ref.read(navigatorKeyProvider);
    return CreatePostNotifier(
      apiService,
      () {
        navigatorKey.currentState?.popUntil(ModalRoute.withName('/home_page'));
      },
    );
  });

  Future<void> createPost() async {
    final description = ref.watch(descriptionProvider).text;
    final mediaUpload = await SharedPreferencesHelper.getMediaUpload();
    ref
        .read(createPostNotifierProvider.notifier)
        .createPost(description, mediaUpload!, ref);
  }

  // Future<void> createPost() async {
  //   final description = ref.watch(descriptionProvider).text;
  //   final media = ref.watch(mediaUploadProvider);
  //   ref
  //       .read(createPostNotifierProvider.notifier)
  //       .createPost(description, media);
  // }

  static final cameraDescriptionsProvider =
      FutureProvider<List<CameraDescription>>((ref) async {
    return await availableCameras();
  });

  CreatePostState get createPostState => ref.watch(createPostNotifierProvider);


  String? get thumbnailPath => ref.watch(thumbnailProvider);

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
    ref.watch(cameraControllerProvider).value?.dispose();
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

  Future<void> stopRecordingVideo() async {
    if (controller == null) {
      throw Exception('Controller is not initialized');
    }
    if (!controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      final videoFile = await controller!.stopVideoRecording();
      ref.read(videoFileProvider.notifier).state = videoFile;
      ref.read(isRecordingProvider.notifier).state = false;
      stopTimer();
      Navigator.of(ref.context)
          .push(MaterialPageRoute(builder: (context) => RecordedMonolgue(roleId: '',)));
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




  void switchCamera() async {
    CameraDescription newDescription;
    final controller = ref.read(cameraControllerProvider).value;

    if (controller == null) {
      throw Exception('Controller is not initialized');
    }

    ref.read(cameraControllerProvider).value?.dispose();

    if (controller.description.lensDirection == CameraLensDirection.back) {
      newDescription = ref.read(frontCameraProvider);
    } else {
      newDescription = ref.read(backCameraProvider);
    }

    final newController =
        await ref.read(switchCameraProvider(newDescription).future);
    // ref.read(cameraControllerProvider.future) = newController;
  }


  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    try {
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        AppUtils.debug('Video Path: ${pickedFile.path}');
        ref.read(createPostNotifierProvider.notifier).uploadPostMedia(file, ref);
        // createPost();
      } else {
        AppUtils.debug('No video selected');
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
      throw Exception(e);
    }
  }

  //   void _uploadFile() async {
  //   if (_file != null) {
  //     await uploadFile(_file!);
  //   }
  // }
}

class CreatePostState extends BaseState {
  final PostsModel? data;

  CreatePostState({required bool isLoading, this.data, String? error})
      : super(isLoading: isLoading, error: error);
}

class CreatePostNotifier extends BaseNotifier<CreatePostState> {
  CreatePostNotifier(ApiServices apiServices, VoidCallback onSuccess)
      : super(apiServices, onSuccess, CreatePostState(isLoading: false));

  Future<void> uploadPostMedia(File file, WidgetRef ref) async {
    final navigatorKey = ref.read(navigatorKeyProvider);
    await execute(
          () async{
            final result = await apiService.uploadPostMedia(file);
            if (result.success){
              await SharedPreferencesHelper.storeMediaUpload(result.data!.mediaUpload);
              navigatorKey.currentState?.push(MaterialPageRoute(builder: (context)=> RecordedPost()));
            }
      },
      loadingState: CreatePostState(isLoading: true),
      dataState: (data) => CreatePostState(isLoading: false, data: data),
    );
  }

  Future<void> createPost(String description, String mediaUpload, WidgetRef ref) async {
    await execute(
      () async{
        final navigatorKey = ref.read(navigatorKeyProvider);
        final result = await apiService.createPost(description, mediaUpload);
        if (result.success){
        navigatorKey.currentState?.popUntil(ModalRoute.withName('/home_page'));
        }
      },
      loadingState: CreatePostState(isLoading: true),
      dataState: (data) => CreatePostState(isLoading: false, data: data),
    );
  }

  @override
  CreatePostState errorState(dynamic error) {
    return CreatePostState(isLoading: false, error: error.toString());
  }
}


