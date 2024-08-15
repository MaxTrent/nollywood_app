import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProducerSearchViewModel {
  final WidgetRef ref;

  ProducerSearchViewModel(this.ref);

  static final isFollowingProvider = StateProvider.autoDispose((ref) => false);

  bool get isFollowing => ref.watch(isFollowingProvider);

  bool clickFollowButton() => ref.read(isFollowingProvider.notifier).state =
      !ref.read(isFollowingProvider.notifier).state;
}
