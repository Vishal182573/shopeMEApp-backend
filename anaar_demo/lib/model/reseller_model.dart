// To parse this JSON data, do
//
//     final reseller = resellerFromJson(jsonString);

import 'dart:convert';

Reseller resellerFromJson(String str) => Reseller.fromJson(json.decode(str));

String resellerToJson(Reseller data) => json.encode(data.toJson());

class Reseller {
    String id;
    String ownerName;
    String businessName;
    String email;
    String password;
    String address;
    String contact;
    String city;
    String type;
    String image;
    List<String> connections;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Reseller({
        required this.id,
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
        required this.createdAt,
        required this.updatedAt,
        required this.v,
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
        connections: List<String>.from(json["connections"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
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
        "connections": List<dynamic>.from(connections.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
