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