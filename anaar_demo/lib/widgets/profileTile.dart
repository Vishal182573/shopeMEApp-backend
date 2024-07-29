import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/screens/resellerShowProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profiletile extends StatelessWidget {
  final String ProfileName;
  final String Location;
  final String Imagepath;
  Usermodel usermodel;
  Profiletile(
      {required this.Location,
      required this.ProfileName,
      required this.Imagepath,
     required this.usermodel
      
      });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      onTap: () => Get.to(() => ResellerShowprofile(usermodel: usermodel,)),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(Imagepath),
      ),
      title: Text(ProfileName),
      subtitle: Row(
        children: [
          Text('Manufacturers'),
          SizedBox(width: 10),
          Text(Location),
        ],
      ),
      trailing: TextButton(
        onPressed: () {},
        child:
            Text('Connect', style: TextStyle(color: Colors.blue, fontSize: 18)),
      ),
    );
  }
}
