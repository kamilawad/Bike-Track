import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/providers/auth_provider.dart';
import 'package:mobile_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class GroupChatSocketService {
  late io.Socket _socket;
  GroupChatSocketService._internal();
  static GroupChatSocketService? _instance;

  factory GroupChatSocketService(BuildContext context) {
    if (_instance == null) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.user!.id;
      _instance = GroupChatSocketService._internal();
      _instance!._socket = io.io(
        Constants.groupChatSocketUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .setAuth({'userId': userId})
            .build(),
      );
    }
    return _instance!;
  }

  void connect(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.user!.id;
    _socket.io.options?['auth'] = {'userId': userId};
    _socket.onConnect((data) {
      print('Connected to group chat socket');
    });
    _socket.connect();
    print('Attempting WebSocket connection for group chats...');
  }

  void disconnect() {
    _socket.disconnect();
  }

  void registerNewGroupMessageListener(Function(Message) onNewGroupMessage) {
    _socket.on('newGroupMessage', (data) {
      final message = Message.fromJson(data);
      onNewGroupMessage(message);
    });
  }

  void sendGroupMessage(String groupChatId, String content) {
    _socket.emit('sendGroupMessage', {'groupChatId': groupChatId, 'content': content});
  }
}