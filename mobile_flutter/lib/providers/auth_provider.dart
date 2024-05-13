import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  String? _token;

  UserModel? get user => _user;
  String? get token => _token;

  void setUser(UserModel? user) {
    _user = user;
    _token = token;
    notifyListeners();
  }
}