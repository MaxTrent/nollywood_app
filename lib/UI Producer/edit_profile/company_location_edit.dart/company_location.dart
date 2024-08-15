import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../../widgets/custom_Text_Form_Field.dart';
import 'company_location_edit_viewmodel.dart';

class CompanyLocationEdit extends StatelessWidget {
  static String routeName = "/companyLocationEdit";
  const CompanyLocationEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _CompanyLocationEdit(),
      viewModel: locator<CompanyLocationEditViewmodel>(),
      disposeVM: false,
    );
  }
}

class _CompanyLocationEdit extends StatelessView<CompanyLocationEditViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: white,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: Spacings.spacing30.h,
            ),
            BaseText(
              "Company Info",
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing34.h,
            ),
            Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                controller: viewModel.companyaddressController,
                labelText: 'Address',
                hintText: '2, Bolaji Close, Kudirat Abiola Way, 100212, Ikeja',
              ),
                  
                  SizedBox(
                    height: Spacings.spacing57.h,
                  ),
                  
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
    );
  }
}
