import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/custom_Text_Form_Field.dart';
import 'package:pmvvm/pmvvm.dart';

class NamePage extends StatelessWidget {
  static String routeName = "/namePage";
  const NamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _NamePage(),
      viewModel: locator<SignUpRoleViewmodel>(),
      disposeVM: false,
    );
  }
}

class _NamePage extends StatelessView<SignUpRoleViewmodel> {
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
              'Tell us your name',
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
                  CustomTextFormField(
                    controller: viewModel.firstnameController,
                    labelText: 'First name',
                    hintText: 'David',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "First name cannot be empty";
                      } else if (value.trim().length < 2) {
                        return "First name is too short";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: Spacings.spacing14.h,
                  ),
                  CustomTextFormField(
                    controller: viewModel.lastnameController,
                    labelText: 'Last name',
                    hintText: 'Peterson',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Last name cannot be empty";
                      } else if (value.trim().length < 2) {
                        return "Last name is too short";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
