import 'package:anaar_demo/model/postcard_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentProvider with ChangeNotifier {
  List<Comments> _comments = [];

  List<Comments> get comments => _comments;

  Future<void> addComment(String? postId, Comments newComment) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('https://shopemeapp-backend.onrender.com/api/post/comment'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'postid': postId,
        'userid': newComment.userId,
        'comment': newComment.comment,
      }),
    );

    if (response.statusCode == 200) {
      print("new Comment successfull.......");
      final newComment = Comments.fromJson(json.decode(response.body));
      _comments.add(newComment);
      notifyListeners();
    } else {
      throw Exception('Failed to add comment');
    }
  }
}
