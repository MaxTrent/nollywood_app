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

class RolePage extends StatelessWidget {
  static String routeName = "/rolePage";
  const RolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _RolePage(),
      viewModel: locator<SignUpRoleViewmodel>(),
      disposeVM: false,
    );
  }
}

class _RolePage extends StatelessView<SignUpRoleViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Spacings.spacing60.h,
            ),
            BaseText(
              'What are you?',
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing54.h,
            ),
            SelectableRow(
              item: 'I’m an Actor',
              isSelected: viewModel.selectedIndex == 'Actor',
              borderColor: borderColor,
              onTap: () async {
                viewModel.selectIndex('Actor');
                await viewModel.validatePageZero();
              },
            ),
            SizedBox(
              height: Spacings.spacing14.h,
            ),
            SelectableRow(
              item: 'A Casting Director/Producer',
              isSelected: viewModel.selectedIndex == 'Producer',
              borderColor: borderColor,
              onTap: () async {
                viewModel.selectIndex('Producer');
                await viewModel.validatePageZero();
              },
            ),
          ],
        ),
      ),
    );
  }
}
