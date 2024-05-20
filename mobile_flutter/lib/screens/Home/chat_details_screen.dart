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
  List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _webSocketService = WebSocketService(context);
    _webSocketService.registerNewMessageListener(_handleNewMessage);
    _messages = widget.chat.messages;
  }

  void _handleNewMessage(Message message) {
    setState(() {
      _messages.add(message);
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _sendMessage() {
    final messageContent = _messageController.text;
    if (messageContent.isNotEmpty) {
      final newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: _authProvider.user!,
        content: messageContent,
        sentAt: DateTime.now(),
      );

      setState(() {
        _messages.add(newMessage);
      });

      _webSocketService.sendMessage(widget.chat.id, messageContent);

      _messageController.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final otherUser = getOtherUser(widget.chat, _authProvider.user!.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(otherUser.fullName),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isOwnMessage = message.sender.id == _authProvider.user!.id;
                final isSameUserAsLastMessage =
                    index > 0 && _messages[index - 1].sender.id == message.sender.id;
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    isOwnMessage ? 64.0 : 16.0,
                    isSameUserAsLastMessage ? 4.0 : 16.0,
                    isOwnMessage ? 16.0 : 64.0,
                    isSameUserAsLastMessage ? 4.0 : 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: isOwnMessage ? Color(0xFFF05206) : Colors.grey[300],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          message.content,
                          style: TextStyle(
                            color: isOwnMessage ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                MaterialButton(
                  onPressed: _sendMessage,
                  color: Color(0xFFF05206),
                  shape: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
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