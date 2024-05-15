import 'package:http/http.dart' as http;
import 'package:mobile_flutter/utils/constants.dart';
import 'dart:convert';

class AuthService {
  final String authUrl = Constants.authUrl;

  Future<Map<String, dynamic>> signUp(String fullName, String email, String password) async {
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

  Future<Map<String, dynamic>> login(String email, String password) async {
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