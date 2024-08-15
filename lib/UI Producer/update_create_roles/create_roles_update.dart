import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/custom_Text_Form_Field.dart';
import 'create_roles_update_viewmodel.dart';

class CreateRolesUpdate extends StatelessWidget {
  static String routeName = "/createRolesUpdate";
  const CreateRolesUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<CreateRolesUpdateViewmodel>.builder(
      viewModel: locator<CreateRolesUpdateViewmodel>(),
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
                      children: viewModel.textFields.map((textField) => textField).toList(),
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
                        viewModel.createRolesUpdateByProducer();
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
