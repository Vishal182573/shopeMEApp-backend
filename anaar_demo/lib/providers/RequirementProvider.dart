import 'dart:convert';

import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/Requirement_model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
// import the requirement model

class RequirementProvider with ChangeNotifier {
  bool isLoading = false;

  Future<void> postRequirement(Requirement requirement) async {
    isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final type = prefs.getString('userType');
    if (type == 'reseller') {
      requirement.userType = 'reseller';
    } else {
      requirement.userType = 'consumer';
    }
    final url =
        'https://shopemeapp-backend.onrender.com/api/requirement/postRequirement';
    print(token);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode(requirement.toJson()),
    );

    if (response.statusCode == 200) {
      print(
          "............Requirement uploaded successfully....................");
      isLoading = false;
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response.body);
      isLoading = false;
      throw Exception(
          '...................Failed to upload Requirement...............');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> postrequiremnetwithimage(
      Requirement requirement, List<File> images) async {
    isLoading = true;
    notifyListeners();
    if (images == null) {
      await postRequirement(requirement);
    }
    try {
      List<String?> imageUrls = [];
      for (var image in images) {
        String? imageUrl = await Helperfunction.uploadImage(image);

        imageUrls.add(imageUrl);
      }
      requirement.images = imageUrls;
      print(imageUrls[0]);
      await postRequirement(requirement);
    } catch (error) {
      throw error;
    }
  }
}

//.......................................fetching requirements.....................
class RequiremntCardService {
  static const String url =
      'https://shopemeapp-backend.onrender.com/api/requirement/getAllRequirements';

  static Future<List<Requirement>> fetchrequirementcards() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    print('REQUIREMENT CARD FETCH KRNE AYA HU');
    final response = await http.get(
      Uri.parse('$url'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("got the requirements...........");
      print(response.body.toString());
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((item) => Requirement.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load requiremnetcard');
    }
  }
}

class RequirementcardProvider with ChangeNotifier {
  List<Requirement> _reqcards = [];
  bool _isLoading = true;

  List<Requirement> get reqcards => _reqcards;
  bool get isLoading => _isLoading;

  Future<void> fetchreqcards() async {
    try {
      _reqcards = await RequiremntCardService.fetchrequirementcards();
    } catch (error) {
      print(error);
    }
  }
}
