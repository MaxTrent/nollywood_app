// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // class RoleViewModel extends ViewModel {
// //   // bool _isButtonActive = false;
// //   // bool get isButtonActive => _isButtonActive;
// //   //
// //   // // Update the method to take a parameter indicating the selection state
// //   // void setLoadingState(bool isSelected) {
// //   //   _isButtonActive = isSelected;
// //   //   notifyListeners();
// //   // }
// //   //
// //   // @override
// //   // void init() {
// //   //   super.init();
// //   // }
// //   //
// //   // @override
// //   // void dispose() {
// //   //   super.dispose();
// //   //   notifyListeners();
// //   // }
// //   int _selectedIndex = -1; // Initially no selection

// //   int get selectedIndex => _selectedIndex;

// //   void selectIndex(int index) {
// //     _selectedIndex = index;
// //     notifyListeners(); // Notify listeners about the change
// //   }
// // }

// class RoleViewModel {
//   final WidgetRef ref;
//   RoleViewModel(this.ref);

//   static final selectedIndexProvider = StateProvider((ref) => 0);
//   static final selectRoleProvider = StateProvider((ref) => "");

//   int get selectedIndex => ref.watch(selectedIndexProvider);
//   String get selectedRole => ref.watch(selectRoleProvider);

//   void selectRole(index) {
//     ref.read(selectedIndexProvider.notifier).state = index;
//     ref.read(selectRoleProvider.notifier).state =
//         index == 1 ? "Actor" : "Producer";
//     print(selectedRole);
//   }
// }
