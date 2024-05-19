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

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'],
      user1: UserModel.fromJson(json['user1']),
      user2: UserModel.fromJson(json['user2']),
      messages: List<Message>.from(json['messages'].map((x) => Message.fromJson(x))),
    );
  }
}

class groupChat {
  final String id;
  final UserModel user1;
  final UserModel user2;
  final List<Message> messages;

  groupChat({
    required this.id,
    required this.user1,
    required this.user2,
    required this.messages,
  });

  factory groupChat.fromJson(Map<String, dynamic> json) {
    return groupChat(
      id: json['_id'],
      user1: UserModel.fromJson(json['user1']),
      user2: UserModel.fromJson(json['user2']),
      messages: List<Message>.from(json['messages'].map((x) => Message.fromJson(x))),
    );
  }
}

UserModel getOtherUser(Chat chat, String currentUserId) {
  if (chat.user1.id == currentUserId) {
    return chat.user2;
  } else {
    return chat.user1;
  }
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