import 'dart:async';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pmvvm/pmvvm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ActorUploadPostViewmodel extends ViewModel {
  bool _loading = false;
  bool get loading => _loading;
  List<PlatformFile> selectedFiles = [];
  Uint8List? thumbnail;

  @override
  void dispose() {
    super.dispose();
  }

  void setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> uploadFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );

    if (result != null) {
      selectedFiles.clear();
      selectedFiles.addAll(result.files);
      notifyListeners();
      if (selectedFiles.isNotEmpty) {
        generateThumbnail(selectedFiles.first);
      }
    }
  }

  Future<void> generateThumbnail(PlatformFile file) async {
    final thumbnailData = await VideoThumbnail.thumbnailData(
      video: file.path!,
      imageFormat: ImageFormat.PNG,
      maxWidth: 0,
      quality: 10,
    );
    thumbnail = thumbnailData;
    notifyListeners();
  }

  void removeFile(PlatformFile fileToRemove) {
    selectedFiles.removeWhere((file) => file.path == fileToRemove.path);
    thumbnail = null;
    notifyListeners();
  }
}
