import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/selectable_container.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../widgets/main_button.dart';
import 'gender_edit_viewmodel.dart';

class GenderEdit extends StatelessWidget {
  static String routeName = "/genderEdit";
  const GenderEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _GenderEdit(),
      viewModel: locator<GenderEditViewmodel>(),
      disposeVM: false,
    );
  }
}

class _GenderEdit extends StatelessView<GenderEditViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gender'),
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
            SizedBox(
              height: Spacings.spacing60.h,
            ),
            BaseText(
              'State your gender?',
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing54.h,
            ),
            SelectableRow(
              item: 'I am male',
              isSelected: viewModel.selectedGenderActorIndex == 'male',
              borderColor: borderColor,
              onTap: () {
                viewModel.selectGenderIndex('male');
                
              },
            ),
            SizedBox(
              height: Spacings.spacing14.h,
            ),
            SelectableRow(
              item: 'I am female',
              isSelected: viewModel.selectedGenderActorIndex == 'female',
              borderColor: borderColor,
              onTap: () {
                viewModel.selectGenderIndex('female');
                
              },
            ),
          ],
        ),
      ),
       floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
                child: MainButton(
              text: 'Save',
              loading: viewModel.loading,
              buttonColor: viewModel.isButtonActive ? black : buttonNotActive,
              textColor: viewModel.isButtonActive ? white : textNotActive,
              press:(){
                      viewModel.submitData();
                    },
            ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
    );
  }
}
