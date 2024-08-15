import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

import '../add_monologues_to_role/add_monologues_to_role.dart';
import '../add_monologues_to_role/add_monologues_to_role_update.dart';
import 'producer_update_create_monologue_viewmodel.dart';

class ProducerUpdateCreateMonologueView extends StatelessWidget {
  static String routeName = "/producerUpdateCreateMonologueRolesPage";

  const ProducerUpdateCreateMonologueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerUpdateCreateMonologueView(),
      viewModel: locator<ProducerUpdateCreateMonologueViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerUpdateCreateMonologueView
    extends StatelessView<ProducerUpdateCreateMonologueViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // leading: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
        //   child: IconButton(
        //     icon: Icon(Icons.arrow_back_ios,color: black,size: 24,),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.w),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0,16.h, Spacings.spacing16.w,0
                  ),
              child: BaseText(
                'I want different scripts',
                fontSize: TextSizes.textSize14SP,
                fontWeight: FontWeight.w400,
                color: optionTextColor,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProducerAddMonologuesToRoleUpdate())),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
        child: PopScope(
          canPop: false,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              BaseText(
                'Create Monologue',
                fontSize: TextSizes.textSize24SP,
                fontWeight: FontWeight.w700,
                color: black,
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
                hintText: 'Write here',
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
                press:viewModel.isButtonActive? () {
                  viewModel.CreateUpdateSingleMonologue();
                }:null,
              ),
              SizedBox(
                height: Spacings.spacing40.h,
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Padding(
      //     padding: EdgeInsets.only(bottom: 16.h, top: 20.h),
      //     child: Padding(
      //       padding:  EdgeInsets.symmetric(horizontal: 24.w),
      //       child: MainButton(
      //         buttonColor: white,
      //         textColor: black,
      //         text: 'Save and continue',
      //         borderColor: borderColor,
      //       ),
      //     )),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
