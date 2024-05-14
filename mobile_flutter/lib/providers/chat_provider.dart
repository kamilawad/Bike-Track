import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/providers/auth_provider.dart';
import 'package:mobile_flutter/services/chat_service.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();

  List<Chat> _chats = [];
  Chat? _currentChat;
  List<Message> _messages = [];
  late io.Socket _socket;

  List<Chat> get chats => _chats;
  Chat? get currentChat => _currentChat;
  List<Message> get messages => _messages;

  void _connectToServer(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.user!.id;

    _socket = io.io(
      'http://192.168.0.105:3000/chat',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'userId': userId})
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

  Future<void> fetchChats(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final chats = await _chatService.fetchChats(authProvider.token!);
      _chats = chats;
      notifyListeners();
    } catch (e) {
      print('Failed to fetch chats: $e');
    }
  }

  Future<void> fetchMessages(String chatId, BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final messages = await _chatService.fetchMessages(chatId, authProvider.token!);
      _messages = messages;
      _currentChat = _chats.firstWhere((chat) => chat.id == chatId);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch messages: $e');
    }
  }

  Future<void> sendMessage(String chatId, String content, BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final message = await _chatService.sendMessage(chatId, content, authProvider.token!);
      _messages.add(message);
      _socket.emit('sendMessage', {'chatId': chatId, 'content': content});
      notifyListeners();
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  @override
  void dispose() {
    _socket.disconnect();
    super.dispose();
  }
}