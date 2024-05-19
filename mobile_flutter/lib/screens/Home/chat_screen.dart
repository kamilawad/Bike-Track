import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/providers/auth_provider.dart';
import 'package:mobile_flutter/screens/Home/chat_details_screen.dart';
import 'package:mobile_flutter/services/chat_service.dart';
import 'package:mobile_flutter/services/chat_socket.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatService _chatService;
  late AuthProvider _authProvider;
  late WebSocketService _webSocketService;
  late io.Socket socket;

  @override
  void initState() {
    super.initState();
    _chatService = ChatService();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _webSocketService = WebSocketService(context);
    _webSocketService.connect(context);
    _fetchChats();
  }

  Future<void> _fetchChats() async {
    setState(() {});
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: FutureBuilder<List<Chat>>(
        future: _chatService.fetchChats(_authProvider.token!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final chats = snapshot.data!;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                final otherUser = chat.user1.id == _authProvider.user!.id
                    ? chat.user2
                    : chat.user1;

                final sentAt = DateTime.parse(chat.messages.last.sentAt.toString());
                final now = DateTime.now();
                final difference = now.difference(sentAt);

                String formattedDate;
                if (difference.inDays == 0) {
                  formattedDate = 'Today, ${DateFormat('hh:mm a').format(sentAt)}';
                } else if (difference.inDays == 1) {
                  formattedDate = 'Yesterday, ${DateFormat('hh:mm a').format(sentAt)}';
                } else if (difference.inDays < 7) {
                  formattedDate = '${DateFormat('EEEE').format(sentAt)}, ${DateFormat('hh:mm a').format(sentAt)}';
                } else {
                  formattedDate = DateFormat('M/d/yyyy').format(sentAt);
                }
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(otherUser.fullName[0]),
                  ),
                  title: Text(otherUser.fullName),
                  subtitle: Text(
                    chat.messages.isNotEmpty
                        ? chat.messages.last.content
                        : 'No messages',
                  ),
                  trailing: chat.messages.isNotEmpty
                      ? Text(formattedDate)
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailScreen(chat: chat),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}