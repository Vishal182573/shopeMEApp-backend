import 'dart:convert';
import 'dart:io';

import 'package:anaar_demo/backend/notification_services.dart';
import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/catelogMode.dart';
import 'package:anaar_demo/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CatelogProvider extends ChangeNotifier {
  List<Catelogmodel> _catelogpost = [];

  List<Catelogmodel> get catelogpost => _catelogpost;


  List<Catelogmodel> _searchResults = [];


  List<Catelogmodel> get searchResults => _searchResults;  // A
  bool _isLoading = false;

  bool  get isLoading => _isLoading;

  Future<void> uploadCatelog(Catelogmodel catelog) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url =
        'https://shopemeapp-backend.onrender.com/api/catalog/uploadCatalog';
    
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode(catelog.toJson()),
    );
    _isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      _catelogpost.add(catelog);
      print("successfully Uploaded catelog post");
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to upload Catelog');
    }
  }

  Future<void> uploadCatelogWithImages(
      Catelogmodel catelogModel, List<File> images) async {
    try {
      _isLoading = true;
    notifyListeners();
      List<String?> imageUrls = [];
      for (var image in images) {
        String? imageUrl = await Helperfunction.uploadImage(image);

        imageUrls.add(imageUrl);
      }
      // List<Catalog>? ct = catelog.catalog;
      catelogModel.images = imageUrls;
      // post.images = imageUrls;
      print(imageUrls[0]);
      await uploadCatelog(catelogModel);
    } catch (error) {
      _isLoading =false;
    notifyListeners();
      throw error;
    }
  }

//..............................getcatelog by userid.......................
  Future<List<Catelogmodel>> getPostByuserId(String? userid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('${userid}..................yaha fetch function me aya hai catelog');

    try {
      final url =
          'https://shopemeapp-backend.onrender.com/api/catalog/getAllByUserId?userId=$userid';
      final response = await http.get(
        Uri.parse('$url'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print("..................Got the Catelog for the user..........");
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((postcard) => Catelogmodel.fromJson(postcard))
            .toList();
      } else {
        print('${response.body}');
        throw Exception('Failed to load catelog');
      }
    } catch (error) {
      throw (error);
    }
  }

//....................................search result..............................

Future<void> searchCatalog(String prefix) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

print('request aa rhi hai................................');

  final url =
      'http://shopemeapp-backend.onrender.com/api/catalog/searchCatalog?prefix=$prefix';
  _isLoading = true;
  notifyListeners();
  try {
    final response = await http.get(
      Uri.parse(url),
      
    );

    
    if (response.statusCode == 200) {
      print("................this is working............");
      List jsonResponse = json.decode(response.body);
      _searchResults = jsonResponse
          .map((item) => Catelogmodel.fromJson(item))
          .toList();
      notifyListeners();
    } else {
      print("${response.body}.................${response.statusCode}");
      throw Exception('Failed to search catalog');
    }
  } catch (error) {
    print('Error searching catalog: $error');
    throw error;
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}









}
