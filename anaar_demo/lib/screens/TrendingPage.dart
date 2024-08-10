import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/model/reseller_model.dart';
import 'package:anaar_demo/providers/TrendingProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/chatScreen.dart';
import 'package:anaar_demo/screens/commentsection.dart';
import 'package:anaar_demo/widgets/Likebutton.dart';
import 'package:anaar_demo/widgets/photGrid.dart';
import 'package:anaar_demo/widgets/profileTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Trendingpage extends StatefulWidget {
  @override
  State<Trendingpage> createState() => _TrendingpageState();
}

class _TrendingpageState extends State<Trendingpage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final trendingProvider = Provider.of<Trendingprovider>
      (context, listen: false);
      if (!trendingProvider.isLoaded) {
        trendingProvider.fetchPostcards();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
         await Provider.of<Trendingprovider>(context, listen: false).
         fetchPostcards();

        },
        child: Consumer<Trendingprovider>(
          builder: (context, trendprovider, child) {
            if (trendprovider.isLoading) {
              return Center(child: _buildShimmerLoading());
            } else if (trendprovider.postcards.isEmpty && !trendprovider.isLoading) {
              return Center(child: Text("No trending data this week"));
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
  String? loggedinuserid;

  @override
  void initState() {
    super.initState();
    getuserid();
  }

  void getuserid() async {
    loggedinuserid = await Helperfunction.getUserId();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Reseller?>(
      future: Provider.of<UserProvider>(context, listen: false)
          .fetchResellerinfo_post(widget.posttt.userid),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerLoading();
        } else if (userSnapshot.hasError || !userSnapshot.hasData) {
          print('Error: ${userSnapshot.error}');
          return SizedBox.shrink();
        } else {
          final userModel = userSnapshot.data!;
          return Card(
            color: Colors.white,
            margin: EdgeInsets.all(8.0),
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Profiletile(
                  usermodel: userModel,
                  Location: userModel.city ?? '',
                  ProfileName: userModel.businessName ?? '',
                  Imagepath: userModel.image ?? '',
                  loggedInUserId: loggedinuserid,
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
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => CommentScreen(
                              postcard: widget.posttt,
                              loggedinuserid: loggedinuserid,
                            )),
                        child: Text('Comments'),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => ChatScreen(
                              loggedInUserId: loggedinuserid ?? '',
                              postOwnerId: widget.posttt.userid ?? '',
                              reseller: userModel,
                            )),
                        child: Row(
                          children: [
                            Icon(Iconsax.message, color: Colors.blue),
                            SizedBox(width: 10),
                            Text(
                              "Chat",
                              style: TextStyle(color: Colors.blue, fontSize: 15),
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