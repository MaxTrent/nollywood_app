import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:nitoons/widgets/selectable_container.dart';
import 'package:pmvvm/pmvvm.dart';

class BackgroundActorPage extends StatelessWidget {
  static String routeName = "/backgroundActorPage";
  const BackgroundActorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _BackgroundActorPage(),
      viewModel: locator<SignUpRoleViewmodel>(),
      disposeVM: false,
    );
  }
}

class _BackgroundActorPage extends StatelessView<SignUpRoleViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: Spacings.spacing30.h,
            ),
            BaseText(
              'Background actor?',
              fontSize: TextSizes.textSize32SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing8.h,
            ),
            BaseText(
              'Would you also like to get roles as a background actor?',
              fontSize: TextSizes.textSize14SP,
              fontWeight: FontWeight.w400,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing40.h,
            ),
            SelectableRow(
              item: 'Yes, I would',
              isSelected: viewModel.selectedIndexBackgroundActorIndex == 'true',
              borderColor: borderColor,
              onTap: () {
                viewModel.selectIndexBackgroundActorIndex('true');
              },
            ),
            SizedBox(
              height: Spacings.spacing14.h,
            ),
            SelectableRow(
              item: 'No, I would not',
              isSelected:
                  viewModel.selectedIndexBackgroundActorIndex == 'false',
              borderColor: borderColor,
              onTap: () {
                viewModel.selectIndexBackgroundActorIndex('false');
              },
            ),
            SizedBox(
              height: Spacings.spacing60.h,
            ),
            MainButton(
              text: 'save',
              loading: viewModel.loading,
              buttonColor: viewModel.isButtonActive ? black : buttonNotActive,
              textColor: viewModel.isButtonActive ? white : textNotActive,
              press: () {
                viewModel.submitData(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
