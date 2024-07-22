import 'package:anaar_demo/providers/commonuserdataprovider.dart';
import 'package:anaar_demo/screens/requiremnetPage/requirementPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/chatScreen.dart';
import 'package:anaar_demo/screens/commentsection.dart';
import 'package:anaar_demo/screens/requirement_page.dart';
import 'package:anaar_demo/widgets/Likebutton.dart';
import 'package:anaar_demo/widgets/photGrid.dart';
import 'package:anaar_demo/widgets/profileTile.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? logedinuserId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostcardProvider>(context, listen: false).fetchPostcards();
    });
    getuser();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void getuser() async {
    logedinuserId = await Helperfunction.getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ShopME',
          style: TextStyle(
              color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Feed'),
            Tab(text: 'Requirements'),
            Tab(text: 'Trending'),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildRequirementsTab(),
          _buildTrendingTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => RequirementPostScreen()),
        label: Text(
          "Add Requirement",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFeedTab() {
    return Consumer<PostcardProvider>(
      builder: (ctx, postcardProvider, _) {
        if (postcardProvider.isLoading) {
          return _buildShimmerLoading();
        } else if (postcardProvider.postcards.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          return ListView.builder(
            itemCount: postcardProvider.postcards.length,
            itemBuilder: (context, index) {
              return _buildPostCard(postcardProvider.postcards[index]);
            },
          );
        }
      },
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
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
          ),
        );
      },
    );
  }

  Widget _buildRequirementsTab() {
    return RequirementsPage();
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Trending",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Expanded(child: Divider()),
            ],
          ),
          Consumer<PostcardProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return _buildShimmerLoading();
              }
              return Column(
                children: provider.postcards
                    .map((postCard) => _buildPostCard(postCard))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Postcard postCard) {
    return FutureBuilder(
      future: Provider.of<CommenUserProvider>(context, listen: false).fetchUserData(postCard.userid,),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerLoading();
        } else if (userSnapshot.error != null) {
          print('Error: ${userSnapshot.error}');
          return Center(child: Text('An error occurred in fetching userdetail!'));
        } else {
          return Consumer<UserProvider>(builder: (ctx, userProvider, child) {
            if (userProvider.reseller == null) {
              return Center(child: Text('No user data available'));
            } else {
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 10,
                borderOnForeground: true,
                shadowColor: Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Profiletile(
                      Location: userProvider.reseller!.city,
                      ProfileName: userProvider.reseller!.businessName,
                      Imagepath: userProvider.reseller!.image,
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
                            onPressed: () => Get.to(() => ChatScreen(recipientId: postCard.userid)),
                            child: Row(
                              children: [
                                Icon(Icons.chat, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  "Chat",
                                  style: TextStyle(color: Colors.white, fontSize: 15),
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
          });
        }
      },
    );
  }
}
