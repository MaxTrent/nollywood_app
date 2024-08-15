import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pmvvm/pmvvm.dart';





class OnboardingViewModel extends ViewModel{
  static final userMode = StateProvider.autoDispose((ref) => '');

  void selectProducerUserMode(WidgetRef ref){
  ref.read(userMode.notifier).state = 'producer';
}

  void selectActorUserMode(WidgetRef ref){
    ref.read(userMode.notifier).state = 'actor';
  }


}