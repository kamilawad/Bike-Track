import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/providers/auth_provider.dart';
import 'package:mobile_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class WebSocketService {
  late io.Socket _socket;

  WebSocketService._internal();

  static WebSocketService? _instance;

  factory WebSocketService(BuildContext context) {
    if (_instance == null) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.user!.id;
      _instance = WebSocketService._internal();
      _instance!._socket = io.io(
        Constants.chatSocketUrl,
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
      print('Connected');
    });

    _socket.connect();
    print('Attempting WebSocket connection...');
  }

  void disconnect() {
    _socket.disconnect();
  }

  void registerNewMessageListener(Function(Message) onNewMessage) {
    _socket.on('newMessage', (data) {
      final message = Message.fromJson(data);
      onNewMessage(message);
    });
  }

  void sendMessage(String chatId, String content) {
    _socket.emit('sendMessage', {'chatId': chatId, 'content': content});
  }
}



/*import 'package:socket_io_client/socket_io_client.dart' as IO;

class chatSocket {
  late IO.Socket socket;

  initSocket() {
    socket = IO.io('http://192.168.0.105:3000', <String, dynamic> {
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    //socket.onConnect((data) => print('Connected'));
    //socket.onDisconnect((data) => print('Disconnected'));
    //socket.onConnectError((data) => print('Connect Error: $data'));
    //socket.onError((data) => print('Error: $data'));
  }
}*/