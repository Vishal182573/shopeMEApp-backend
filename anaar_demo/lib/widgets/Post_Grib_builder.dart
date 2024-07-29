import 'dart:math';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/screens/TrendingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Post_Grid extends StatefulWidget {
  String? userid;

  Post_Grid({this.userid});

  @override
  State<Post_Grid> createState() => _Post_GridState();
}

class _Post_GridState extends State<Post_Grid> {
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
    // TODO: i 
    //mplement build
    return FutureBuilder<List<Postcard>>(
        future: Provider.of<PostcardProvider>(context, listen: false)
            .getPostByuserId(widget.userid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Failed to get posts"),
            );
          } else {
            final postcardlist = snapshot.data!;
            final imageUrls = postcardlist
                .map((post) =>
                    post.images?.isNotEmpty == true ? post.images![0] : '')
                .toList();
            return GridView.builder(
              itemCount: postcardlist.length,
              itemBuilder: (context, index) => Container(
                height: 20,
                width: 20,
                color: Colors.amber,
                child: Stack(children: [
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: Image(
                        image: NetworkImage(imageUrls[index] ?? ''),
                        fit: BoxFit.fill,
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
