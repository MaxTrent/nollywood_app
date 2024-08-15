import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/Education.widget.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import 'education_edit_viewmodel.dart';

class EducationEdit extends StatelessWidget {
  static String routeName = "/educationEdit";
  const EducationEdit({Key? key}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _EducationEdit(),
      viewModel: locator<EducationEditViewmodel>(),
      disposeVM: false,
    );
  }
}

class _EducationEdit extends StatelessView<EducationEditViewmodel> {
  @override
  Widget render(context, viewModel) {
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
              'Education',
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing8.h,
            ),
            BaseText(
              'What is your highest level of education?',
              fontSize: TextSizes.textSize14SP,
              fontWeight: FontWeight.w400,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing44.h,
            ),
            EducationDropdownWithTextField(),
            SizedBox(
              height: Spacings.spacing60.h,
            ),
            MainButton(
              loading:viewModel.loading,
              buttonColor: black,
              textColor: white,
              text: 'save',
              press:(){
                      viewModel.submitData();
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
