import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/TrendingProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/commentsection.dart';
import 'package:anaar_demo/widgets/Likebutton.dart';
import 'package:anaar_demo/widgets/photGrid.dart';
import 'package:anaar_demo/widgets/profileTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Trendingpage extends StatefulWidget {
  @override
  State<Trendingpage> createState() => _TrendingpageState();
}

class _TrendingpageState extends State<Trendingpage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Trendingprovider>(context, listen: false).fetchPostcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Trendingprovider>(
        builder: (context, trendprovider, child) {
          if (trendprovider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (trendprovider.postcards.isEmpty) {
            return Center(child: Text("No trending posts available"));
          } else {
            return ListView.builder(
              itemCount: trendprovider.postcards.length,
              itemBuilder: (context, index) {
                return PostCardWidget(
                  posttt: trendprovider.postcards[index],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PostCardWidget extends StatefulWidget {
  final Postcard posttt;
  PostCardWidget({required this.posttt});

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  var loggedinuserid;

  @override
  void initState() {
    super.initState();
    getuserid();
  }

  void getuserid() async {
    loggedinuserid = await Helperfunction.getUserId();
    setState(() {}); // Update the state once the user ID is fetched
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
            ),
            title: Container(
              color: Colors.white,
              height: 10.0,
              width: double.infinity,
            ),
            subtitle: Container(
              color: Colors.white,
              height: 10.0,
              width: double.infinity,
            ),
          ),
          Container(
            color: Colors.white,
            height: 150.0,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.white,
                  height: 10.0,
                  width: 50.0,
                ),
                Container(
                  color: Colors.white,
                  height: 10.0,
                  width: 50.0,
                ),
                Container(
                  color: Colors.white,
                  height: 10.0,
                  width: 50.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usermodel?>(
      future: Provider.of<UserProvider>(context, listen: false)
          .fetchUserinfo(widget.posttt.userid),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerLoading();
        } else if (userSnapshot.hasError || !userSnapshot.hasData) {
          print('Error: ${userSnapshot.error}');
          return SizedBox.shrink(); // Don't show anything if there's an error
        } else {
          final userModel = userSnapshot.data!;
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Profiletile(
                  Location: userModel.city ?? '',
                  ProfileName: userModel.businessName ?? '',
                  Imagepath: userModel.image ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.posttt.description ?? 'description',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 250,
                  child: PhotoGrid(
                    imageUrls: widget.posttt.images ?? [],
                    onImageClicked: (i) => print('Image $i was clicked!'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LikeButton(
                        postId: widget.posttt.sId!,
                        likes: widget.posttt.likes,
                        loggedinuser: loggedinuserid,
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => CommentScreen(
                              postcard: widget.posttt,
                              loggedinuserid: loggedinuserid,
                            )),
                        child: Text('Comments'),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => Container()),
                        child: Row(
                          children: [
                            Icon(Icons.chat, color: Colors.blue),
                            SizedBox(width: 10),
                            Text(
                              "Chat",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
