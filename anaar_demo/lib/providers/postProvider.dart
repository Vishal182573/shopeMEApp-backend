import 'dart:ui';

import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/Post_model.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  Future<void> uploadPost(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = 'https://shopemeapp-backend.onrender.com/api/post/upload';
  
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode(post.toJson()),
    );
    _isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      _posts.add(post);
      print("successfully uploaded post");
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to upload post');
    }
  }

  Future<void> uploadPostWithImages(Post post, List<File> images) async {
    try {
  _isLoading = true;
    notifyListeners();
      
      List<String?> imageUrls = [];
      for (var image in images) {
        String? imageUrl = await Helperfunction.uploadImage(image);

        imageUrls.add(imageUrl);
      }
      post.images = imageUrls;
      print(imageUrls[0]);
      await uploadPost(post);
    } catch (error) {
        _isLoading = false;
    notifyListeners();
      throw error;
    }
  }







}

////................................getting post data homepage......................
///
///

class PostcardService {
  static const String url =
      'https://shopemeapp-backend.onrender.com/api/post/getAllPost';

  static Future<List<Postcard>> fetchPostcards() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
   
    print(token);
    print('badmosshiiiiiiiiii.............');
    final response = await http.get(
      Uri.parse('$url'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("..................Got the postcard data successfully.........");
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

class PostcardProvider with ChangeNotifier {
  List<Postcard> _postcards = [];
  List<Postcard> _postcards1 = [];
  
  List<Postcard> get postcards => _postcards;
  bool _isLoading = false;
  bool _isLoaded=false;
   bool get isLoaded => _isLoaded;

  List<Postcard> get postcards1 => _postcards1;
  bool get isLoading => _isLoading;

  Future<void> fetchPostcards() async {
    try {
      _isLoading=true;
         notifyListeners();
      _postcards = await PostcardService.fetchPostcards();
    //  _postcards1=_postcards;
      
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

//....................for posting likes............................


  // void _optimisticallyToggleLike(String postId, String? userId) {
  //   final postIndex = _postcards.indexWhere((post) => post.sId == postId);
  //   if (postIndex != -1) {
  //     final post = _postcards[postIndex];
  //     if (post.likes!.any((like) => like.userId == userId)) {
  //       post.likes!.removeWhere((like) => like.userId == userId);
  //     } else {
  //       post.likes!.add(Likes(userId: userId));
  //     }
  //     notifyListeners();
  //   }
  // }

  // Future<void> likePost(String? postId, String? userId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');

  //   _optimisticallyToggleLike(postId!, userId);

  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://shopemeapp-backend.onrender.com/api/post/like'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json'
  //       },
  //       body: json.encode({
  //         'postid': postId,
  //         'userid': userId,
  //         'userType': 'reseller'
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       print(
  //           ".................................liked successsfully...........");
  //     }

  //     if (response.statusCode != 200) {
  //       _optimisticallyToggleLike(postId, userId); // Revert on failure
  //     }
  //   } catch (error) {
  //     _optimisticallyToggleLike(postId, userId); // Revert on failure
  //     throw (error);
  //   }
  // }

//  void _optimisticallyToggleLike(String postId, String userId) {
//     final postIndex = _postcards.indexWhere((post) => post.sId == postId);
//     if (postIndex != -1) {
//       final post = _postcards[postIndex];
//       if (post.likes!.any((like) => like.userId == userId)) {
//         post.likes!.removeWhere((like) => like.userId == userId);
//       } else {
//         post.likes!.add(Likes(userId: userId));
//       }
//       notifyListeners();
//     }
//   }

//   Future<void> likePost(String postId, String userId,Postcard post) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     final userType = prefs.getString('userType');

//     // Optimistically update the local state
//     _optimisticallyToggleLike(postId, userId);

//     try {
//       final response = await http.post(
//         Uri.parse('https://shopemeapp-backend.onrender.com/api/post/like'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'postid': postId,
//           'userid': userId,
//           'userType': userType,
//         }),
//       );

//       if (response.statusCode != 200) {
//         // Revert on failure
//         _optimisticallyToggleLike(postId, userId);
//       }
//     } catch (error) {
//       // Revert on failure
//       _optimisticallyToggleLike(postId, userId);
//       throw error;
//     }
//   }






 void _optimisticallyToggleLike(String postId, String userId) {
    final postIndex = _postcards.indexWhere((post) => post.sId == postId);
    if (postIndex != -1) {
      final post = _postcards[postIndex];
      if (post.likes!.any((like) => like.userId == userId)) {
        post.likes!.removeWhere((like) => like.userId == userId);
      } else {
        post.likes!.add(Likes(userId: userId));
      }
      notifyListeners();
    }
  }

  Future<void> likePost(String postId, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userType = prefs.getString('userType');

    // Optimistically update the local state
    //_optimisticallyToggleLike(postId, userId);

    try {
      final response = await http.post(
        Uri.parse('https://shopemeapp-backend.onrender.com/api/post/like'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'postid': postId,
          'userid': userId,
          'userType': userType,
        }),
      );

      if (response.statusCode == 200) {
        // Optionally update the post from the server if needed
        // final updatedPost = await fetchPostcardById(postId);
        // updatePostcard(updatedPost);

        print('successfully Liked this post........');
      } else {
        // Revert on failure
        _optimisticallyToggleLike(postId, userId);
      }
    } catch (error) {
      // Revert on failure
      _optimisticallyToggleLike(postId, userId);
      throw error;
    }
  }





///////...........................for adding comments...........................

  Future<void> addComment(String? postId, Comments newComment) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userType=prefs.getString('userType');
    try {
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
          'userType':userType
        }),
      );

      if (response.statusCode == 200) {
//final index = _postcards.indexWhere((post) => post.sId == postId);
        print("successfully comment added...................");
        final newComment = Comments.fromJson(json.decode(response.body));
        final postIndex = _postcards.indexWhere((post) => post.sId == postId);

        if (postIndex != -1) {
          _postcards[postIndex].comments?.add(newComment);
          notifyListeners();
        }
      } else {
        print("${response.statusCode}...${response.body}");
      }
    } catch (error) {
      throw (error);
    }
  }

// //..................................get post by userID....................

  Future<List<Postcard>> getPostByuserId(String? userid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('${userid}..................yaha fetch function me aya hai');

    try {
      final url =
          'https://shopemeapp-backend.onrender.com/api/post/getPostByUserId?userId=$userid';
      final response = await http.get(
        Uri.parse('$url'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print("..................Got the postcard for the user..........");
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((postcard) => Postcard.fromJson(postcard))
            .toList();
      } else {
        print('${response.body}');
        throw Exception('Failed to load postcards');
      }
    } catch (error) {
      throw (error);
    }
  }


 Future<bool> deletePost(String postId) async {
   final prefs = await SharedPreferences.getInstance();

   _isLoading=true;
    notifyListeners();
    final token = prefs.getString('token');
    final url = 'https://shopemeapp-backend.onrender.com/api/post/deletePost?postId=$postId';
    final response = await http.get(Uri.parse(url),
                  headers: {
          'Authorization': 'Bearer $token',
        },
    );

     _isLoading=false;
    notifyListeners(); 

    if (response.statusCode == 200) {
      _postcards.removeWhere((post) => post.sId == postId);
      notifyListeners();
         print("...........Deleted post successfully...............");
          return true;

    } else {
      print(response.body);
      print('................Failed to delete post');
       return false;
    }
  }



}



///..................................Getx controller for likessss..........................
///
///


// lib/controllers/post_controller.dart

class PostController extends GetxController {
  var posts = <Postcard>[].obs;

  void setPosts(List<Postcard> postList) {
    posts.assignAll(postList);
  }

  void _optimisticallyToggleLike(String postId, String? userId) {
    final postIndex = posts.indexWhere((post) => post.sId == postId);
    if (postIndex != -1) {
      final post = posts[postIndex];
      if (post.likes!.any((like) => like.userId == userId)) {
        post.likes!.removeWhere((like) => like.userId == userId);
      } else {
        post.likes!.add(Likes(userId: userId));
      }
      posts[postIndex] = post; // Update the list to trigger the observer
    }
  }

  Future<void> likePost(String postId, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    _optimisticallyToggleLike(postId, userId);

    try {
      final response = await http.post(
        Uri.parse('https://shopemeapp-backend.onrender.com/api/post/like'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'postid': postId,
          'userid': userId,
          'userType': 'reseller'
        }),
      );

      if (response.statusCode != 200) {
        _optimisticallyToggleLike(postId, userId); // Revert on failure
      }
    } catch (error) {
      _optimisticallyToggleLike(postId, userId); // Revert on failure
      throw (error);
    }
  }
}