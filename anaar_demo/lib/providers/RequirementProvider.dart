import 'dart:convert';

import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/Requirement_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      print(
          "............Requirement uploaded successfully....................");
      isLoading = false;
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response.body);
      isLoading = false;
      notifyListeners();
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
    try{
    if (images.isEmpty) {
      await postRequirement(requirement);
    }
    else{
      print(images);
    try {
      List<String?> imageUrls = [];
      for (var image in images) {
        String? imageUrl = await Helperfunction.uploadImage(image);

        imageUrls.add(imageUrl);
      }
      requirement.images = imageUrls;
      print(imageUrls[0]);
      await postRequirement(requirement);
    } catch (error) {  isLoading =false;
    notifyListeners();
        print("..........image error");
      throw error;
    }
    }
    }
    catch(error){
    isLoading=false;
    notifyListeners();
    throw error;

    }

  }
}

//.......................................fetching requirements.....................

class RequirementcardProvider with ChangeNotifier {
  List<Requirement> _reqcards = [];
  bool _isLoading = false;

  List<Requirement> get reqcards => _reqcards;
  bool get isLoading => _isLoading;

  Future<void> fetchreqcards() async {
    _isLoading=true;
    notifyListeners();
    try {
      _reqcards = await fetchrequirementcards();
    } catch (error) {
       _isLoading=false;
    notifyListeners();

      print(error);
    }
  }

 Future<List<Requirement>> fetchrequirementcards() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
     const String url =
      'https://shopemeapp-backend.onrender.com/api/requirement/getAllRequirements';
    print(token);
    print('REQUIREMENT CARD FETCH KRNE AYA HU');
    final response = await http.get(
      Uri.parse('$url'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
   _isLoading=false;
   notifyListeners();


    if (response.statusCode == 200) {
      print(">>>>>>>>>>>>>>>>>>>>>got the requirements...........");
      print(response.body.toString());
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((item) => Requirement.fromJson(item)).toList();
    } else {
      throw Exception(
          '${response.statusCode}${response.body}{Failed to load requiremnetcard');
    }
  }

//............................fetch requirement by userid .....................

 Future<List<Requirement>> fetchrequirementByuserid(String? userid) async {
    final prefs = await SharedPreferences.getInstance();
    print('${userid}.........................');
    final token = prefs.getString('token');
     String url =
      'https://shopemeapp-backend.onrender.com/api/requirement/getReqByUserid?userId=$userid';
    print(token);
    print('REQUIREMENT CARD FETCH KRNE AYA HU');
    final response = await http.get(
      Uri.parse('$url'),
      
    );
   _isLoading=false;
   notifyListeners();


    if (response.statusCode == 200) {
      print(">>>>>>>>>>>>>>>>>>>>>got the requirements...........");
      print(response.body.toString());
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((item) => Requirement.fromJson(item)).toList();
    } else {
      print("Failed to get user requirement ...............${response.body}");
      throw Exception(
          '${response.statusCode}${response.body}{Failed to load requiremnetcard');
    }
  }
  //........................delete requirement......................


 Future<void> deleteRequirement(String postId) async {
   final prefs = await SharedPreferences.getInstance();

   _isLoading=true;
    notifyListeners();
    try{
    final token = prefs.getString('token');
    final url = 'http://shopemeapp-backend.onrender.com/api/requirement/deleteRequirement?id=$postId';
    final response = await http.get(Uri.parse(url),
    );

     _isLoading=false;
    notifyListeners(); 

    if (response.statusCode == 200) {
      _reqcards.removeWhere((post) => post.sId == postId);
      notifyListeners();
         print("...........Deleted requirement successfully...............");
         // return true;

    } else {
      print(response.body);
      print('Failed to delete requirement..............');
      throw('................Failed to delete post');
      // return false;
    }}catch(erro){
      throw erro;
    }
  }














//................................search requirement ........................




 List<Requirement> _searchResults = [];


  List<Requirement> get searchResults => _searchResults; 

Future<void> searchRequirements(String prefix) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

print('requiremnet search ki .......... request aa rhi hai................................');

  final url =
      'http://shopemeapp-backend.onrender.com/api/requirement/searchRequirement?prefix=$prefix';
  _isLoading = true;
  notifyListeners();
  try {
    final response = await http.get(
      Uri.parse(url),
      
    );

    
    if (response.statusCode == 200) {
      print("................this is working............");
      print(response.body);
      List jsonResponse = json.decode(response.body);
      _searchResults = jsonResponse
          .map((item) => Requirement.fromJson(item))
          .toList();
      _reqcards=_searchResults;
      notifyListeners();

    } else {
      print("${response.body}.................${response.statusCode}");
      throw Exception('Failed to search reach requirement....');
    }
  } catch (error) {
    print('Error searching catalog: $error');
    throw error;
  } finally {
    _isLoading = false;
    notifyListeners();
  }




}




void clearSearch() {
    _searchResults = _reqcards;
    notifyListeners();
  }









}
