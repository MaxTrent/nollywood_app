import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/main_button.dart';

import '../../constants/app_colors.dart';
import '../../constants/sizes.dart';
import '../../widgets/base_text.dart';
import 'sign_up.dart';
import 'signup_modal_sheet.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BaseText(
          'Login',
          color: black,
          fontSize: TextSizes.textSize16SP,
          fontWeight: FontWeight.w600,
        ),
        elevation:1 ,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.perm_identity_outlined,color: textNotActive,size: IconSizes.largestIconSize,),
          BaseText('Login to access this resource',fontWeight: FontWeight.w600,fontSize: TextSizes.textSize16SP,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing40.w),
            child: MainButton(
              text: 'Login',
              buttonColor: black,
              textColor: white,
              press: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                  (route) => false,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
