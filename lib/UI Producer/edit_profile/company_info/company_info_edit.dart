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

import '../../../widgets/custom_Text_Form_Field.dart';
import 'company_info_edit_viewmodel.dart';

class CompanyInfoEdit extends StatelessWidget {
  static String routeName = "/companyInfoEdit";
  const CompanyInfoEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _CompanyInfoEdit(),
      viewModel: locator<CompanyInfoEditViewmodel>(),
      disposeVM: false,
    );
  }
}

class _CompanyInfoEdit extends StatelessView<CompanyInfoEditViewmodel> {
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
              height: Spacings.spacing20.h,
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
                controller: viewModel.companynameController,
                labelText: 'Company name',
                hintText: 'Anthill Studios',
              ),
                  SizedBox(
                    height: Spacings.spacing16.h,
                  ),
                  CustomTextFormField(
                controller: viewModel.companyemailController,
                labelText: 'Company email',
                hintText: 'AnthillStudios@gmaill.com',
              ),
                  SizedBox(
                    height: Spacings.spacing16.h,
                  ),

                  IntlPhoneField(
                    flagsButtonPadding:
                        EdgeInsets.only(left: Spacings.spacing20.w),
                    focusNode: viewModel.focusNode,
                    controller: viewModel.companyphonenumberController,
                    initialCountryCode: 'NG',
                    dropdownIconPosition: IconPosition.trailing,
                    disableLengthCheck: true,
                    pickerDialogStyle: PickerDialogStyle(
                      // searchFieldInputDecoration: InputDecoration(
                      //   border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(Spacings.spacing5.sp),
                      // ),
                      // ),
                      backgroundColor: white,
                      countryCodeStyle: TextStyle(
                        color: black,
                        fontFamily: "Satoshi",
                        fontWeight: FontWeight.w400,
                        fontSize: TextSizes.textSize14SP,
                      ),
                      countryNameStyle: TextStyle(
                        color: black,
                        fontFamily: "Satoshi",
                        fontWeight: FontWeight.w400,
                        fontSize: TextSizes.textSize14SP,
                      ),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Company phone number (optional)',
                      labelStyle: TextStyle(
                         color: LightTextColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Satoshi",
                        fontSize: TextSizes.textSize14SP,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: borderColor), // Focus color
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    languageCode: "NGN",
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                  ),
                  SizedBox(
                    height: Spacings.spacing57.h,
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
