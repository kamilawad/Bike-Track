import 'dart:convert';
import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/utils/constants.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final String chatUrl = Constants.chatUrl;

  Future<List<Chat>> fetchChats(String token) async {
    print('this is me token $token');
    final url = Uri.parse(chatUrl);
    final headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(url, headers: headers);
    final status = response.statusCode;
    print('this is me response $status');


    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> jsonChats = jsonDecode(response.body);
      print(jsonChats);
      return jsonChats.map((json) => Chat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch chats ${response.statusCode} ${response.body}');
    }
  }

  Future<List<Message>> fetchMessages(String chatId, String token) async {
    final url = Uri.parse('$chatUrl/$chatId');
    final headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonMessages = jsonDecode(response.body)['messages'];
      return jsonMessages.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch messages');
    }
  }

  Future<Message> sendMessage(String chatId, String content, String token) async {
    final url = Uri.parse('$chatUrl/$chatId/send-message');
    final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final body = jsonEncode({'content': content});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send message');
    }
  }
}