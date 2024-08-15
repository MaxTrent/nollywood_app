import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Producer/add_monologues_to_role/add_monologues_to_role_vm.dart';
import 'package:nitoons/UI%20Producer/producer%20monologue/producers_monologues_roles_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/custom_Text_Form_Field.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

class ProducerCurrentRolePage extends StatelessWidget {
  static String routeName = "/producerCurrentRolePage";
  final String roleName;
  final String roleId;
  const ProducerCurrentRolePage({Key? key, required this.roleName, required  this.roleId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerCurrentRolePage(roleName: roleName, roleId:roleId),
      viewModel: locator<ProducerAddMonologuesToRoleViewModel>(),
      disposeVM: false,
    );
  }
}

class _ProducerCurrentRolePage
    extends StatelessView<ProducerAddMonologuesToRoleViewModel> {
  final String roleName;
final String roleId;
  _ProducerCurrentRolePage({super.key, super.reactive, required this.roleName,required this.roleId,});
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
              size: 24,
            ),
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
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Current role: ',
                      style: TextStyle(
                        fontSize: TextSizes.textSize24SP,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )),
                  TextSpan(
                      text: roleName,
                      style: TextStyle(
                        fontSize: TextSizes.textSize18SP,
                        fontWeight: FontWeight.w700,
                        color: selectColor,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: Spacings.spacing8.h,
            ),
            BaseText(
              'Create monologues for all the roles in this project that you are casting for.',
              fontSize: TextSizes.textSize14SP,
              fontWeight: FontWeight.w400,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing26.h,
            ),
            CustomTextFormField(
              controller: viewModel.monologueScriptController,
              labelText: 'Monologue Script',
              hintText: 'Paste your monologue here',
              maxLength: 500,
              maxLines: 10,
            ),
            SizedBox(
              height: Spacings.spacing15.h,
            ),
            CustomTextFormField(
              controller: viewModel.monologueTitleController,
              labelText: 'Title',
              hintText: 'Village Witch Monologue Niyi',
            ),
            SizedBox(
              height: Spacings.spacing80.h,
            ),
            MainButton(
              text: 'Continue',
              loading: viewModel.loading,
              buttonColor: viewModel.isButtonActive ? black : buttonNotActive,
              textColor: viewModel.isButtonActive ? white : textNotActive,
              press: () {
                viewModel.isButtonActive = false;
                viewModel.createMonologueForRoles(roleId);
                
              },
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
