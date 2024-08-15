import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/selectable_container.dart';
import 'package:pmvvm/pmvvm.dart';

class GenderPage extends StatelessWidget {
  static String routeName = "/genderPage";
  const GenderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _GenderPage(),
      viewModel: locator<SignUpRoleViewmodel>(),
      disposeVM: false,
    );
  }
}

class _GenderPage extends StatelessView<SignUpRoleViewmodel> {
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
              'State your gender?',
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing54.h,
            ),
            SelectableRow(
              item: 'I am male',
              isSelected: viewModel.selectedGenderActorIndex == 'male',
              borderColor: borderColor,
              onTap: () {
                viewModel.selectGenderActorIndex('male');
                viewModel.validatePageThree();
              },
            ),
            SizedBox(
              height: Spacings.spacing14.h,
            ),
            SelectableRow(
              item: 'I am female',
              isSelected: viewModel.selectedGenderActorIndex == 'female',
              borderColor: borderColor,
              onTap: () {
                viewModel.selectGenderActorIndex('female');
                viewModel.validatePageThree();
              },
            ),
          ],
        ),
      ),
    );
  }
}
