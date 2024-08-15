import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../widgets/producer_message_setting_widget.dart';
import 'producer_message_settings_viewmodel.dart';

class ProducerMessageSettings extends StatelessWidget {
  static String routeName = "/producerMessageSettings";
  const ProducerMessageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerMessageSettings(),
      viewModel: locator<ProducerMessageSettingsViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerMessageSettings extends StatelessView<ProducerMessageSettingsViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: black,size: 24,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            
            BaseText(
              'Message Settings',
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing8.h,
            ),
            BaseText(
              'Allow message requests from',
              fontSize: TextSizes.textSize14SP,
              fontWeight: FontWeight.w400,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing44.h,
            ),
            ProducerMessageSettingsDropdownWithTextField(),
            SizedBox(
              height: Spacings.spacing60.h,
            ),
            MainButton(
              buttonColor: black,
              textColor: white,
              text: 'Save',
            ),
            SizedBox(
              height: Spacings.spacing40.h,
            ),
          ],
        ),
      ),
    );
  }
}
