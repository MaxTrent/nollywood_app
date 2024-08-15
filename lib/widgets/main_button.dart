import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/sizes.dart';

import '../constants/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.text,
    this.press,
    required this.buttonColor,
    required this.textColor,
      this.borderColor,
    this.loading = false,
  });

  final String? text;
  final VoidCallback? press;
  final Color buttonColor;
  final Color textColor;
  final Color? borderColor;
  final bool? loading;

  @override
  Widget build(BuildContext context)  {
     if (loading!){
     return Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(black),
        ),
      );
    } else{
      return GestureDetector(
         onTap: press,
         child: Container(
           height: 56.h,
           decoration: BoxDecoration(
             color: buttonColor,
             border: borderColor != null
                 ? Border.all(
               color: borderColor!, // Use non-null assertion to access Color value
               width: 1.0,
             )
                 : null,
             borderRadius: BorderRadius.circular(8),
           ),
           child: Center(
             child: Text(
               text!,
               textAlign: TextAlign.center,
               maxLines: 1,
               style: TextStyle(
                 color: textColor,
                 fontFamily: "Satoshi",
                 fontWeight: FontWeight.w400,
                 fontSize: TextSizes.textSize16SP,
               ),
             ),
           ),
         ),
       );
     }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nitoons/constants/app_colors.dart';
// import 'package:nitoons/constants/sizes.dart';

// class MainButton extends StatelessWidget {
//   const MainButton({
//     Key? key,
//     this.text,
//     this.press,
//     required this.buttonColor,
//     required this.textColor,
//   }) : super(key: key);

//   final String? text;
//   final VoidCallback? press;
//   final Color buttonColor;
//   final Color textColor;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: press,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(color: Colors.black, width: 1.0), // Set border color and width
//         ),
//         minimumSize: Size(double.infinity, 56.h), // Set button height
//       ),
//       child: Text(
//         text!,
//         textAlign: TextAlign.center,
//         maxLines: 1,
//         style: TextStyle(
//           fontFamily: "Satoshi",
//           fontWeight: FontWeight.w400,
//           fontSize: TextSizes.textSize16SP,
//         ),
//       ),
//     );
//   }
// }
