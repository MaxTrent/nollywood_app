import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../widgets/main_button.dart';

class SignUpRolePage extends StatelessWidget {
  static String routeName = "/signUpRolePage";
  const SignUpRolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _SignUpRolePage(),
      viewModel: locator<SignUpRoleViewmodel>(),
      disposeVM: false,
    );
  }
}

class _SignUpRolePage extends StatelessView<SignUpRoleViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              
              controller: viewModel.pageController,
              itemCount: viewModel.pages.length,
              // onPageChanged: (int page) {
              //   viewModel.activePage = page;
              //   //viewModel.updateButtonState();
              // },
              itemBuilder: (BuildContext context, int index) {
                return viewModel.pages[index % viewModel.pages.length];
              }),
          // Positioned(
          //   top: 48.h,
          //   left: 14.w,
          //   child: IconButton(
          //     icon: Icon(Icons.arrow_back_ios),
          //     onPressed: () {},
          //   ),
          // ),
          Positioned(
            top: 44.h,
            left: 0,
            right: 0,
            height: 10.h,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    viewModel.pages.length,
                    (index) {
                       double containerWidth = 350.0 / viewModel.pages.length;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0),
                        child: InkWell(
                          onTap: () {
                            // viewModel.pageController.animateToPage(index,
                            //     duration: Duration(microseconds: 50),
                            //     curve: Curves.easeIn);
                          },
                          child: Container(
                            height: 2,
                            width: containerWidth,
                            color: index <= viewModel.activePage
                                ? Colors.black
                                : buttonNotActive,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 48,
            left: 24,
            right: 24,
            child: MainButton(
              text: 'Continue',
              loading: viewModel.loading,
              buttonColor: viewModel.isButtonActive ? black : buttonNotActive,
              textColor: viewModel.isButtonActive ? white : textNotActive,
              press: viewModel.isButtonActive
                  ? () {
                      viewModel.nextPage(context);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
