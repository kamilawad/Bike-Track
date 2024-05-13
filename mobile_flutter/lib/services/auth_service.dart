import 'package:http/http.dart' as http;
import 'package:mobile_flutter/utils/constants.dart';
import 'dart:convert';

import '../models/user_model.dart';

class AuthService {
  final String authUrl = Constants.authUrl;

  Future<UserModel> signUp(String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$authUrl/signup'),
      body: {'fullName': fullName, 'email': email, 'password': password},
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Signup failed');
    }
  }

  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$authUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }
}