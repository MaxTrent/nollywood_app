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

class ProducerNamePage extends StatelessWidget {
  static String routeName = "/producerNamePage";
  const ProducerNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerNamePage(),
      viewModel: locator<SignUpRoleViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerNamePage extends StatelessView<SignUpRoleViewmodel> {
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
              key: viewModel.producerFormKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: viewModel.producerfirstnameController,
                    labelText: 'First name',
                    hintText: 'David',
                  ),
                  SizedBox(
                    height: Spacings.spacing14.h,
                  ),
                  CustomTextFormField(
                    controller: viewModel.producerlastnameController,
                    labelText: 'Last name',
                    hintText: 'Peterson',
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
