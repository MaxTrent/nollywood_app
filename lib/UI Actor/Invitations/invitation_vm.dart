import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/data/api_services.dart';

class InvitationPageViewModel {
  final WidgetRef ref;
  InvitationPageViewModel(this.ref);

  static final getAllInvitationsProvider = FutureProvider((ref) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getAllInvitations();
  });
}
