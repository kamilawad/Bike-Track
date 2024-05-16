import 'package:flutter/material.dart';
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
                        ? Text(chat.messages.last.sentAt.toString())
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


/*import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {

  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  late IO.Socket socket;
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _connectToServer();
  }

  void _connectToServer() {
    socket = IO.io(
    'http://192.168.0.105:3000/chat',
    IO.OptionBuilder()
      .setTransports(['websocket'])
      .setAuth({'userId': "663d70bfaaafc2eab3b8b59e"})
      .build(),
    );

    socket.onConnect((data) {
      print('Connected');
    });

    socket.on('newMessage', (data) {
      setState(() {
        _messages.add(data['content']);
      });
    });

    socket.connect();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      socket.emit('sendMessage', {'chatId': '66406fcdccbd803409b21468', 'content': message});
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
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


/*import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Transform.scale(
            scale: 0.9,
            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25)),),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(color: Colors.black12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(),
                  title: Text('User $index'),
                  subtitle: const Text('Last message...'),
                  trailing: const Text('12:00 PM'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/