import 'dart:convert';

import 'package:anaar_demo/model/Requirement_model.dart';
import 'package:provider/provider.dart';

class ConsumerModel {
   String? id;
  final String? name;
  final String? businessName;
  final String? city;
  final String? email;
  final String? contact;
   String? image; 
  final String? type;
  //final String? password;
  String? bio;
 //   List<String?> connections;
List<Connections>? connections;
  ConsumerModel({
   // required this.password,
     this.id,
    required this.name,
    required this.businessName,
    required this.city,
    required this.email,
    required this.contact,
    required this.image,
    required this.type,
   required   this.connections,
    this.bio
  });

  factory ConsumerModel.fromJson(Map<String, dynamic> json) {
    return ConsumerModel(
      //password: json['password']??'',
      bio: json['bio']??'',
      id: json['_id'],
      name: json['ownername'] ?? json['name'],
      businessName: json['businessname'] ?? '',
      city: json['city'],
      email: json['email'],
      contact: json['contact'],
      image: json['image'] ?? '',
      type: json['type'],
     //  connections: List<String>.from(json["connections"].map((x) => x))
   connections: json['connections'] != null
            ? List<Connections>.from(
                json["connections"].map((x) => Connections.fromJson(x)))
            : null,
   
    );
  }

Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        //"businessName": businessName,
        "email": email,
       // "password": password,
  
        "contact": contact,
        "city": city,
        "type": type,
        "image": image,
        "bio":bio,
       
      //  "connections": List<dynamic>.from(connections.map((x) => x)),
       "connections": connections != null
            ? List<dynamic>.from(connections!.map((x) => x.toJson()))
            : null,


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
