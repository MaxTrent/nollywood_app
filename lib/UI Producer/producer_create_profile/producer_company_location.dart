import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../UI Actor/role/signup_role_viewmodel.dart';
import '../../widgets/custom_Text_Form_Field.dart';

class ProducerCompanyLocation extends StatelessWidget {
  static String routeName = "/producerCompanyLocation";
  const ProducerCompanyLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerCompanyLocation(),
      viewModel: locator<SignUpRoleViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerCompanyLocation extends StatelessView<SignUpRoleViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: Spacings.spacing80.h,
            ),
            BaseText(
              "Company Location",
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing34.h,
            ),
            Form(
              key: viewModel.companyLocationFormKey,
              child: Column(
                children: [
                  CustomTextFormField(
                controller: viewModel.companyaddressController,
                labelText: 'Address',
                hintText: '2, Bolaji Close, Kudirat Abiola Way, 100212, Ikeja',
              ),
                  SizedBox(
                    height: Spacings.spacing16.h,
                  ),
                  CustomTextFormField(
                controller: viewModel.companycityController,
                labelText: 'City',
                hintText: 'City',
              ),
                  SizedBox(
                    height: Spacings.spacing16.h,
                  ),
                  CustomTextFormField(
                controller: viewModel.companystateController,
                labelText: 'State',
                hintText: 'Lagos',
              ),
              SizedBox(
                    height: Spacings.spacing16.h,
                  ),
                  CustomTextFormField(
                controller: viewModel.companycountryController,
                labelText: 'Country',
                hintText: 'Nigeria',
              ),
               SizedBox(
                    height: Spacings.spacing40.h,
                  ),
                  // MainButton(
                  //   text: 'Continue',
                  //   buttonColor:
                  //       viewModel.isButtonActive ? black : buttonNotActive,
                  //   textColor: viewModel.isButtonActive ? white : textNotActive,
                  //   press: viewModel.isButtonActive
                  //       ? () {
                  //           viewModel.isButtonActive = false;

                  //           viewModel.textClear();
                  //           Navigator.pushNamed(context, '/home_page');
                  //         }
                  //       : null,
                  // ),
                  
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
