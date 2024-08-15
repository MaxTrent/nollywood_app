import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

class ChooseRoleViewModel extends ViewModel {
  // Use ValueNotifier for state management
  final ValueNotifier<int> _roleTileSelection = ValueNotifier<int>(-1);

  // Getter to access the current state
  int get selectedRoleIndex => _roleTileSelection.value;

  // Method to select a role and update state
  void selectRole(int index) {
    _roleTileSelection.value = index;
  }

  // Method to check if the role is selected
  bool isSelected(int index) => selectedRoleIndex == index;

  @override
  void dispose() {
    _roleTileSelection.dispose(); // Make sure to dispose of ValueNotifier
    super.dispose();
  }
}
