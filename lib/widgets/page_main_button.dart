// import 'package:flutter/material.dart';
// import 'package:nitoons/UI Actor/role/signup_role_viewmodel.dart';
//
// class MainButton extends StatelessWidget {
//   final SignUpRoleViewmodel viewModel;
//
//   MainButton({required this.viewModel});
//
//   @override
//   Widget build(BuildContext context) {
//     // Determine the active page index
//     int activePageIndex = viewModel.pageController.page?.toInt() ?? 0;
//
//     // Get the button activity state for the active page
//     bool isButtonActive = viewModel.isButtonActiveList[activePageIndex];
//
//     return ElevatedButton(
//       onPressed: isButtonActive
//           ? () {
//         // Handle button press
//         viewModel.updateButtonState(activePageIndex, false);
//         viewModel.nextPage();
//       }
//           : null, // Button is inactive if isButtonActive is false
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(
//           isButtonActive ? Colors.black : Colors.grey, // Set button color based on activity state
//         ),
//         foregroundColor: MaterialStateProperty.all<Color>(
//           isButtonActive ? Colors.white : Colors.grey, // Set text color based on activity state
//         ),
//       ),
//       child: Text('Continue'),
//     );
//   }
// }
