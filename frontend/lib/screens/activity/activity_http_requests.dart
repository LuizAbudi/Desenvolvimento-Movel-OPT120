import 'dart:convert';
import 'package:http/http.dart' as http;

class ActivityService {
  static Future<List<Map<String, dynamic>>> getActivities() async {
    final response = await http.get(Uri.parse(
      'http://localhost:3000/activity',
    ));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> activities =
          data.map((user) => user as Map<String, dynamic>).toList();
      return activities;
    } else {
      throw Exception('Failed to load activities');
    }
  }

  static Future<void> getActivityById(int id) async {
    final response = await http.get(Uri.parse(
      'http://localhost:3000/activity/$id',
    ));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load activity');
    }
  }

  static Future<void> createActivity(
      String title, String description, String dueDate) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/activity'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'due_date': dueDate,
      }),
    );
    if (response.statusCode == 201) {
      print(response.body);
    } else {
      throw Exception('Failed to create activity');
    }
  }

  static Future<void> updateActivity(
      int id, String title, String description, String dueDate) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/activity/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'due_date': dueDate,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to updue_date activity');
    }
  }

  static Future<void> deleteActivity(int id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/activity/$id'),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to delete activity');
    }
  }
}
