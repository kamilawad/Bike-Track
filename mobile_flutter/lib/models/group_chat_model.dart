import 'package:mobile_flutter/models/chat_model.dart';
import 'package:mobile_flutter/models/user_model.dart';

class GroupChat {
  final String id;
  final String name;
  final List<UserModel> participants;
  final List<Message> messages;

  GroupChat({
    required this.id,
    required this.name,
    required this.participants,
    required this.messages,
  });

  factory GroupChat.fromJson(Map<String, dynamic> json) {
    return GroupChat(
      id: json['_id'],
      name: json['name'],
      participants: List<UserModel>.from(
        json['participants'].map((participant) => UserModel.fromJson(participant)),
      ),
      messages: List<Message>.from(
        json['messages'].map((message) => Message.fromJson(message)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'participants': participants.map((participant) => participant.toJson()).toList(),
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}
