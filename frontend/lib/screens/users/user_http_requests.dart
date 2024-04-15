import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await http.get(Uri.parse(
      'http://localhost:3000/users',
    ));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> users =
          data.map((user) => user as Map<String, dynamic>).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<void> getUserById(String id) async {
    final response = await http.get(Uri.parse(
      'http://localhost:3000/users/$id',
    ));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<void> createUser(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      print(response.body);
    } else {
      throw Exception('Failed to create user');
    }
  }

  static Future<void> updateUser(
      int id, String name, String email, String password) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to update user');
    }
  }

  static Future<void> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/users/$id'),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
