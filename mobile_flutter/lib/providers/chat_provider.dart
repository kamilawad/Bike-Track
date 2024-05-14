import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/providers/auth_provider.dart';
import 'package:mobile_flutter/services/chat_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  final AuthProvider _authProvider;

  List<Chat> _chats = [];
  Chat? _currentChat;
  List<Message> _messages = [];
  late IO.Socket _socket;

  ChatProvider(this._authProvider) {
    _connectToServer();
  }

  List<Chat> get chats => _chats;
  Chat? get currentChat => _currentChat;
  List<Message> get messages => _messages;

  void _connectToServer() {
    _socket = IO.io(
      'http://192.168.0.105:3000/chat',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'userId': _authProvider.user!.id})
          .build(),
    );

    _socket.onConnect((data) {
      print('Connected');
    });

    _socket.on('newMessage', (data) {
      _messages.add(Message.fromJson(data));
      notifyListeners();
    });

    _socket.connect();
  }

  Future<void> fetchChats() async {
    try {
      final chats = await _chatService.fetchChats(_authProvider);
      _chats = chats;
      notifyListeners();
    } catch (e) {
      print('Failed to fetch chats: $e');
    }
  }
}