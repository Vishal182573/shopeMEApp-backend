// To parse this JSON data, do
//
//     final Usermodel = UsermodelFromJson(jsonString);

import 'dart:convert';

Usermodel UsermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String UsermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {

    String? id;
    //String? ownerName;
    String? businessName;
  //  String? email;
  //  String? password;
   // String? address;
 //   String? contact;
     String? type;
    String? bgImage;
    String? city;
   
    String? image;
    // List<String?> connections;
    List<Connections>? connections;
   // DateTime createdAt;
   // DateTime updatedAt;
    int? v;

    Usermodel({
      this.type,
      this.bgImage,
        required this.id,
       // required this.ownerName,
        required this.businessName,
        //required this.email,
        //required this.password,
        //required this.address,
        //required this.contact,
         this.city,
      
         this.image,
        required this.connections,
        //required this.createdAt,
        ///required this.updatedAt,
         this.v,
    });

    factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        id: json["_id"],
       // ownerName: json["ownerName"]??'',
        businessName: json["businessName"]??json['name'],
        //email: json["email"]??'',
        //password: json["password"]??'',
        //address: json["address"]??'',
        //contact: json["contact"]??'',
        bgImage: json["bgImage"]??'',
        city: json["city"]??'',
        type: json["type"]??'',
        image: json["image"]??'',
      //  type:json['type']??'',
        //connections: List<String>.from(json["connections"].map((x) => x))??[],
        //createdAt: DateTime.parse(json["createdAt"]),
        //updatedAt: DateTime.parse(json["updatedAt"]),
        connections: json['connections'] != null
            ? List<Connections>.from(
                json["connections"].map((x) => Connections.fromJson(x)))
            : null,
        
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
      //  "ownerName": ownerName,
        "businessName": businessName,
        "type":type,
       // "email": email,
        //"password": password,
        //"address": address,
        //"contact": contact,
        "city": city,
      
        "image": image,
        //"connections": List<dynamic>.from(connections.map((x) => x)),
        //"createdAt": createdAt.toIso8601String(),
        //"updatedAt": updatedAt.toIso8601String(),
         "connections": connections != null
            ? List<dynamic>.from(connections!.map((x) => x.toJson()))
            : null,
        "__v": v,
        "bgImage":bgImage,
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