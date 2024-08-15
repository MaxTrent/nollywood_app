import 'package:flutter_riverpod/flutter_riverpod.dart';


class CreateMonologuesViewModel{
  final WidgetRef ref;
  CreateMonologuesViewModel(this.ref);

  static final selectedMonologuesProvider = StateProvider.family<bool, int>((
      ref, index) => false);

  bool isSelected(int index) => ref.watch(selectedMonologuesProvider(index));

  void selectMonologueTile(int index){
    ref
        .read(
        selectedMonologuesProvider(index).notifier)
        .state = !ref
        .read(
        selectedMonologuesProvider(index).notifier)
        .state;
  }

  bool isAnyTileSelected(int count) {
    final List<bool> selectedStates = List.generate(
        count, (index) => ref.watch(selectedMonologuesProvider(index).notifier).state);
    return selectedStates.any((selected) => selected);
  }



}