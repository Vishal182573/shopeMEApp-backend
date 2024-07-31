import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/resellerShowProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Commenttile extends StatelessWidget {
  String userid;
  //final String ProfileName;
  final String Comment;
  final DateTime commentdate;
  Commenttile(
    this.userid, {
    required this.Comment,
    required this.commentdate,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<Usermodel?>(
        future: Provider.of<UserProvider>(context, listen: false)
            .fetchUserinfo(userid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            return Text("Failed to get userdata");
          } else {
            final usermodel = snapshot.data;
            return ListTile(
             // onTap: () => Get.to(() => ResellerShowprofile()),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(usermodel?.image ?? ''),
              ),
              title: Text(usermodel?.businessName ?? ''),
              subtitle: Row(
                children: [
                  Text(Comment),
                  SizedBox(width: 10),
                ],
              ),
              trailing: Text(DateFormat('d MMM y').format(commentdate)),
            );
          }
        });
  }
}
