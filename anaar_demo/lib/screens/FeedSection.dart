import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/commentsection.dart';
import 'package:anaar_demo/widgets/Likebutton.dart';
import 'package:anaar_demo/widgets/photGrid.dart';
import 'package:anaar_demo/widgets/profileTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Feedsection extends StatefulWidget {
  final String? loginuse;
  Feedsection({required this.loginuse});

  @override
  _FeedsectionState createState() => _FeedsectionState();
}

class _FeedsectionState extends State<Feedsection> {
  @override
  void initState() {
    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostcardProvider>(context, listen: false).fetchPostcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostcardProvider>(
        builder: (context, postcardProvider, child) {
          if (postcardProvider.isLoading) {
            return buildshimmer();
          } else if (postcardProvider.postcards.isEmpty) {
            return Center(child: Text("No posts available"));
          } else {
            return ListView.builder(
              itemCount: postcardProvider.postcards.length,
              itemBuilder: (context, index) {
                return builpostCard(
                  postcar: postcardProvider.postcards[index],
                  logedinuserId: widget.loginuse,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class builpostCard extends StatelessWidget {
  final Postcard postcar;
  final String? logedinuserId;
  builpostCard({required this.postcar, this.logedinuserId});

  @override
  Widget build(BuildContext context) {
    final postCard = postcar;

    return FutureBuilder<Usermodel?>(
      future: Provider.of<UserProvider>(context, listen: false)
          .fetchUserinfo(postCard.userid),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return buildshimmer();
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
                    postCard.description ?? 'description',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 250,
                  child: PhotoGrid(
                    imageUrls: postCard.images ?? [],
                    onImageClicked: (i) => print('Image $i was clicked!'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LikeButton(
                        postId: postCard.sId!,
                        likes: postCard.likes,
                        loggedinuser: logedinuserId,
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => CommentScreen(
                              postcard: postCard,
                              loggedinuserid: logedinuserId,
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

class buildshimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
}
