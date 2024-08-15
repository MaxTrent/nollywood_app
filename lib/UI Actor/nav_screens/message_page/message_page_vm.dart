import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nitoons/UI%20Actor/message_chat/message_chat_vm.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/models/conversations_model.dart';

class MessagePageViewModel {
  final WidgetRef ref;
  MessagePageViewModel(this.ref);

  static final searchControllerProvider =
      Provider.autoDispose((ref) => TextEditingController());
  final tabController = useTabController(initialLength: 2);

  static final isMessageProvider = StateProvider((ref) => true);
  final firebaseMessaging = FirebaseMessaging.instance;

  static final getConversationsProvider = FutureProvider.autoDispose((ref) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getConversations();
  });

  TextEditingController get searchController =>
      ref.watch(searchControllerProvider);
  bool get isMessage => ref.watch(isMessageProvider);

  Future<void> fetchConversations() async {
    final apiService = ref.watch(apiServiceProvider);
    await apiService.getConversations();
    final fcmToken = firebaseMessaging.getToken().then((token) {
      print('fcm token: $token');
    });

    // try {
    //   apiService.getConversations().then((conversations) {
    //     ref.read(conversationsProvider).add(conversations);
    //   });
    // } catch (e) {
    //   ref.read(conversationsProvider).addError(e);
    // }
  }
}
