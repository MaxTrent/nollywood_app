import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/models/producer_projectects.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../data/api_layer.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/api_urls.dart';
import '../../utilities/app_util.dart';
import '../../data/app_storage.dart';

class ChooseAProjectViewModel extends ViewModel {
  int _selectedProjectIndex = -1; // Tracks the index of the selected project
  String? selectedProjectId;
  String? selectedProjectName;
  int get selectedProjectIndex => _selectedProjectIndex;

  void selectProject(int index, List<Data> projects) {
    selectedProjectId = projects[index].sId.toString();
    selectedProjectName = projects[index].projectName.toString();
    if (_selectedProjectIndex == index) {
      // If the same project is selected again, deselect it
      _selectedProjectIndex = -1;
      selectedProjectId = null;
      selectedProjectName = null;
    } else {
      // Select a new project
      _selectedProjectIndex = index;
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  bool isSelected(int index) => _selectedProjectIndex == index;

  Future<List<Data>> fetchAllProducerProjects() async {
    try {
      final userId = await SecureStorageHelper.getUserId();
      final accessToken = await SecureStorageHelper.getAccessToken();

      final response = await ApiLayer.makeApiCall(
        ApiUrls.getAllProducerProject + userId!,
        requireAccess: true,
        method: HttpMethod.get,
        userAccessToken: accessToken,
      );

      if (response is Success) {
        final data = json.decode(response.body);
        final projectModel = AllProducerProjects.fromJson(data);
        Fluttertoast.showToast(msg: 'Projects fetched successfully');
        return projectModel.data ?? [];
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      AppUtils.debug(e.toString());
    }
    return [];
  }
}
