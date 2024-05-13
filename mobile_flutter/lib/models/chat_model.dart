import 'package:mobile_flutter/models/user_model.dart';

class Chat {
  final String id;
  final UserModel user1;
  final UserModel user2;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.user1,
    required this.user2,
    required this.messages,
  });
}

class Message {
  final String id;
  final UserModel sender;
  final String content;
  final DateTime sentAt;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      sender: UserModel.fromJson(json['sender']),
      content: json['content'],
      sentAt: DateTime.parse(json['sentAt']),
    );
  }
}