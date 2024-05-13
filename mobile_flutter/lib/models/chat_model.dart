

import 'package:mobile_flutter/models/user_model.dart';

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
}