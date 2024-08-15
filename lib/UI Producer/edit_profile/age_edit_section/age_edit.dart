import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/gen/assets.gen.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../../../widgets/custom_form_date_picker.dart';
import '../../../../widgets/drop_down_field.dart';
import '../../../widgets/main_button.dart';
import 'age_edit_viewmodel.dart';

class AgeEdit extends StatelessWidget {
  static String routeName = "/ageEdit";
  const AgeEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _AgeEdit(),
      viewModel: locator<AgeEditViewmodel>(),
      disposeVM: false,
    );
  }
}

class _AgeEdit extends StatelessView<AgeEditViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update Age'),
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.svgs.back,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            height: 24.h,
            width: 24.w,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
              'What’s your age?',
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing54.h,
            ),
              Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    TextFormField(
                controller: viewModel.dateController,
                 readOnly: true, 
                cursorColor: black,
                decoration: InputDecoration(
        labelText: 'Actual Age',
        labelStyle: TextStyle(
          color: LightTextColor,
          fontWeight: FontWeight.w400,
          fontFamily: "Satoshi",
          fontSize: TextSizes.textSize14SP,
        ),
        hintText: 'YYYY-MM-DD',
        hintStyle: TextStyle(
          color: LightTextColor,
          fontWeight: FontWeight.w600,
          fontSize: TextSizes.textSize14SP,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LightTextColor),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: black),
        ),
        suffixIcon: IconButton(
          onPressed: () =>viewModel.selectDate(context),
          icon: Icon(
            Icons.calendar_today,
            color: black,
          ),
        ),
                ),
              ),
                    SizedBox(
                height: Spacings.spacing60.h, )

                  ],
                ),
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
              press: viewModel.isButtonActive
                  ? () {
                      viewModel.submitData();
                    }
                  : null,
            ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
