import 'dart:convert';

import 'package:anaar_demo/model/consumer_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CommenUserProvider with ChangeNotifier {
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
          url=Uri.parse(
          'https://shopemeapp-backend.onrender.com/api/user/getConsumer?id=$userId');

    } else {
       url = Uri.parse(
          'https://shopemeapp-backend.onrender.com/api/user/getReseller?id=$userId');
    }

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'barrer $token',
      });

      // _userCache[id] = response;
      // notifyListeners();
    //  return userData;
 if (response.statusCode == 200) {
        print(".................Got ther user info");
        final userData = json.decode(response.body);
        _userCache[id] = ConsumerModel.fromJson(userData);
        //print(_reseller!.ownerName);
        notifyListeners();
      } else {
        print(response.statusCode);
        throw Exception('Failed to load user data');
      }


    } catch (error) {
      throw (error);
    }
  }
}
