import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/providers/auth_provider.dart';
import 'package:mobile_flutter/services/chat_socket.dart';
import 'package:provider/provider.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late WebSocketService _webSocketService;
  late AuthProvider _authProvider;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _webSocketService = WebSocketService(context);
    _webSocketService.registerNewMessageListener(_handleNewMessage);
  }

  void _handleNewMessage(Message message) {
    setState(() {
      // Update the chat messages with the new message
    });
  }

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      _webSocketService.sendMessage(widget.chat.id, message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final otherUser = getOtherUser(widget.chat, _authProvider.user!.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(otherUser.fullName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.chat.messages.length,
              itemBuilder: (context, index) {
                final message = widget.chat.messages[index];
                return ListTile(
                  title: Text(message.content),
                  // Add additional UI elements for message metadata, etc.
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
              IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}


/*import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/providers/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  late IO.Socket socket;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectToServer();
  }

  void _connectToServer() {
    
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chat = ModalRoute.of(context)!.settings.arguments as Chat;
    Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${chat.user1.fullName} - ${chat.user2.fullName}',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chat.messages.length,
              itemBuilder: (context, index) {
                final message = chat.messages[index];
                return ListTile(
                  title: Text(
                    '${message.sender.fullName}: ${message.content}',
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/