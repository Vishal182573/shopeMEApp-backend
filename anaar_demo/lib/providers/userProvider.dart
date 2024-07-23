// providers/user_provider.dart
import 'dart:convert';
import 'dart:io';
import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/reseller_model.dart';
import 'package:anaar_demo/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  Reseller? _reseller;

  Reseller? get reseller => _reseller;
  // Usermodel? _usermodel;
  // Usermodel? get usermodel => _usermodel;
  bool _isloading = false;
  bool get isloading => _isloading;

  Map<String, Usermodel> _userModels = {};

  Usermodel? getUserModel(String userId) => _userModels[userId];

  Future<Usermodel?> fetchUserinfo(String? userId) async {
    if (userId == null) return null;

    if (_userModels.containsKey(userId)) {
      return _userModels[userId];
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return null;
    }

    final url = Uri.parse(
        'https://shopemeapp-backend.onrender.com/api/user/getReseller?id=$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        final userModel = Usermodel.fromJson(userData);
        _userModels[userId] = userModel;
        print("successfully requirement card ki detail mil giye ............");
        notifyListeners();
        return userModel;
      } else {
        print('Failed to load user data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
  }

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

//.......................................update userprofile data..for reseller.....................

  Future<void> _updateResellerInfo(Reseller reseller) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      _isloading = true;
      notifyListeners();
      final url = Uri.parse(
          'https://shopemeapp-backend.onrender.com/api/user/updateReseller');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(reseller.toJson()),
      );
      _isloading = false;
      notifyListeners();
      if (response.statusCode == 200) {
        print("Successfully update userdata...........");
        notifyListeners();
      } else if (response.statusCode == 400) {
        print("bad request");
      } else if (response.statusCode == 401) {
        throw Exception('user already exists');

        // return false;
      } else {
        print(response.statusCode);
        notifyListeners();
        throw Exception('Failed to register');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateresellerinfowithImage(
      Reseller info, File? image, File? bgImage) async {
    try {
      String? imageurl1 = await Helperfunction.uploadImage(image);
      String? bgimage_url = await Helperfunction.uploadImage(bgImage);

      info.image = imageurl1;
      info.bgImage = bgimage_url;
      print("Success");
      await _updateResellerInfo(info);
    } catch (error) {
      throw error;
    }
  }
}
