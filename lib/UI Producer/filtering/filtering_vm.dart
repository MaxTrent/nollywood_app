import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilteringViewModel{
  final WidgetRef ref;
  FilteringViewModel(this.ref);


  static final distanceSliderProgressProvider = StateProvider<double>((ref) => 0);

  static final genderSelection = StateProvider.autoDispose((ref) => 0);

  static final countryProvider = StateProvider.autoDispose((ref) => 'Nigeria');

  static final endorsementProvider = StateProvider.autoDispose((ref) => 'Most Endorsed');

  static final heightSliderProvider = StateProvider.autoDispose((ref) => RangeValues(5, 5));

  static final playableAgeSliderProvider = StateProvider.autoDispose((ref) => RangeValues(0, 0));

  static final actorlookalikeControllerProvider = Provider.autoDispose((ref) => TextEditingController());



  TextEditingController get actorLookAlikeValue =>
      ref.watch(actorlookalikeControllerProvider);

  String get countryValue => ref.watch(countryProvider);

  String get endorsementValue => ref.watch(endorsementProvider);

  double get distanceSliderValue => ref.watch(distanceSliderProgressProvider);

  RangeValues get heightSliderValues => ref.watch(heightSliderProvider);

  RangeValues get playableAgeSliderValues =>
      ref.watch(playableAgeSliderProvider);

  String get heightValues =>
      '${formatHeight(ref.watch(heightSliderProvider).start)} - ${formatHeight(ref.watch(heightSliderProvider).end)}';

  String get playableAgeValues =>
      '${ref.watch(playableAgeSliderProvider).start.toInt()}-${ref.watch(playableAgeSliderProvider).end.toInt()}';

  String get distanceValueKm =>
      '${ref.watch(distanceSliderProgressProvider).toInt()}km';

  bool isGenderSelected(int index) => ref.watch(genderSelection) == index;

  String formatHeight(double value) {
    int feet = value.floor();
    int inches = ((value - feet) * 12).round();
    return "$feet' $inches";
  }

  void toggleHeightValue(RangeValues value) {
    ref.read(heightSliderProvider.notifier).state = value;
  }

  void selectGender(int index) {
    ref.read(genderSelection.notifier).state = index;
  }

  void selectCountry(String? value) {
    ref.read(countryProvider.notifier).state = value!;
  }

  void selectEndorsement(String? value) {
    ref.read(endorsementProvider.notifier).state = value!;
  }

  void togglePlayableAge(RangeValues value) {
    ref.read(playableAgeSliderProvider.notifier).state = value;
  }

  void toggleDistance(double value) {
    ref.read(distanceSliderProgressProvider.notifier).state = value;
  }
}