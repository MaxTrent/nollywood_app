import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:nitoons/widgets/settings_custom_widget.dart';
import 'package:pmvvm/pmvvm.dart';

import 'settings_viewmodel.dart';

class ProducerSettingsPage extends StatelessWidget {
  static String routeName = "/producerSettingsPage";
  const ProducerSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerSettingsPage(),
      viewModel: locator<ProducerSettingsViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerSettingsPage extends StatelessView<ProducerSettingsViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: BaseText(
          'Settings',
          fontSize: TextSizes.textSize24SP,
          fontWeight: FontWeight.w700,
          color: black,
        ),
        // leading: AppBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                color: black,
                borderRadius:
                    BorderRadius.all(Radius.circular(Spacings.spacing12.r)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Spacings.spacing20.w,
                    vertical: Spacings.spacing16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      'Free Membership',
                      fontSize: TextSizes.textSize18SP,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                    BaseText(
                      'Upgrade for more features',
                      fontSize: TextSizes.textSize14SP,
                      fontWeight: FontWeight.w400,
                      color: white,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Spacings.spacing32.h,
            ),
            BaseText(
              'Account',
              fontSize: TextSizes.textSize18SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing32.h,
            ),
            SettingsCustomContainer(
              text: 'Message',
              iconAsset: Svgs.messageIcon,
              forwardIconAsset: Svgs.arrowForward,
              press: () {
                Navigator.pushNamed(context, "/producerMessageSettings");
              },
            ),
            SizedBox(
              height: Spacings.spacing32.h,
            ),
            SettingsCustomContainer(
              text: 'Password',
              iconAsset: Svgs.password,
              forwardIconAsset: Svgs.arrowForward,
            ),
            SizedBox(
              height: Spacings.spacing32.h,
            ),
            SettingsCustomContainer(
              text: 'Notifications',
              iconAsset: Svgs.notification,
              forwardIconAsset: Svgs.arrowForward,
              press: () {
                Navigator.pushNamed(context, "/notificationsPage");
              },
            ),
            SizedBox(
              height: Spacings.spacing32.h,
            ),
            BaseText(
              'More',
              fontSize: TextSizes.textSize18SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing32.h,
            ),
            SettingsCustomContainer(
              text: 'Rate & Review',
              iconAsset: Svgs.review,
              forwardIconAsset: Svgs.arrowForward,
              press: () {
                Navigator.pushNamed(context, "/producerRateAndReviewPage");
              },
            ),
            SizedBox(
              height: Spacings.spacing32.h,
            ),
            SettingsCustomContainer(
              text: 'Help',
              iconAsset: Svgs.help,
              forwardIconAsset: Svgs.arrowForward,
              press: () {
                Navigator.pushNamed(context, "/producerProjectPage");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 16.h, top: 20.h),
          child: MainButton(
            buttonColor: white,
            textColor: black,
            text: 'Log out',
            press: () {
              Navigator.pushNamed(context, '/viewApplicantsPage');
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
