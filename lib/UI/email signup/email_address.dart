// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nitoons/UI/email%20signup/emil_address_signup_viewmodel.dart';
// import 'package:nitoons/config/size_config.dart';
// import 'package:nitoons/constants/app_colors.dart';
// import 'package:nitoons/constants/sizes.dart';
// import 'package:nitoons/constants/spacings.dart';
// import 'package:nitoons/locator.dart';
// import 'package:nitoons/widgets/base_text.dart';
// import 'package:nitoons/widgets/main_button.dart';
// import 'package:pmvvm/pmvvm.dart';
//
// class EmailAddressSignUp extends StatelessWidget {
//   static String routeName = "/emailAddressSignUp";
//   const EmailAddressSignUp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return MVVM(
//       view: () => _EmailAddressSignUp(),
//       viewModel: locator<EmailAddressSignUpViewmodel>(),
//       disposeVM: false,
//     );
//   }
// }
//
// class _EmailAddressSignUp extends StatelessView<EmailAddressSignUpViewmodel> {
//   @override
//   Widget render(context, viewModel) {
//     SizeConfig().init(context);
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: Spacings.spacing15.w),
//         child: ListView(
//           physics: BouncingScrollPhysics(),
//           children: [
//             SizedBox(
//               height: Spacings.spacing20.h,
//             ),
//             BaseText(
//               "Email address",
//               fontSize: TextSizes.textSize32SP,
//               fontWeight: FontWeight.w700,
//               color: black,
//             ),
//             SizedBox(
//               height: Spacings.spacing10.h,
//             ),
//             BaseText(
//               'Please enter your valid email address. We will send you a 6-digit code to verify your account.',
//               fontSize: TextSizes.textSize16SP,
//               fontWeight: FontWeight.w400,
//               color: LightTextColor,
//             ),
//             SizedBox(
//               height: Spacings.spacing50.h,
//             ),
//             Form(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     validator: (value) {
//                       if (value!.trim().isEmpty) {
//                         return "Email address cannot be empty";
//                       } else if (value.trim().length < 2) {
//                         return "Email address is too short";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: "Email address",
//                       labelStyle: TextStyle(
//                         color: LightTextColor,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Satoshi",
//                         fontSize: TextSizes.textSize14SP,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: LightTextColor),
//                           borderRadius: BorderRadius.circular(8)),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: black),
//                       ),
//                       hintText: 'e.g johndoe@gmail.com',
//                       hintStyle: TextStyle(
//                         color: LightTextColor,
//                         fontWeight: FontWeight.w600,
//                         fontSize: TextSizes.textSize14SP,
//                       ),
//                       border: OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                     ),
//                   ),
//                   SizedBox(
//                     height: Spacings.spacing40.h,
//                   ),
//                   MainButton(
//                     text: 'Continue',
//                     buttonColor: black,
//                     textColor: white,
//                     press: () {
//                       Navigator.pushNamed(context, '/pinVericationPage');
//                     },
//                   ),
//                   SizedBox(
//                     height: Spacings.spacing40.h,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: Spacings.spacing20.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
