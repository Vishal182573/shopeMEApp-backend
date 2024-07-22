// providers/user_provider.dart
import 'dart:convert';
import 'package:anaar_demo/model/reseller_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  Reseller? _reseller;

  Reseller? get reseller => _reseller;

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return;
    }
  
    print(token);
    final userId = prefs.getString('userId');
    print(userId);
    final url = Uri.parse(
        'https://shopemeapp-backend.onrender.com/api/user/getReseller?id=$userId');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'barrer $token',
      });

      if (response.statusCode == 200) {
        print("uyessssssssssssss");
        final userData = json.decode(response.body);
        _reseller = Reseller.fromJson(userData);
        print(_reseller!.ownerName);
        notifyListeners();
      } else {
        print(response.statusCode);
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw error;
    }
  }
}
