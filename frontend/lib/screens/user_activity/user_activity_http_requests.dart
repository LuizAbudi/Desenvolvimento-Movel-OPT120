import 'dart:convert';
import 'package:http/http.dart' as http;

class UserActivitiesService {
  static Future<List<Map<String, dynamic>>> getUserActivities() async {
    final response = await http.get(Uri.parse(
      'http://localhost:3000/user_activity',
    ));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> userActivities = data
          .map((userActivity) => userActivity as Map<String, dynamic>)
          .toList();
      return userActivities;
    } else {
      throw Exception('Failed to load user activities');
    }
  }

  static Future<void> createUserActivity(
      int userId, int activityId, String deliveryDate, int score) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/user_activity'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user_id': userId,
        'activity_id': activityId,
        'delivery_date': deliveryDate,
        'score': score,
      }),
    );
    if (response.statusCode == 201) {
      print(response.body);
    } else {
      throw Exception('Failed to create user activity');
    }
  }

  static Future<void> updateUserActivity(
      int userId, int activityId, String deliveryDate, int score) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/user_activity/$userId/$activityId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'delivery_date': deliveryDate,
        'score': score,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to update user activity');
    }
  }

  static Future<void> deleteUserActivity(int userId, int activityId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/user_activity'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user_id': userId,
        'activity_id': activityId,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to delete user activity');
    }
  }
}
