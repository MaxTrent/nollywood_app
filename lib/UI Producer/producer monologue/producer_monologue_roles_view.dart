import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Producer/producer%20monologue/producers_monologues_roles_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:nitoons/widgets/producer_monologue_roles_widget.dart';
import 'package:pmvvm/pmvvm.dart';

class ProducerMonologueRolesPage extends StatelessWidget {
  static String routeName = "/producerMonologueRolesPage";
  const ProducerMonologueRolesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerMonologueRolesPage(),
      viewModel: locator<ProducerMonologueRolesviewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerMonologueRolesPage
    extends StatelessView<ProducerMonologueRolesviewmodel> {
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
            icon: Icon(Icons.arrow_back_ios,color: black,size: 24,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.w),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(45.r)),
                border: Border.all(
                  color: borderColor, // Change border color when selected
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Spacings.spacing16.w,
                    vertical: Spacings.spacing4.h),
                child: BaseText(
                  'I want a single script',
                  fontSize: TextSizes.textSize14SP,
                  fontWeight: FontWeight.w400,
                  color: optionTextColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
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
              height: Spacings.spacing32.h,
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: viewModel.isSelected.length+1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: ProducerMonologueRolesCustomContainer(
                      text: "Village witch",
                      isSelected: viewModel.isSelected[index],
                      press: () {
                        viewModel.isSelected[index] =
                            viewModel.isSelected[index];
                      },
                    ),
                  );
                }),
            SizedBox(
              height: Spacings.spacing116.h,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 16.h, top: 20.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: MainButton(
              buttonColor: white,
              textColor: black,
              text: 'Save and continue',
              borderColor: borderColor,
              press: () {
                Navigator.pushNamed(
                    context, '/producerCreateMonologueRolesPage');
              },
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
