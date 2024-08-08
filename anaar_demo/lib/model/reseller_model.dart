// // To parse this JSON data, do
// //
// //     final reseller = resellerFromJson(jsonString);

// import 'dart:convert';

// import 'package:get/get.dart';
// //import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

// Reseller resellerFromJson(String str) => Reseller.fromJson(json.decode(str));

// String resellerToJson(Reseller data) => json.encode(data.toJson());

// class Reseller {
//   String? id;
//   String ownerName;
//   String businessName;
//   String email;
//   String password;
//   String address;
//   String contact;
//   String city;
//   String type;
//   String? image;
//   String? bgImage;
//   List<Connections>? connections;
//   String? createdAt;
//   String? updatedAt;
//   int? v;
//   String? aboutUs;
//   int?  catalogueCount;

//   Reseller({
//     this.catalogueCount,
//      this.bgImage,
//      this.id,
//      this.aboutUs,
//     required this.ownerName,
//     required this.businessName,
//     required this.email,
//     required this.password,
//     required this.address,
//     required this.contact,
//     required this.city,
//     required this.type,
//     required this.image,
//     required this.connections,
//      this.createdAt,
//      this.updatedAt,
//      this.v,
//   });

//   factory Reseller.fromJson(Map<String, dynamic> json) => Reseller(
//         id: json["_id"],
//         ownerName: json["ownerName"],
//         businessName: json["businessName"],
//         email: json["email"],
//         password: json["password"],
//         address: json["address"],
//         contact: json["contact"],
//         city: json["city"],
//         type: json["type"],
//         image: json["image"],
//         bgImage: json["bgImage"],
//         aboutUs: json["aboutUs"],
//         catalogueCount: json["catalogueCount"],
//         //connections: List<String>.from(json["connections"].map((x) => x)),
//       connections: 
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "ownerName": ownerName,
//         "businessName": businessName,
//         "email": email,
//         "password": password,
//         "address": address,
//         "contact": contact,
//         "city": city,
//         "type": type,
//         "image": image,
//         "bgImage":bgImage,
//         "aboutUs":aboutUs,
//         "catalogueCount":catalogueCount,
//        // "connections": List<dynamic>.from(connections.map((x) => x)),
//       "connections":connections!.map((v) => v.toJson()).toList(),

//       };
// }



// class Connections {
//   String? userId;
//   String? type;

//   Connections({this.userId, this.type});

//   Connections.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     type = json['Type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['Type'] = this.type;
//     return data;
//   }
// }

import 'dart:convert';

Reseller resellerFromJson(String str) => Reseller.fromJson(json.decode(str));

String resellerToJson(Reseller data) => json.encode(data.toJson());

class Reseller {
  String? id;
  String ownerName;
  String businessName;
  String email;
  String password;
  String address;
  String contact;
  String city;
  String type;
  String? image;
  String? bgImage;
  List<Connections>? connections;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? aboutUs;
  int? catalogueCount;

  Reseller({
    this.id,
    required this.ownerName,
    required this.businessName,
    required this.email,
    required this.password,
    required this.address,
    required this.contact,
    required this.city,
    required this.type,
    this.image,
    this.bgImage,
    this.connections,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.aboutUs,
    this.catalogueCount,
  });

  factory Reseller.fromJson(Map<String, dynamic> json) => Reseller(
        id: json["_id"],
        ownerName: json["ownerName"],
        businessName: json["businessName"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        contact: json["contact"],
        city: json["city"],
        type: json["type"],
        image: json["image"],
        bgImage: json["bgImage"],
        aboutUs: json["aboutUs"],
        catalogueCount: json["catalogueCount"],
        connections: json['connections'] != null
            ? List<Connections>.from(
                json["connections"].map((x) => Connections.fromJson(x)))
            : null,
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ownerName": ownerName,
        "businessName": businessName,
        "email": email,
        "password": password,
        "address": address,
        "contact": contact,
        "city": city,
        "type": type,
        "image": image,
        "bgImage": bgImage,
        "aboutUs": aboutUs,
        "catalogueCount": catalogueCount,
        "connections": connections != null
            ? List<dynamic>.from(connections!.map((x) => x.toJson()))
            : null,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class Connections {
  String? userId;
  String? type;

  Connections({this.userId, this.type});

  factory Connections.fromJson(Map<String, dynamic> json) => Connections(
        userId: json["userId"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "Type": type,
      };
}
