import 'dart:convert';

import 'package:provider/provider.dart';

class ConsumerModel {
  final String? id;
  final String? name;
  final String? businessName;
  final String? city;
  final String? email;
  final String? contact;
  final String? image; 
  final String? type;
  String? bio;
    List<String?> connections;

  ConsumerModel({
    required this.id,
    required this.name,
    required this.businessName,
    required this.city,
    required this.email,
    required this.contact,
    required this.image,
    required this.type,
    required this.connections,
    this.bio
  });

  factory ConsumerModel.fromJson(Map<String, dynamic> json) {
    return ConsumerModel(
      bio: json['bio']??'',
      id: json['_id'],
      name: json['ownername'] ?? json['name'],
      businessName: json['businessname'] ?? '',
      city: json['city'],
      email: json['email'],
      contact: json['contact'],
      image: json['image'] ?? '',
      type: json['type'],
       connections: List<String>.from(json["connections"].map((x) => x))
    );
  }
}
