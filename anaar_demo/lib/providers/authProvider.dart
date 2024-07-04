import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;

  String? get token => _token;
  bool get isAuth => _token != null;

  Future<void> register(String firstName, String lastName, String username,
      String email, String contact, String password, String city,String imagePath) async {
    final url = Uri.parse(
        'https://shopemeapp-backend.onrender.com/api/user/registerConsumer');

    final request = http.MultipartRequest('POST', url)
      ..fields['ownername'] = firstName
      ..fields['businessname'] = lastName
       ..fields['image'] = imagePath
      ..fields['email'] = email
      ..fields['contact'] = contact
       ..fields['city'] = city
      ..fields['password'] = password;

    if (imagePath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('profileImage', imagePath));
    }

    final response = await request.send();
    final responseData = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = json.decode(responseData.body);
      _token = data['token'];
      _userId = data['user']['id'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('userId', _userId!);
      notifyListeners();
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<bool?> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) return false;

    _token = prefs.getString('token');
    _userId = prefs.getString('userId');
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
