import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Producer/project/producer_project_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/custom_Text_Form_Field.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import 'producer_project_update_viewmodel.dart';

class ProducerProjectUpdateDescriptionView extends StatelessWidget {
  static String routeName = "/producerProjectUpdateDescriptionView";
  const ProducerProjectUpdateDescriptionView({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerProjectUpdateDescriptionView(),
      viewModel: locator<ProducerProjectUpdateViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerProjectUpdateDescriptionView
    extends StatelessView<ProducerProjectUpdateViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
              size: 24,
            ),
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
              'Project Description',
              fontSize: TextSizes.textSize24SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing40.h,
            ),
            CustomTextFormField(
              controller: viewModel.ProjectDescriptionController,
              labelText: 'Project Description',
              hintText: 'Write here',
              maxLength: 500,
              maxLines: 7,
            ),
            SizedBox(
              height: Spacings.spacing60.h,
            ),
            MainButton(
              text: 'Continue',
              buttonColor: viewModel.isButtonActive ? black : buttonNotActive,
              textColor: viewModel.isButtonActive ? white : textNotActive,
              press: () {
                // viewModel.storeValues(viewModel.ProjectDescriptionController.text.trim().toString());
                // Navigator.pushNamed(context, '/producerProjectGroupIconUploadPage');
                viewModel.groupIconPage(context);
              },
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
