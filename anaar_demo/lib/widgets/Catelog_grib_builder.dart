import 'dart:math';
import 'package:anaar_demo/model/catelogMode.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/providers/catelogProvider.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/screens/TrendingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Catelog_Grid extends StatefulWidget {
  String? userid;

  Catelog_Grid({this.userid});

  @override
  State<Catelog_Grid> createState() => _Post_GridState();
}

class _Post_GridState extends State<Catelog_Grid> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostcardProvider>(context, listen: false)
          .getPostByuserId(widget.userid);
    });
  }

  // final List<String> imageUrls;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<Catelogmodel>>(
        future: Provider.of<CatelogProvider>(context, listen: false)
            .getPostByuserId(widget.userid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error in fetching catelog"),
            );
          } else {
            final catelogcardlist = snapshot.data!;
            final imageUrls = catelogcardlist
                .map((post) =>
                    post.images?.isNotEmpty == true ? post.images![0] : '')
                .toList();
            return GridView.builder(
              itemCount: catelogcardlist.length,
              itemBuilder: (context, index) => Container(
                height: 20,
                width: 20,
                //color: Colors.amber,
                child: Stack(children: [
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: Image(
                        image: NetworkImage(imageUrls[index] ?? ''),
                        fit: BoxFit.cover,
                      ),
                      //color: Colors.blue,
                    ),
                  ),
                ]),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 1,
              ),
            );
          }
        });
  }
}
