import 'dart:convert';

import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/providers/auth_provider.dart';
import 'package:mobile_flutter/utils/constants.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final String chatUrl = Constants.baseUrl;

  Future<List<Chat>> fetchChats(AuthProvider authProvider) async {
    final token = authProvider.token;
    final url = Uri.parse('$chatUrl/chats');
    final headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonChats = jsonDecode(response.body);
      return jsonChats.map((json) => Chat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch chats');
    }
  }

  Future<List<Message>> fetchMessages(String chatId, AuthProvider authProvider) async {
    final token = authProvider.token;
    final url = Uri.parse('$chatUrl/chats/$chatId');
    final headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonMessages = jsonDecode(response.body)['messages'];
      return jsonMessages.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch messages');
    }
  }
}