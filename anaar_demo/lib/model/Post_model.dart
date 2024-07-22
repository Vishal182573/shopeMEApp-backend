class Post {
  String? userid;
  String description;
  String category;
  String? userType;
  List<String> likes;
  List<String> comments;
  List<String?> images;

  Post({
    required this.userid,
    required this.description,
    required this.category,
    required this.likes,
    required this.comments,
    required this.images,
    this.userType
  });

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'description': description,
      'category': category,
      'likes': likes,
      'coents': comments,
      'images': images,
      'userType':userType,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userid: json['userid'],
      description: json['description'],
      category: json['category'],
      userType: json['userType'],
      likes: List<String>.from(json['likes']),
      comments: List<String>.from(json['comments']),
      images: List<String>.from(json['images']),
    );
  }
}

// class ImageUploadResponse {
//   final String url;

//   ImageUploadResponse({required this.url});

//   factory ImageUploadResponse.fromJson(Map<String, dynamic> json) {
//     return ImageUploadResponse(
//       url: json['url'],
//     );
//   }
// }
