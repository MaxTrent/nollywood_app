import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:nitoons/data/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/main.dart';
import 'package:nitoons/models/conversation_message_model.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:nitoons/utilities/base_notifier.dart';
import 'package:nitoons/utilities/base_state.dart';

class MessagesChatViewModel {
  final WidgetRef ref;
  MessagesChatViewModel(this.ref);

  static final scrollControllerProvider =
      Provider.autoDispose((ref) => ScrollController());

  // static final messageControllerProvider = Provider((ref) {
  //   return TextEditingController();
  // });

  static final messageControllerProvider = StateProvider.autoDispose((ref) {
    final controller = TextEditingController();
    controller.addListener(() {
      ref.notifyListeners();
    });
    return controller;
  });

  static final messageTextProvider = Provider.autoDispose((ref) {
    final controller = ref.watch(messageControllerProvider);
    return controller.text;
  });

  static final sendMessageNotifierProvider =
      StateNotifierProvider<MessagesChatNotifier, MessagesChatState>((ref) {
    final apiService = ref.read(apiServiceProvider);
    final navigatorKey = ref.read(navigatorKeyProvider);
    return MessagesChatNotifier(
      apiService,
      () {
        navigatorKey.currentState?.pop();
      },
    );
  });

  static final getUserConversationMessagesProvider = FutureProvider.family
      .autoDispose<ConversationMessageModel, String>((ref, id) async {
    // final conversationIds = await SecureStorageHelper.getConversationIds();
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getConversationMessages(id);
  });

  ScrollController get scrollController => ref.watch(scrollControllerProvider);
  TextEditingController get messageController =>
      ref.watch(messageControllerProvider);

  String get messageText => ref.watch(messageTextProvider);

  // Future<void> onMessageSent() async {
  //   scrollController.animateTo(0.0,
  //       duration: const Duration(microseconds: 300), curve: Curves.easeInOut);

  //   messageController.text = '';
  // }

  // Stream<ConversationMessageModel> fetchConversationMessages(
  //     String conversationId) async* {
  //   final apiService = ref.watch(apiServiceProvider);
  //   while (true) {
  //     yield await apiService.getConversationMessages(conversationId);
  //     // await Future.delayed(Duration(seconds: 5));
  //   }
  // }

  // void fetchMessages(String conversationId) {
  //   final apiService = ref.watch(apiServiceProvider);
  //   try {
  //     apiService.getConversationMessages(conversationId).then((messages) {
  //       ref.read(messagesProvider).add(messages);
  //     });
  //   } catch (e) {
  //     ref.read(messagesProvider).addError(e);
  //   }
  // }

  // void sendMessage(String conversationId) {
  //   if (messageText.isNotEmpty) {
  //     ref
  //         .read(messagesProvider.notifier)
  //         .sendMessage(conversationId, messageText);
  //     messageController.clear();
  //   }
  // }

  // void dispose() {
  //    ref.read(messagesControllerProvider).close();
  // }

  // void listenForRealTimeUpdates(String conversationId) {
  //   WebSocket.connect(
  //           'ws://nitoons-actors-app-a18cc438c3bf.herokuapp.com/v1/api/messaging/conversations/$conversationId/messages')
  //       .then((WebSocket ws) {
  //     ws.listen((data) {
  //       final newMessage = ConversationMessageModel.fromJson(json.decode(data));
  //       ref.read(messagesProvider).add(newMessage);
  //     });
  //   });
  // }

  Future<void> sendMessage(String convoId) async {
    if (messageText.isNotEmpty) {
      await ref
          .read(sendMessageNotifierProvider.notifier)
          .sendMessage(messageText, convoId);
      messageController.clear();
      // scrollController.animateTo(
      //   scrollController.position.minScrollExtent,
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );

      scrollController.animateTo(0.0,
          duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
    }
  }
}

class MessagesNotifier extends StateNotifier<List<ConversationMessageModel>> {
  final SocketService socketService;

  MessagesNotifier(this.socketService) : super([]) {
    socketService.onMessageReceived((message) {
      state = [...state, message];
    });
  }

  // void sendMessage(String conversationId, String message) {
  //   socketService.sendMessage(conversationId, message);
  // }

  @override
  void dispose() {
    socketService.dispose();
    super.dispose();
  }
}

final messagesNotifierProvider =
    StateNotifierProvider<MessagesNotifier, List<ConversationMessageModel>>(
        (ref) {
  final socketService = ref.watch(socketServiceProvider);
  return MessagesNotifier(socketService);
});

class MessagesChatState extends BaseState {
  final List<Data> messages;

  MessagesChatState({
    required bool isLoading,
    required this.messages,
    String? error,
  }) : super(isLoading: isLoading, error: error);

  MessagesChatState copyWith({
    bool? isLoading,
    List<Data>? messages,
    String? error,
  }) {
    return MessagesChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      error: error,
    );
  }
}

// class MessagesChatState extends BaseState {
//   final MessageModel? data;

//   MessagesChatState({required bool isLoading, this.data, String? error})
//       : super(isLoading: isLoading, error: error);
// }

// class MessagesChatNotifier extends BaseNotifier<MessagesChatState> {
//   MessagesChatNotifier(ApiServices apiServices, VoidCallback onSuccess)
//       : super(apiServices, onSuccess, MessagesChatState(isLoading: false));

//   Future<void> sendMessage(String message, String conversationId) async {
//     await execute(
//       () => apiService.sendMessage(message, conversationId),
//       loadingState: MessagesChatState(isLoading: true),
//       dataState: (data) => MessagesChatState(isLoading: false, data: data),
//     );
//   }

//   @override
//   MessagesChatState errorState(dynamic error) {
//     return MessagesChatState(isLoading: false, error: error.toString());
//   }
// }

class MessagesChatNotifier extends BaseNotifier<MessagesChatState> {
  MessagesChatNotifier(ApiServices apiServices, VoidCallback onSuccess)
      : super(apiServices, onSuccess,
            MessagesChatState(isLoading: false, messages: []));

  Future<void> sendMessage(String message, String userId) async {
    await execute(
      () async {
        final response = await apiService.sendMessage(message, userId);
        if (response['success'] == true && response.containsKey('data')) {
          final newMessage = Data.fromJson(response['data']);
          final updatedMessages = [...state.messages, newMessage];
          return updatedMessages;
        } else {
          throw Exception('Failed to send message');
        }
      },
      loadingState:
          MessagesChatState(isLoading: true, messages: state.messages),
      dataState: (data) => MessagesChatState(isLoading: false, messages: data),
    );
  }

  @override
  MessagesChatState errorState(dynamic error) {
    return MessagesChatState(
        isLoading: false, messages: state.messages, error: error.toString());
  }
}
