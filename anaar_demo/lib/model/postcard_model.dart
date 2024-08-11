// class Postcard {
//   String? sId;
//   String? userid;
//   String? description;
//   String? category;
//   List<String>? images;
//   List<Likes>? likes;
//   List<Comments>? comments;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   Postcard(
//       {this.sId,
//       this.userid,
//       this.description,
//       this.category,
//       this.images,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   Postcard.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userid = json['userid'];
//     description = json['description'];
//     category = json['category'];
//     images = json['images'].cast<String>();
//     likes = json['likes'].createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     if (json['likes'] != null) {
//       likes = <Likes>[];
//       json['likes'].forEach((v) {
//         likes!.add(new Likes.fromJson(v));
//       });
//     }
//     if (json['comments'] != null) {
//       comments = <Comments>[];
//       json['comments'].forEach((v) {
//         comments!.add(new Comments.fromJson(v));
//       });
//     }
//     iV = json['__v'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['userid'] = this.userid;
//     data['description'] = this.description;
//     data['category'] = this.category;
//     data['images'] = this.images;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;

//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class Likes {
//   String? userId;
//   String? createdAt;
//   String? sId;

//   Likes({this.userId, this.createdAt, this.sId});

//   Likes.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     createdAt = json['createdAt'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['createdAt'] = this.createdAt;
//     data['_id'] = this.sId;
//     return data;
//   }
// }

// class Comments {
//   String? userId;
//   String? comment;
//   String? createdAt;
//   String? sId;

//   Comments({this.userId, this.comment, this.createdAt, this.sId});

//   Comments.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     comment = json['comment'];
//     createdAt = json['createdAt'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['comment'] = this.comment;
//     data['createdAt'] = this.createdAt;
//     data['_id'] = this.sId;
//     return data;
//   }
// }
class Postcard {
  String? sId;
  String? userid;
  String? description;
  String? category;
  String? userType;
  List<String>? images;
  List<Likes>? likes;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Postcard({
    this.sId,
    this.userid,
    this.description,
    this.category,
    this.images,
    this.likes,
    this.userType,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Postcard.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userid = json['userid'];
    description = json['description'];
    category = json['category'];
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userType = json['userType'];
    iV = json['__v'];

    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }

    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userid'] = this.userid;
    data['description'] = this.description;
    data['category'] = this.category;
    data['images'] = this.images;
    data['userType'] = this.userType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;

    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }

    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }

    return data;
  }


@override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Postcard &&
          runtimeType == other.runtimeType &&
          sId == other.sId;

  @override
  int get hashCode => sId.hashCode;






}

class Likes {
  String? userId;
  String? createdAt;
  String? sId;

  Likes({this.userId, this.createdAt, this.sId});

  Likes.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    createdAt = json['createdAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    return data;
  }
}

class Comments {
  String? userId;
  String? comment;
  String? createdAt;
  String? userType;
  String? sId;

  Comments({this.userId, this.comment, this.createdAt, this.sId});

  Comments.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    userType=json['userType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = this.userId;
    data['comment'] = this.comment;
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    data['userType']=this.userType;
    return data;
  }
}
