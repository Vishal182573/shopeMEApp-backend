import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/resellerShowProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Profiletile extends StatelessWidget {
  final String ProfileName;
  final String Location;
  final String Imagepath;
  final Usermodel usermodel;
  final String? loggedInUserId;

  Profiletile({
    required this.Location,
    required this.ProfileName,
    required this.Imagepath,
    required this.usermodel,
    required this.loggedInUserId,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final bool isConnected = userProvider.connections.contains(usermodel.id);
    final bool isSameUser = loggedInUserId == usermodel.id;

    return ListTile(
      style: ListTileStyle.drawer,
      //style: ListTileStyle.list,
      onTap: () => Get.to(() => ResellerShowprofile(usermodel: usermodel)),
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
      trailing: isSameUser
          ? null
          : TextButton(
              onPressed: () async {
                if (!isConnected) {
                  print(" connected function hitted.......................");
                  await userProvider.connectUser(loggedInUserId, usermodel.id,usermodel.type);
                }
              },
              child: Text(
                isConnected ? 'Connected' : 'Connect',
                style: TextStyle(
                  color: isConnected ? Colors.red : Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
    );
  }
}
