import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/providers/auth_provider.dart';
import 'package:mobile_flutter/services/chat_service.dart';
import 'package:mobile_flutter/services/chat_socket.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  final WebSocketService _webSocketService = WebSocketService();
  List<Chat> _chats = [];
  Chat? _currentChat;
  List<Message> _messages = [];
  List<Map<String, dynamic>> _userChatsWithLastMessage = [];

  List<Map<String, dynamic>> get userChatsWithLastMessage => _userChatsWithLastMessage;
  List<Chat> get chats => _chats;
  Chat? get currentChat => _currentChat;
  List<Message> get messages => _messages;

  void connectToWebSocket(BuildContext context) {
    _webSocketService.connect(context);
    _webSocketService.registerNewMessageListener(_handleNewMessage);
  }

  void _handleNewMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  Future<void> fetchChats(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      print('authhhhh nnn:${authProvider.token}');
      final chats = await _chatService.fetchChats(authProvider.token!);
      print(chats);
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
      _webSocketService.sendMessage(chatId, content);
      notifyListeners();
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }
}