import 'dart:io';

import 'package:anaar_demo/model/reseller_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _userType;
  String? get userid => _userId;
  String? get token => _token;
  bool get isAuth => _token != null;
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  Future<String> _uploadImage(File? _imageFile) async {
    if (_imageFile == null) {
      print('No image selected.');
      return '';
    }

    final url =
        'https://shopemeapp-backend.onrender.com/upload'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Add the image file to the request
    final imageStream =
        http.ByteStream(Stream.castFrom(_imageFile!.openRead()));
    final imageLength = await _imageFile!.length();
    final imageField = http.MultipartFile('image', imageStream, imageLength,
        filename: 'image.jpg'); // Replace 'image' with your field name

    request.files.add(imageField);
    request.headers.addAll(headers);

    final response = await request.send();
    if (response.statusCode == 200) {
      final imageUrl = await response.stream.bytesToString();
      print('Image uploaded successfully. URL: $imageUrl');
      return imageUrl;
    } else {
      print('Image upload failed. Status code: ${response.statusCode}');
      return '';
    }
  }

  Future<bool> resllerregister(
      String ownerName,
      String businessName,
      String city,
      String email,
      String contact,
      String password,
      String address,
      String aboutUs,
      File? image) async {
    try {
      _isLoading=true;
      notifyListeners();
      final url = Uri.parse(
          'https://shopemeapp-backend.onrender.com/api/user/registerReseller');
 
      String imagurl = await _uploadImage(image);
      print("baina image  ke yha aa rha hai........");
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "ownerName": ownerName,
            "businessName": businessName,
            "email": email,
            "address": address,
            "password": password,
            "type": "reseller",
            "contact": contact,
            "city": city,
            "image":imagurl??'',
            "aboutUs":aboutUs
          }));
            _isLoading = false;
        notifyListeners();

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token = data['token'];
        final payload = decodeJWT(_token!);
        _userId = data['session']['id'];
        _userType = data['session']['type'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setString('userId', _userId!);
        await prefs.setString('userType', _userType!);
        // await _fetchUserInfo(_userId!);
      

        return true;
      } else if (response.statusCode == 400) {
        print("bad request");
        _isLoading = false;
        notifyListeners();
        return false;
      } else if (response.statusCode == 401) {
        _isLoading = false;
        notifyListeners();
      //  throw Exception('user already exists');
        SnackBar(content: Text("User already exists"));  
         return false;
      } else {
        print(response.statusCode);
       print(response.body);
        _isLoading = false;
        notifyListeners();
        throw Exception('Failed to register');
      }
    } catch (e) {
      _isLoading = false;
      print(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> Consumer_register(String name, String city, String email,
      String contact, String password, File? image,String bio) async {
     _isLoading=true;
     notifyListeners();

    final url = Uri.parse(
        'https://shopemeapp-backend.onrender.com/api/user/registerConsumer');

    String imagurl = await _uploadImage(image);
     print("baina image  ke yha aa rha hai........");
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "email": email,
          "password": password,
          "contact": contact,
          "city": city,
          "type": "Consumer",
          "image":imagurl,
          "bio":bio
        }));

    _isLoading=false;
     notifyListeners();


    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _token = data['token'];
      final payload = decodeJWT(_token!);
      _userId = data['session']['id'];
      _userType = data['session']['type'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('userId', _userId!);
      await prefs.setString('userType', _userType!);
      // await _fetchUserInfo(_userId!);
      notifyListeners();
      return true;
    } else if (response.statusCode == 400) {
      print("bad request");
      return false;
    } else if (response.statusCode == 401) {
    print('user already exists');
      return false;
    } else {
      print(response.statusCode);
      print('Failed to register');
      return false;
    }
  }

  // Future<void> tryAutoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('token')) return;

  //   _token = prefs.getString('token');
  //   // _userId = prefs.getString('userId');
  //   notifyListeners();
  // }
  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) return;

    _token = prefs.getString('token');
    _userId = prefs.getString('userId');
    _userType = prefs.getString('userType');

    // Optionally, verify the token with your backend here

    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
    //return true;
  }

  Future<bool> Consumer_Login(
    String email,
    String password,
  ) async {
      _isLoading=true;
      notifyListeners();

    final url = Uri.parse(
        'https://shopemeapp-backend.onrender.com/api/user/loginConsumer');

    //String imagurl = await _uploadImage(image);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));

    _isLoading=false;
    notifyListeners();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _token = data['token'];
      final payload = decodeJWT(_token!);
      _userId = data['session']['id'];
      _userType = data['session']['type'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('userId', _userId!);
      await prefs.setString('userType', _userType!);
      // await _fetchUserInfo(_userId!);
      notifyListeners();
      return true;
    } else if (response.statusCode == 400) {
      print("bad request");
      return false;
    } else if (response.statusCode == 404) {
      print(response.body);
      throw Exception('Check Email and Password');
      
    } else if(response.statusCode==401){
      throw Exception('Incorrect Password');
    }
    else{
      print(response.statusCode);
      throw Exception('Failed to Login');
      return false;
    }
  }

  Future<bool> Reseller_login(
    String email,
    String password,
  ) async {
    final url = Uri.parse(
        'https://shopemeapp-backend.onrender.com/api/user/loginReseller');

    //String imagurl = await _uploadImage(image);
    _isLoading = true;
    notifyListeners();
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));
    _isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _token = data['token'];
      final payload = decodeJWT(_token!);
      _userId = data['session']['id'];
      _userType = data['session']['type'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('userId', _userId!);
      await prefs.setString('userType', _userType!);
      // await _fetchUserInfo(_userId!);
      print("................login successfull................");
      notifyListeners();
      return true;
    } else if (response.statusCode == 400) {
      print("................login failed................");
      print("bad request");
      return false;
    } else if (response.statusCode == 401) {
      //throw Exception('user already exists');
      print("................login failed................${response.statusCode}${response.body}");
      return false;
    } else {
      print(response.statusCode);
      print("................login failed................${response.body}");
      //throw Exception('Failed to Login');
      return false;
    }
  }

  ///token decoder

  Map<String, dynamic> decodeJWT(String token) {
    final parts = token.split('.');
    assert(parts.length == 3);

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }
}
