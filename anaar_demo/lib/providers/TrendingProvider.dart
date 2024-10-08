import 'dart:convert';

import 'package:anaar_demo/model/postcard_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PostcardService {
  static const String url =
      'https://shopemeapp-backend.onrender.com/api/post/trending';
  
  static Future<List<Postcard>> fetchPostcards() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    print('Getting Trending page..........');
    final response = await http.get(
      Uri.parse('$url'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("..................Got the trend  data successfully.........");
      print(response.body);
      
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((postcard) => Postcard.fromJson(postcard))
          .toList();
    } else {
      print('${response.body}');
      throw Exception('Failed to load postcards');
    }
  }
}

class Trendingprovider with ChangeNotifier {
  List<Postcard> _postcar = [];
   bool _isLoading = false;
bool _isLoaded=false;
bool get isLoaded=>_isLoaded;


  List<Postcard> get postcards => _postcar;
  bool get isLoading => _isLoading;

  Future<void> fetchPostcards() async {
    try {
    _isLoading=true;
      notifyListeners();
      _postcar = await PostcardService.fetchPostcards();
      _isLoaded=true;
        notifyListeners();
        _isLoading=false;
      notifyListeners();
    } catch (error) {
      _isLoading=false;
      notifyListeners();
      print(error);
    }
  }
}
