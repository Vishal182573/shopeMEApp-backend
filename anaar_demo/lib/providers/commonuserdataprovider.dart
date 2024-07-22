import 'dart:convert';

import 'package:anaar_demo/model/consumer_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommenUserProvider with ChangeNotifier {
  ConsumerModel? _userinfo;

  ConsumerModel? get userinfo => _userinfo;
  Map<String?, ConsumerModel> _userCache = {};

  Future<ConsumerModel?> fetchUserData(String? id, String? userType) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (_userCache.containsKey(id)) {
      return _userCache[id]!;
    }

    // Fetch user data from your API
    print(token);
    var url;
    final userId = prefs.getString('userId');
    print(userId);
    if (userType == 'consumer') {
      url = Uri.parse(
          'http://192.168.0.107:3000/api/user/getConsumer?id=$userId');
    } else {
      url = Uri.parse(
          'http://192.168.0.107:3000//api/user/getReseller?id=$userId');
    }

    try {
      final response = await http.get(
        url,
      );

      // _userCache[id] = response;
      // notifyListeners();
      //  return userData;
      if (response.statusCode == 200) {
        print(".................Got ther user successfully...............");
        final userData = json.decode(response.body);
        _userCache[id] = ConsumerModel.fromJson(userData);
        //print(_reseller!.ownerName);
        notifyListeners();
      } else {
        print(response.statusCode);
        print(response.body.toString());
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw (error);
    }
  }
}
