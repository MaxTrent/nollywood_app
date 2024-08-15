import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/edit-profile/edit-profile_viewmodel.dart';
import 'package:nitoons/components/components.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/notification_widget.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../components/back_button.dart';

class NotificationsPage extends StatefulWidget {
  static String routeName = "/notificationsPage";
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return MVVM<EditProfileViewmodel>.builder(
      viewModel: locator<EditProfileViewmodel>(),
      disposeVM: false,
      viewBuilder: (_, viewModel) {
        return Scaffold(
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: white,
              leading: AppBackButton(),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
              child: ListView(
                children: [
                  SizedBox(
                    height: Spacings.spacing10.h,
                  ),
                  BaseText(
                    "Notications",
                    fontSize: TextSizes.textSize24SP,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                  SizedBox(
                    height: Spacings.spacing10.h,
                  ),
                  TextSwitchRow(
                    text: 'Push notifications',
                    value: viewModel.switchValue,
                    onChanged: (value) {
                      setState(() {
                        viewModel.switchValue = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: Spacings.spacing32.h,
                  ),
                  TextSwitchRow(
                    text: 'Email notifications',
                    value: viewModel.switchEmail,
                    onChanged: (value) {
                      setState(() {
                        viewModel.switchEmail = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: Spacings.spacing32.h,
                  ),
                  TextSwitchRow(
                    text: 'Message requests',
                    value: viewModel.switchMessaga,
                    onChanged: (value) {
                      setState(() {
                        viewModel.switchMessaga = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: Spacings.spacing32.h,
                  ),
                ],
              ),
            ),
            floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
                child: AppButton(
                  onPressed: ()=>Navigator.pushNamed(context, "/rateAndReviewPage"),
                  text: 'Save',
                  backgroundColor: black,
                  textColor: white,
                  width: double.infinity,
                )
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                );
      },
    );
  }
}
