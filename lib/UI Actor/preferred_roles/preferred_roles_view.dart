import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Actor/preferred_roles/preferred_roles_viewmodel.dart';
import 'package:nitoons/components/back_button.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../components/app_button.dart';
import '../../components/app_loading_indicator.dart';
import '../../components/app_textfield.dart';
import '../../constants/app_colors.dart';
import '../../locator.dart';

class PreferredRoles extends StatelessWidget {
  static String routeName = "/preferredRoles";

  PreferredRoles({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<PreferredRolesViewModel>.builder(
      viewModel: locator<PreferredRolesViewModel>(),
      disposeVM: false,
      viewBuilder: (_, viewModel) {
        return Scaffold(
          appBar: AppBar(
            leading: AppBackButton(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preferred roles',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Select a few of your preferred roles and let producers know what you’re interested about.',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 27.h,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55, // Adjust height as needed
                    child: GridView.builder(
                      itemCount: viewModel.roleNames.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        mainAxisSpacing: 5.h,
                        crossAxisSpacing: 5.w,
                        
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => viewModel.toggleTileSelection(index),
                          child: ListSelectContainer(
                            text: viewModel.roleNames[index],
                            position: index,
                            viewModel: viewModel,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppTextField(
                    controller: viewModel.otherController,
                    hintText: 'e.g Pastor, Farmer',
                    labelText: 'Other',
                  ),
                  SizedBox(
                    height: 120.h,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
            child: viewModel.loading? AppLoadingIndicator(): AppButton(
              onPressed: viewModel.isAnyTileSelected()
                  ? () => viewModel.updatePreferredRoleProfile()
                  : null,
              text: 'Save',
              width: double.infinity,
              backgroundColor: viewModel.isAnyTileSelected()
                  ? Colors.black
                  : Color(0xffEBECEF),
              textColor: viewModel.isAnyTileSelected()
                  ? Colors.white
                  : Color(0xff828491),
            ),
          ),
          floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}

class ListSelectContainer extends StatelessWidget {
  final String text;
  final int position;
  final PreferredRolesViewModel viewModel;

  ListSelectContainer({
    required this.text,
    required this.position,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: viewModel.isTileSelected(position)
            ? selectColor.withOpacity(0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(98.r),
        border: Border.all(
          color: viewModel.isTileSelected(position)
              ? selectColor
              : Color(0xff7C7C7C),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: viewModel.isTileSelected(position)
                    ? selectColor
                    : Colors.black,
                fontWeight: viewModel.isTileSelected(position)
                    ? FontWeight.w700
                    : FontWeight.w400,
              ),
        ),
      ),
    );
  }
}
