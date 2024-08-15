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
import 'package:pmvvm/pmvvm.dart';

import '../../UI Actor/role/signup_role_viewmodel.dart';
import '../../widgets/custom_Text_Form_Field.dart';

class ProducerCompanyinfo extends StatelessWidget {
  static String routeName = "/producerCompanyinfo";
  const ProducerCompanyinfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerCompanyinfo(),
      viewModel: locator<SignUpRoleViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerCompanyinfo extends StatelessView<SignUpRoleViewmodel> {
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
              "Company Info",
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing34.h,
            ),
            Form(
              key: viewModel.companyInformationFormKey,
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
    );
  }
}
