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