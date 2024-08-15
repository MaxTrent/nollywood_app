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

import 'filmmaker_profile_edit_viewmodel.dart';

class FilmmakerProfileEdit extends StatelessWidget {
  static String routeName = "/filmmakerProfileEdit";
  const FilmmakerProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _FilmmakerProfileEdit(),
      viewModel: locator<FilmmakerProfileEditViewmodel>(),
      disposeVM: false,
    );
  }
}

class _FilmmakerProfileEdit
    extends StatelessView<FilmmakerProfileEditViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Filmmaker Profile'),
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
              height: Spacings.spacing20.h,
            ),
            BaseText(
              'Filmmaker Profile',
              fontSize: TextSizes.textSize24SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing40.h,
            ),
            Form(
              key:viewModel.producerFilmMakerFormKey ,
              child: CustomTextFormField(
                controller: viewModel.filmmakerprofileController,
                labelText: 'Nollywood filmmaker profile ',
                hintText: 'Write here',
                maxLength: 500,
                maxLines: 7,
              ),
            ),
            SizedBox(
              height: Spacings.spacing60.h,
            ),
            MainButton(
              text: 'Save',
              loading: viewModel.loading,
              buttonColor: viewModel.isButtonActive ? black : buttonNotActive,
              textColor: viewModel.isButtonActive ? white : textNotActive,
              press: viewModel.isButtonActive
                  ? () {
                      viewModel.submitData();
                    }
                  : null,
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
