import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/resellerShowProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';



class Commenttile extends StatefulWidget {
  final String userid;
  final String Comment;
  final DateTime commentdate;
  final String? userType;

  Commenttile({
    required this.userid,
    this.userType,
    required this.Comment,
    required this.commentdate,
  });

  @override
  State<Commenttile> createState() => _CommenttileState();
}

class _CommenttileState extends State<Commenttile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usermodel?>(
      future: Provider.of<UserProvider>(context, listen: false)
          .fetchUserinfo(widget.userid, userType: widget.userType),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("Loading...");
          return buildShimmerList();
        } else if (snapshot.hasError) {
          return Text("Failed to get user data");
        } else {
          final usermodel = snapshot.data;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: usermodel?.image != ''
                  ? NetworkImage(usermodel?.image ?? '')
                  : AssetImage('assets/images/profileavtar.jpg') as ImageProvider,
            ),
            title: Text(usermodel?.businessName ?? ''),
            subtitle: Text(widget.Comment),
            trailing: Text(DateFormat('dd MMM y').format(widget.commentdate)),
          );
        }
      },
    );
  }

  Widget buildShimmerList() {
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
  }
}
