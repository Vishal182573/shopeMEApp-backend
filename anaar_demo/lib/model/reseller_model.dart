// To parse this JSON data, do
//
//     final reseller = resellerFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

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
  List<String?> connections;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? aboutUs;
  int?  catalogueCount;

  Reseller({
    this.catalogueCount,
     this.bgImage,
     this.id,
     this.aboutUs,
    required this.ownerName,
    required this.businessName,
    required this.email,
    required this.password,
    required this.address,
    required this.contact,
    required this.city,
    required this.type,
    required this.image,
    required this.connections,
     this.createdAt,
     this.updatedAt,
     this.v,
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
        connections: List<String>.from(json["connections"].map((x) => x)),
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
        "bgImage":bgImage,
        "aboutUs":aboutUs,
        "catalogueCount":catalogueCount,
        "connections": List<dynamic>.from(connections.map((x) => x)),
      
      };
}
