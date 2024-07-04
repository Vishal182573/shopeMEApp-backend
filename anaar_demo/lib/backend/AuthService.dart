import 'dart:convert';
import 'package:anaar_demo/backend/tokenMangaer.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://your-backend-url';

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String token = data['token'];
      await TokenManager.saveToken(token);
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String?> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      String token = data['token'];
      await TokenManager.saveToken(token);
      return token;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<void> logout() async {
    await TokenManager.removeToken();
  }

  Future<http.Response> getProtectedData() async {
    String? token = await TokenManager.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/protected-endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}
