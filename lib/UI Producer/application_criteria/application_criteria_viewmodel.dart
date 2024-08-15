import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicationCriteriaViewModel {
  static final selectedRolesProvider =
      StateProvider.family<bool, int>((ref, index) => false);

  final WidgetRef ref;

  ApplicationCriteriaViewModel(this.ref);

  void toggleSelection(int index) {
    ref.read(selectedRolesProvider(index).notifier).state =
        !ref.read(selectedRolesProvider(index).notifier).state;
  }

  bool isSelected(int index) => ref.watch(selectedRolesProvider(index));

  bool isAnyTileSelected(int count) {
    final List<bool> selectedStates = List.generate(
        count, (index) => ref.watch(selectedRolesProvider(index).notifier).state);
    return selectedStates.any((selected) => selected);
  }
}
