import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Producer/create_roles/create_roles_vm.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../../components/app_button.dart';
import '../../../components/app_textfield.dart';
import '../../../gen/assets.gen.dart';
import '../producer monologue/producer_create_monologue_view.dart';

class CreateRoles extends StatelessWidget {
  static String routeName = "/createRoles";
  const CreateRoles({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<CreateRolesViewModel>.builder(
      viewModel: locator<CreateRolesViewModel>(),
      disposeVM: false,
      viewBuilder: (_, viewModel) {
        final scrollController = ScrollController();
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: SvgPicture.asset(
                  Assets.svgs.back,
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  height: 24.h,
                  width: 24.w,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create roles',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Create all the roles in this project that you will be casting for.',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 38.h),
                    Column(
                  children: viewModel.textFields.map((textField) => textField)
                      .toList(),
                ),
                    SizedBox(height: 24.h),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.addTextField();
                        },
                        child: Text(
                          'Add more',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(height: Spacings.spacing306),
                  ],
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
              child: MainButton(
                loading: viewModel.loading,
                press: viewModel.areAllTextFieldsFilled()
                    ? () {
                        viewModel.createRolesByProducer();
                      }
                    : null,
                text: 'Save and continue',
                buttonColor: viewModel.areAllTextFieldsFilled()
                    ? Colors.black
                    : Color(0xffEBECEF),
                textColor: viewModel.areAllTextFieldsFilled()
                    ? Colors.white
                    : Color(0xff828491),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    );
  }
}
