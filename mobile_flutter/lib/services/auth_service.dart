import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.0.105:3000/auth';

  Future<UserModel> signUp(String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      body: {'fullName': fullName, 'email': email, 'password': password},
    );

    if (response.statusCode == 201) {
      final userData = jsonDecode(response.body)['user'];
      return UserModel.fromJson(userData);
    } else {
      throw Exception('Signup failed');
    }
  }

  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 201) {
      final userData = jsonDecode(response.body)['user'];
      return UserModel.fromJson(userData);
    } else {
      throw Exception('Login failed');
    }
  }
}