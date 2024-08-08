import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/resellerShowProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Commenttile extends StatelessWidget {
  String userid;
  //final String ProfileName;
  final String Comment;
  final DateTime commentdate;
  String? userType;
  Commenttile(
    {required this.userid, 
     this.userType,
    required this.Comment,
    required this.commentdate,
  });

  @override
  Widget build(BuildContext context) {
    print(userType);
    // TODO: implement build
    return FutureBuilder<Usermodel?>(
        future: Provider.of<UserProvider>(context, listen: false)
            .fetchUserinfo(userid,userType: userType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildShimmerList();
          } else if (snapshot.hasError) {
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


Widget buildShimmerList() {
    return ListView.builder(
      itemCount: 5,  // Number of shimmer items to show
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
            ),
            title: Container(
              height: 10,
              width: double.infinity,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 10,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }










}
