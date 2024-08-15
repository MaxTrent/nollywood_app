import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../../widgets/custom_form_date_picker.dart';
import '../../../widgets/drop_down_field.dart';

class AgePage extends StatelessWidget {
  static String routeName = "/agePage";
  const AgePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _AgePage(),
      viewModel: locator<SignUpRoleViewmodel>(),
      disposeVM: false,
    );
  }
}

class _AgePage extends StatelessView<SignUpRoleViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
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
                key: viewModel.Keyform,
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
                height: Spacings.spacing14.h,
                            ),
                            DropdownWithTextField(),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
