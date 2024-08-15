import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class ProducerProjectUpdateNameView extends StatelessWidget {
  static String routeName = "/producerProjectUpdateNameView";
  final String projectDescription;
  final String projectId;
  const ProducerProjectUpdateNameView({
    Key? key,
    required this.projectDescription,
    required this.projectId,
    required String projectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerProjectUpdateNameView(
          projectDescription: projectDescription, projectId: projectId),
      viewModel: locator<ProducerProjectUpdateViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerProjectUpdateNameView
    extends StatelessView<ProducerProjectUpdateViewmodel> {
  final String projectId;
  final String projectDescription;
  _ProducerProjectUpdateNameView(
      {required this.projectDescription, required this.projectId});
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
              'Project name',
              fontSize: TextSizes.textSize24SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing40.h,
            ),
            Form(
              key: viewModel.formKey,
              child: CustomTextFormField(
                controller: viewModel.ProjectNameController,
                labelText: 'Project name',
                hintText: 'David',
                validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a project name';
                      }
                      return null;
                    },
                //      onChanged: (value) {
                //   viewModel.onProjectNameChanged(value);
                // },
              ),
            ),
            SizedBox(
              height: Spacings.spacing60.h,
            ),
            MainButton(
              text: 'Continue',
              buttonColor: viewModel.isButtonActive ? black : buttonNotActive,
              textColor: viewModel.isButtonActive ? white : textNotActive,
              press: () {
                
                viewModel.descriptionPage(
                    context, projectDescription, projectId);
               
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
