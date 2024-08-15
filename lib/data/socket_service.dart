import 'dart:async';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/models/conversation_message_model.dart';
import 'package:nitoons/models/conversations_model.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class StreamSocket {
  final _socketResponse = StreamController<ConversationMessageModel>();
  final _socketMessagePage = StreamController<ConversationsModel>();

  void Function(ConversationMessageModel) get addResponse =>
      _socketResponse.sink.add;

  void Function(ConversationsModel) get addMessagePageData =>
      _socketMessagePage.sink.add;

  Stream<ConversationMessageModel> get getResponse => _socketResponse.stream;
  Stream<ConversationsModel> get getMessagePageData =>
      _socketMessagePage.stream;

  void dispose() {
    _socketResponse.close();
    _socketMessagePage.close();
  }
}

class SocketService {
  late IO.Socket socket;
  final analytics = FirebaseAnalytics.instance;
  final streamSocket = StreamSocket();

  Future<void> initializeSocket() async {
    final accessToken = await SecureStorageHelper.getAccessToken();

    socket = IO.io(
        ApiUrls.serverUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({"token": accessToken})
            .enableAutoConnect()
            .build());

    // socket.connect();

    socket.onConnect((_) {
      print('Connected to socket server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket server');
    });

    socket.onConnectError((err) {
      print('Connection Error: $err');
    });

    socket.onError((err) {
      print('Error occured: $err');
    });

    // socket.on('conversations_update', (data) {
    //   _conversationsController.add(List<Map<String, dynamic>>.from(data));
    // });
  }

  // void sendMessage(String conversationId, String message) {
  //   socket.emit('new_message', {
  //     'conversationId': conversationId,
  //     'message': message,
  //   });
  // }

  // void joinConversation(String conversationId) {
  //   socket.emit('join_conversation', conversationId);
  // }

  void logAnalyticsEvent(String eventName, [Map<String, dynamic>? parameters]) {
    analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  void onMessageReceived(Function(ConversationMessageModel) callback) {
    socket.on('new_message', (data) {
      final message = ConversationMessageModel.fromJson(data);

      final messageConvo = ConversationsModel.fromJson(data);
      streamSocket.addResponse(message);
      streamSocket.addMessagePageData(messageConvo);
      // callback(message);
      print('Data is: $data');
      logAnalyticsEvent('new_message', {
        'conversation_id': message.data.results[0].conversationId,
        'message_id': message.data.results[0].id,
        'sent_by': message.data.results[0].sentBy,
      });
      print(message);
    });
  }

  void dispose() {
    socket.dispose();
  }

  void disconnect() {
    socket.disconnect();
  }
}

final socketServiceProvider = Provider<SocketService>((ref) {
  final socketService = SocketService();
  socketService.initializeSocket();
  return socketService;
});

 final messageStreamProvider = StreamProvider.autoDispose((ref) {
    final socketService = ref.watch(socketServiceProvider);
    return socketService.streamSocket.getMessagePageData;
  });
  

final socketServiceInitializerProvider = FutureProvider((ref) async {
  final socketService = ref.read(socketServiceProvider);
  await socketService.initializeSocket();
});
