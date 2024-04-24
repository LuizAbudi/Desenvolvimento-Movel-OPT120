import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await http.post(
      Uri.parse(
        'http://localhost:3000/auth/login',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      print('Sucesso no login');
    } else {
      throw Exception('Failed to login');
    }
  }
}
