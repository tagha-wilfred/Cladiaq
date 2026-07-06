import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository {
  // final String _baseUrl = 'http://13.61.33.10:8000/api';
  final String _baseUrl = 'http://13.60.4.19:8000/api';

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // Store the token in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      return data;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'password': password, 'email': email}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  Future<void> logout() async {
    // Remove the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print(token.toString());
    return token;
  }

  Future<http.Response> fetchUser() async {
    // Replace with your actual base URL
    final token = await getToken();
    print(token);
    final response = await http.get(
      Uri.parse('$_baseUrl/users/me/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token', // Token passed in the Authorization header
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }
}
