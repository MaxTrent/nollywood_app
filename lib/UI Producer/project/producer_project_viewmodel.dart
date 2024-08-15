import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/locator.dart';
import 'package:path/path.dart';
import 'package:pmvvm/pmvvm.dart';
import "package:flutter/material.dart";
import '../../data/api_layer.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';
import 'package:http_parser/http_parser.dart';

import 'producer_project_overview_view.dart';

class ProducerProjectViewmodel extends ViewModel {
  final apiLayer = locator<ApiLayer>();
  final storedValue = locator<SharedPreferencesHelper>();
  bool isButtonActive = false;
  late TextEditingController ProjectNameController;
  late TextEditingController ProjectDescriptionController;

  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  void init() {
    super.init();
    ProjectNameController = TextEditingController();
    ProjectDescriptionController = TextEditingController();

    ProjectNameController.addListener(() {
      final newIsButtonActive = ProjectNameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    ProjectDescriptionController.addListener(() {
      final newIsButtonActive = ProjectDescriptionController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    ProjectNameController.dispose();
    ProjectDescriptionController.dispose();
    super.dispose();
    notifyListeners();
  }

  void storeValues(value) async {
    SharedPreferencesHelper.storeProjectName(value);
    SharedPreferencesHelper.storeProjectDescription(value);
    final projectName = await SharedPreferencesHelper.getProjectName();
    final projectDescription =
        await SharedPreferencesHelper.getProjectDescription();
    print(projectName.toString());
    print(projectDescription.toString());
    print(projectName.toString());
    print(projectDescription.toString());
  }

  descriptionPage(BuildContext context) {
    if (ProjectNameController.text.trim().toString().isNotEmpty) {
      SharedPreferencesHelper.storeProjectName(
          ProjectNameController.text.trim().toString());

      Navigator.pushNamed(context, '/producerProjectDescriptionPage');
    } else {
      return;
    }
  }

  groupIconPage(BuildContext context) {
    if (ProjectDescriptionController.text.trim().toString().isNotEmpty) {
      SharedPreferencesHelper.storeProjectDescription(
          ProjectDescriptionController.text.trim().toString());
      Navigator.pushNamed(context, '/producerProjectGroupIconUploadPage');
    } else {
      return;
    }
  }

  String? storedImagePath;

  StoreImage(String path) {
    if (image!.path.isNotEmpty) {
      SharedPreferencesHelper.storeProducerProjectImage(path);
    } else {
      return;
    }
  }

// Loading state
  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  // Group picture upload for producer
  File? image;
  Future uploadThumbnail() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    } else {
      print('no image selected');
    }

    updateColorState();
    notifyListeners();
  }

  void removeImage() {
    image = null;
    notifyListeners();
  }

  Future deleteImage() async {
    image = null;
  }

  deleteTextController() {
    ProjectNameController.clear();
    ProjectDescriptionController.clear();
  }

  void updateColorState() {
    final newIsButtonActive = image != null && image!.path.isNotEmpty;
    if (isButtonActive != newIsButtonActive) {
      isButtonActive = newIsButtonActive;
      notifyListeners();
    }
  }

  Future<Response> _sendMultipartRequest(
    Uri url,
    Map<String, String> headers,
    Map<String, dynamic> data,
  ) async {
    var dio = Dio();

    var formData = FormData();
    data.forEach((key, value) {
      if (value is List<MultipartFile>) {
        formData.files.addAll(value.map((file) => MapEntry(key, file)));
      } else if (value is MultipartFile) {
        formData.files.add(MapEntry(key, value));
      } else if (value != null) {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    var options = Options(
      headers: headers,
      contentType: 'multipart/form-data',
    );

    var response = await dio.postUri(
      url,
      data: formData,
      options: options,
    );

    return response;
  }

  Future<void> createProducerProject(
      BuildContext context, String imageSaved) async {
    setLoadingState();
     final accessToken = await SecureStorageHelper
          .getAccessToken(); // Replace with actual method
      final projectName = await SharedPreferencesHelper.getProjectName();
      final projectDescription =
          await SharedPreferencesHelper.getProjectDescription();
    try {
      //  final imageSaved = await SharedPreferencesHelper.getProducerImage();
      if (projectName!.isNotEmpty && projectDescription!.isNotEmpty) {
        var url = Uri.parse(
            'https://${ApiUrls.baseUrl}${ApiUrls.createProducerProject}');

        Map<String, String> headers = {
          'Authorization': 'Bearer $accessToken',
        };

        MultipartFile? thumbnailFile;
        if (imageSaved.isNotEmpty && imageSaved.isNotEmpty) {
          String? mimeType = lookupMimeType(imageSaved);
          thumbnailFile = await MultipartFile.fromFile(
            imageSaved,
            filename: basename(imageSaved),
            contentType: MediaType.parse(mimeType!),
          );
        }

        var data = {
          'project_name': projectName,
          'description': projectDescription,
          'thumbnail': thumbnailFile,
        };

        final response = await _sendMultipartRequest(url, headers, data);

        debugPrint('Response status code: ${response.statusCode}');
        debugPrint('Response data: ${response.data}');

        if (response.statusCode == 200) {
          final responseData = response.data as Map<String, dynamic>;
          final message = responseData['message'] as String;
          final String projectId = responseData['data']['_id'];
          SharedPreferencesHelper.storeProducerProjectId(projectId);
          print('this is the responseData $responseData');
          print("this is the projectId $projectId");
          debugPrint(message);
          deleteTextController();
          removeImage();
         Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ProducerProjectOverviewPage()),
            (route) => false,
          ); // Navigate to your success page
          Fluttertoast.showToast(msg: message);
        } else if (response is Failure) {
          final responseData = response.data as Map<String, dynamic>;
          final message = responseData['message'] as String;
          AppUtils.debug(response.data);
          debugPrint('File upload failed with status: ${response.statusCode}');
          debugPrint('Response data: $responseData');
          Fluttertoast.showToast(msg: message);
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      Fluttertoast.showToast(msg: 'An error occurred. Please try again later.');
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }

  // late PostCreatedProjectModel getCreatedProjectModel;

  // Future<PostCreatedProjectModel> fetchCreatedProject() async {
  //   try {
  //     final projectId = await SharedPreferencesHelper.getProducerProjectId();
  //     final accessToken = await SecureStorageHelper.getAccessToken();
  //     final response = await ApiLayer.makeApiCall(
  //       ApiUrls.getProducerProject + projectId!,
  //       requireAccess: true,
  //       method: HttpMethod.get,
  //       userAccessToken: accessToken,
  //     );
  //     print('${ApiUrls.getUserProfile}/$projectId');
  //     if (response is Success) {
  //       final data = json.decode(response.body);
  //       final message = data['message'];

  //       final projectCreatedModel = PostCreatedProjectModel.fromJson(data);
  //       getCreatedProjectModel = projectCreatedModel;
  //       AppUtils.debug(response.body);
  //       AppUtils.debug(message);
  //       print(response);
  //       Fluttertoast.showToast(msg: message);
  //       return projectCreatedModel;
  //     } else if (response is Failure) {
  //       print(response);
  //       final data = json.decode(response.errorResponse);
  //       final message = data['message'];
  //       Fluttertoast.showToast(msg: message);
  //     }
  //   } catch (e) {
  //     AppUtils.debug(e.toString());
  //     Fluttertoast.showToast(msg: 'Error fetching user profile');
  //   }
  //   notifyListeners(); // Notify listeners to update the UI
  //   return getCreatedProjectModel;
  // }
}
