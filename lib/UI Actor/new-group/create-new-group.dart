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
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

class NewGroupPage extends StatelessWidget {
  static String routeName = "/newGroupPage";
  const NewGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24),
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                BaseText(
                  'Create a new group',
                  fontSize: TextSizes.textSize32SP,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
                SizedBox(
                  height: Spacings.spacing54.h,
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  labelText: 'Group name',
                  hintText: 'Mikola Casts hangout',
                ),
                SizedBox(
                  height: Spacings.spacing14.h,
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  labelText: 'Group Description',
                  hintText:
                      'A break room for the mikolo casts to unwind, recharge an, and refresh.',
                ),
                SizedBox(
                  height: Spacings.spacing60.h,
                ),
                // MainButton(
                //   text: 'Continue',
                //   buttonColor:
                //       viewModel.isButtonActive ? black : buttonNotActive,
                //   textColor: viewModel.isButtonActive ? white : textNotActive,
                //   press: () {
                //     viewModel.isButtonActive = false;
                //     viewModel.groupNameController.clear();
                //     viewModel.groupDescriptionController.clear();
                //     Navigator.pushNamed(context, '/groupIconUploadPage');
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
