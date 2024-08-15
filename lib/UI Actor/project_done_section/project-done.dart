import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/custom_Text_Form_Field.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import 'project_done_viewmodel.dart';

class ProjectDonePage extends StatelessWidget {
  static String routeName = "/projectDonePage";
  const ProjectDonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProjectDonePage(),
      viewModel: locator<ProjectDoneViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProjectDonePage extends StatelessView<ProjectDoneViewmodel> {
  @override
  Widget render(context, viewModel) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                'Tell us about your projects',
                fontSize: TextSizes.textSize32SP,
                fontWeight: FontWeight.w700,
                color: black,
              ),
              SizedBox(height: Spacings.spacing54.h),
              ...viewModel.projectControllers.map(
                (controller) {
                  int index = viewModel.projectControllers.indexOf(controller);
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Spacings.spacing10.h,
                          horizontal: Spacings.spacing10.w,
                        ),
                        child: _buildProjectField(
                          viewModel.projectControllers[index],
                          viewModel.producerControllers[index],
                          viewModel,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
              SizedBox(height: Spacings.spacing14.h),
              MainButton(
                buttonColor: Colors.transparent,
                textColor: black,
                text: 'Add more',
                press: () {
                  viewModel.addMore();
                },
              ),
              SizedBox(height: Spacings.spacing24.h),
              MainButton(
                loading: viewModel.loading,
                buttonColor:viewModel.isButtonActive ? black : buttonNotActive,
                textColor: viewModel.isButtonActive ? white : textNotActive,
                text: 'Save',
                press: () {
                  viewModel.submitData();
                },
              ),
              SizedBox(height: Spacings.spacing40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectField(
    TextEditingController projectController,
    TextEditingController producerController,
    ProjectDoneViewmodel viewModel,
  ) {
    return Column(
      children: [
        CustomTextFormField(
          controller: projectController,
          labelText: 'Project Name',
          hintText: 'Mikola',
          onChanged: (value) {
            viewModel.projectProducerMap[projectController.text] = producerController.text;
          },
        ),
        SizedBox(height: Spacings.spacing14.h),
        CustomTextFormField(
          controller: producerController,
          labelText: 'Producer',
          hintText: 'Niyi Akinmolayan',
          onChanged: (value) {
            viewModel.projectProducerMap[projectController.text] = value;
          },
        ),
      ],
    );
  }
}
