import 'package:flutter/material.dart';
//import 'package:mobile_flutter/models/chat_model.dart';
//import 'package:mobile_flutter/services/chat_service.dart';
//import 'package:mobile_flutter/services/chat_socket.dart';

class ChatProvider extends ChangeNotifier {
  /*final ChatService _chatService;
  final WebSocketService _webSocketService;

  List<Chat> _chats = [];
  Chat? _currentChat;
  List<Message> _messages = [];

  ChatProvider(this._chatService, this._webSocketService);

  List<Chat> get chats => _chats;
  Chat? get currentChat => _currentChat;
  List<Message> get messages => _messages;

  Future<void> fetchChats(String token) async {
    try {
      _chats = await _chatService.fetchChats(token);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch chats: $e');
    }
  }

  Future<void> fetchMessages(String chatId, String token) async {
    try {
      _messages = await _chatService.fetchMessages(chatId, token);
      _currentChat = _chats.firstWhere((chat) => chat.id == chatId);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch messages: $e');
    }
  }

  Future<void> sendMessage(String chatId, String content, String token) async {
    try {
      await _chatService.sendMessage(chatId, content, token);
      _webSocketService.sendMessage(chatId, content);
      notifyListeners();
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  void connectToWebSocket(String userId) {
    _webSocketService.connect(c);
    _webSocketService.registerNewMessageListener(_handleNewMessage);
  }

  void _handleNewMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }*/
}