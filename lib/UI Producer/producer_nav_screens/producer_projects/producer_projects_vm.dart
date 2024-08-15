import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/models/casting_project.dart';
import 'package:nitoons/utilities/api_status_response.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../../UI Actor/SignUp/login_page.dart';
import '../../../UI Actor/SignUp/sign_up.dart';
import '../../../UI Actor/SignUp/signup_modal_sheet.dart';
import '../../../constants/sizes.dart';
import '../../../constants/spacings.dart';
import '../../../data/api_layer.dart';
import '../../../data/app_storage.dart';
import '../../../models/producer_projectects.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/app_util.dart';
import '../../../widgets/base_text.dart';
import '../../../widgets/main_button.dart';

class ProducerProjectsViewModel extends ViewModel {
  @override
  void init() {
    // TODO: implement init
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

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

 Future<List<Datum>> fetchAllProducerCastingProjects() async {
    try {
      final accessToken = await SecureStorageHelper.getAccessToken();
      

      final response = await ApiLayer.makeApiCall(
        ApiUrls.getAllProducerCastingProject,
        requireAccess: true,
        method: HttpMethod.get,
        userAccessToken: accessToken,
      );

      if (response is Success) {
        final data = json.decode(response.body);
        final castingModel = CastingProject.fromJson(data);
        Fluttertoast.showToast(msg: 'Projects fetched successfully');
        return castingModel.data ?? [];
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
