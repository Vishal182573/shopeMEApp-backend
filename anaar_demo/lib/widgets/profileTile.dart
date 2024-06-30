import 'package:anaar_demo/screens/userProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profiletile extends StatelessWidget {
  final String ProfileName;
  final String Location;
  final String Imagepath;
  Profiletile(
      {required this.Location,
      required this.ProfileName,
      required this.Imagepath});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      onTap: () => Get.to(() => ResellerProfilePage()),
      leading: CircleAvatar(
        backgroundImage: AssetImage(Imagepath),
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
