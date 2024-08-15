// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:nitoons/config/size_config.dart';
// import 'package:nitoons/constants/app_colors.dart';
// import 'package:nitoons/constants/images.dart';
// import 'package:nitoons/constants/sizes.dart';
// import 'package:nitoons/constants/spacings.dart';
// import 'package:nitoons/locator.dart';
// import 'package:nitoons/widgets/base_text.dart';
// import 'package:nitoons/widgets/main_button.dart';
// import 'package:pmvvm/pmvvm.dart';
//
// import '../../UI Actor/SignUp/signup_viewmodel.dart';
//
// class SignUpPage extends StatelessWidget {
//   static String routeName = "/signUpPage";
//   const SignUpPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return MVVM(
//       view: () => _SignUpPage(),
//       viewModel: locator<SignupViewModel>(),
//       disposeVM: false,
//     );
//   }
// }
//
// class _SignUpPage extends StatelessView<SignupViewModel> {
//   @override
//   Widget render(context, viewModel) {
//     SizeConfig().init(context);
//     return Scaffold(
//       body: ListView(
//         physics: BouncingScrollPhysics(),
//         children: [
//           SizedBox(height: Spacings.spacing50.h,),
//           SvgPicture.asset(Svgs.appIcon,width: Spacings.spacing120.w,height: Spacings.spacing76,color: black,),
//           SizedBox(height: Spacings.spacing4.h,),
//           BaseText('NOLLYWOOD ACTOR',
//           fontWeight: FontWeight.w400,
//           fontSize: TextSizes.textSize14SP,
//           color: black,
//           textAlign: TextAlign.center,
//           ),
//           SizedBox(height: Spacings.spacing50.h,),
//           BaseText('Sign up to continue',
//           fontWeight: FontWeight.w400,
//           fontSize: TextSizes.textSize18SP,
//           color: LightTextColor,
//           textAlign: TextAlign.center,
//           ),
//           SizedBox(height: Spacings.spacing30.h,),
//           Padding(
//             padding:  EdgeInsets.symmetric(horizontal:Spacings.spacing15.w),
//             child: MainButton(
//               text: 'Continue with email',
//               buttonColor: black,
//                textColor: white,
//                press: (){
//                  Navigator.pushNamed(context, '/emailAddressSignUp');
//                },
//                ),
//           ),
//           SizedBox(height: Spacings.spacing20.h,),
//           Padding(
//             padding:  EdgeInsets.symmetric(horizontal:Spacings.spacing15.w),
//             child: MainButton(
//               text: 'Use phone number',
//               buttonColor: white,
//                textColor: black,
//                press: (){
//                 Navigator.pushNamed(context, '/phoneNumberPage');
//                },
//                ),
//           ),
//              SizedBox(height: Spacings.spacing30.h,),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Divider(
//                       color: dividerColor,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20.w),
//                     child: BaseText(
//                       'or sign up with',
//                           color: LightTextColor,
//                           fontSize: TextSizes.textSize12SP,
//                           fontWeight: FontWeight.w400),
//                   ),
//                   Expanded(
//                     child: Divider(
//                       color: dividerColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: Spacings.spacing30.h,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: Spacings.spacing10.h,horizontal: Spacings.spacing10.w),
//                     decoration: BoxDecoration(
//                       border: Border.all(color:borderColor ),
//                       borderRadius: BorderRadius.circular(Spacings.spacing8.sp),
//                     ),
//                     child: SvgPicture.asset(
//                       Svgs.facebookIcon,
//                       width: IconSizes.mainIconSize,
//                       height: IconSizes.mainIconSize,
//                     ),
//                   ),
//                   SizedBox(width: Spacings.spacing20.w,),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: Spacings.spacing10.h,horizontal: Spacings.spacing10.w),
//                     decoration: BoxDecoration(
//                       border: Border.all(color:borderColor ),
//                       borderRadius: BorderRadius.circular(Spacings.spacing8.sp),
//                     ),
//                     child: SvgPicture.asset(
//                       Svgs.googleIcon,
//                       width: IconSizes.mainIconSize,
//                       height: IconSizes.mainIconSize,
//                     ),
//                   ),
//                   SizedBox(width: Spacings.spacing20.w,),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: Spacings.spacing10.h,horizontal: Spacings.spacing10.w),
//                     decoration: BoxDecoration(
//                       border: Border.all(color:borderColor ),
//                       borderRadius: BorderRadius.circular(Spacings.spacing8.sp),
//                     ),
//                     child: SvgPicture.asset(
//                       Svgs.apple,
//                       width: IconSizes.mainIconSize,
//                       height: IconSizes.mainIconSize,
//                     ),
//                   ),
//             ],),
//             SizedBox(height: Spacings.spacing50.h,),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   BaseText(
//                     'Already have an account?',
//                     fontSize: TextSizes.textSize18SP,
//                     fontWeight: FontWeight.w400,
//                     color: LightTextColor,
//                   ),
//                   SizedBox(width: Spacings.spacing4.w),
//                   GestureDetector(
//                     child: BaseText(
//                       ' Log in',
//                       fontSize: TextSizes.textSize18SP,
//                       color: signInColor,
//                       fontWeight: FontWeight.w400,
//                       onPressed: () {
//
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: Spacings.spacing50.h,),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   BaseText(
//                     'Terms of use',
//                     fontSize: TextSizes.textSize18SP,
//                     fontWeight: FontWeight.w400,
//                     color: LightTextColor,
//                   ),
//                   SizedBox(width: Spacings.spacing30.w),
//                   GestureDetector(
//                     child: BaseText(
//                       'Privacy Policy',
//                       fontSize: TextSizes.textSize18SP,
//                       color: LightTextColor,
//                       fontWeight: FontWeight.w400,
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/login');
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: Spacings.spacing20.h,),
//
//         ],
//       ),
//     );
//   }
// }
