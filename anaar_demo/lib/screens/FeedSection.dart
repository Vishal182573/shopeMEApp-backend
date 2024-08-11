// import 'package:anaar_demo/helperfunction/helperfunction.dart';
// import 'package:anaar_demo/model/postcard_model.dart';
// import 'package:anaar_demo/model/reseller_model.dart';
// import 'package:anaar_demo/model/userModel.dart';
// import 'package:anaar_demo/providers/postProvider.dart';
// import 'package:anaar_demo/providers/userProvider.dart';
// import 'package:anaar_demo/screens/chatScreen.dart';
// import 'package:anaar_demo/screens/commentsection.dart';
// import 'package:anaar_demo/widgets/Likebutton.dart';
// import 'package:anaar_demo/widgets/photGrid.dart';
// import 'package:anaar_demo/widgets/profileTile.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';

// class Feedsection extends StatefulWidget {
//     @override
//   _FeedsectionState createState() => _FeedsectionState();
// }

// class _FeedsectionState extends State<Feedsection> {
//   String? loggeduserid;
//   @override
//   void initState() {
    
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<PostcardProvider>(context, listen: false).fetchPostcards();
//     });
//     _loaduserid();
//   }

// void _loaduserid()async{
//   loggeduserid=await Helperfunction.getUserId();
// }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Consumer<PostcardProvider>(
// //         builder: (context, postcardProvider, child) {
// //           if (postcardProvider.isLoading) {
// //             return buildshimmer();
// //           } else if (postcardProvider.postcards.isEmpty) {
// //             return Center(child: Text("No posts available"));
// //           } else {
// //             return ListView.builder(
// //               itemCount: postcardProvider.postcards.length,
// //               itemBuilder: (context, index) {
// //                 return builpostCard(
// //                   postcar: postcardProvider.postcards[index],
// //                   logedinuserId: widget.loginuse,
// //                 );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

// @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return FutureBuilder(future: Provider.of<PostcardProvider>(context, listen: false).
//     fetchPostcards(),
//      builder: (context,snapshot){
//     if(snapshot.connectionState==ConnectionState.waiting){
//       return Center(child: CircularProgressIndicator(),);
//     }
//     else if(snapshot.hasError){
//           return Text("An occurred error!!");
//     }
//     else{
// return 
// Consumer<PostcardProvider>(
//         builder: (context, postcardProvider, child) {
//           if (postcardProvider.isLoading) {
//             return buildshimmer();
//           } else if (postcardProvider.postcards.isEmpty) {
//             return Center(child: Text("No posts available"));
//           } else {
//             return ListView.builder(
//               itemCount: postcardProvider.postcards.length,
//               itemBuilder: (context, index) {
//                 return builpostCard(
//                   postcar: postcardProvider.postcards[
//                     postcardProvider.postcards.length-index-1
                  
//                   ],
//                   logedinuserId: loggeduserid,
//                 );
//               },
//             );
//           }
//         },
//       );

//     }

//      });
//   }
// }


// class builpostCard extends StatefulWidget {
//   final Postcard postcar;
//   final String? logedinuserId;
//   builpostCard({required this.postcar, this.logedinuserId});

//   @override
//   State<builpostCard> createState() => _builpostCardState();
// }

// class _builpostCardState extends State<builpostCard> {
//   @override
//   Widget build(BuildContext context) {
//     final postCard = widget.postcar;

//     return FutureBuilder<Reseller?>(
//       future: Provider.of<UserProvider>(context, listen: false)
//           .fetchResellerinfo_post(postCard.userid),
//       builder: (context, userSnapshot) {
//         if (userSnapshot.connectionState == ConnectionState.waiting) {
//           return buildshimmer();
//         } else if (userSnapshot.hasError || !userSnapshot.hasData) {
//           print('Error: ${userSnapshot.error}');
//           return SizedBox.shrink(); // Don't show anything if there's an error
//         } else {
//           final userModel = userSnapshot.data!;
//           return Card(
//             color: Colors.white,
//             margin: EdgeInsets.all(8.0),
//             elevation: 10,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Profiletile(usermodel: userModel,
//                   Location: userModel.city ?? '',
//                   ProfileName: userModel.businessName ?? '',
//                   Imagepath: userModel.image ?? '',
//                   loggedInUserId: widget.logedinuserId,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     postCard.description ?? 'description',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//                   decoration: 
//                              BoxDecoration(color: const Color.fromARGB(255, 232, 232, 232)),       
//                   height: 250,
//                   child: Expanded(
//                     child: PhotoGrid(
//                       imageUrls: postCard.images ?? [],
//                       onImageClicked: (i) => print('Image $i was clicked!'),
                      
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       LikeButton(
//                         postId: postCard.sId!,
//                         likes: postCard.likes,
//                         // loggedinuser: widget.logedinuserId,
//                         // isLiked: (postCard.likes!.any((like) => like.userId == widget.logedinuserId))?true:false,

//                       ),
//                       TextButton(
//                         onPressed: () => Get.to(() => CommentScreen(
//                               postcard: postCard,
//                               loggedinuserid: widget.logedinuserId,
//                             )),
//                         child: Text('Comments'),
//                       ),
//                       TextButton(
//                         onPressed: () => Get.to(() => ChatScreen(loggedInUserId:widget.logedinuserId??''
//                         , postOwnerId: postCard.userid??'',reseller:userModel ,)),
//                         child: Row(
//                           children: [
//                             Icon(Icons.chat, color: Colors.blue),
//                             SizedBox(width: 10),
//                             Text(
//                               "Chat",
//                               style:
//                                   TextStyle(color: Colors.blue, fontSize: 15),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// class buildshimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.white,
//             ),
//             title: Container(
//               color: Colors.white,
//               height: 10.0,
//               width: double.infinity,
//             ),
//             subtitle: Container(
//               color: Colors.white,
//               height: 10.0,
//               width: double.infinity,
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             height: 150.0,
//             width: double.infinity,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   color: Colors.white,
//                   height: 10.0,
//                   width: 50.0,
//                 ),
//                 Container(
//                   color: Colors.white,
//                   height: 10.0,
//                   width: 50.0,
//                 ),
//                 Container(
//                   color: Colors.white,
//                   height: 10.0,
//                   width: 50.0,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/model/reseller_model.dart';
import 'package:anaar_demo/providers/TrendingProvider.dart';
import 'package:anaar_demo/providers/postProvider.dart';
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

// class Feedsection extends StatefulWidget {
//   @override
//   _FeedsectionState createState() => _FeedsectionState();
// }

// class _FeedsectionState extends State<Feedsection> {
//   String? loggeduserid;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final postProvider = Provider.of<PostcardProvider>(context, listen: false);
//       if (!postProvider.isLoaded) {
//         postProvider.fetchPostcards();
//       }
//     });
//     _loaduserid();
//   }

//   void _loaduserid() async {
//     loggeduserid = await Helperfunction.getUserId();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<PostcardProvider>(
//         builder: (context, postcardProvider, child) {
//           if (postcardProvider.isLoading) {
//             return buildShimmer();
//           } else if (postcardProvider.postcards.isEmpty) {
//             return Center(child: Text("No posts available"));
//           } else {
//             return ListView.builder(
//               itemCount: postcardProvider.postcards.length,
//               itemBuilder: (context, index) {
//                 return BuilpostCard(
//                   postcar: postcardProvider.postcards[postcardProvider.postcards.length - index - 1],
//                   logedinuserId: loggeduserid,
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Feedsection extends StatefulWidget {
  @override
  _FeedsectionState createState() => _FeedsectionState();
}

class _FeedsectionState extends State<Feedsection> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postcardProvider = Provider.of<PostcardProvider>(context, listen: false);
      if (!postcardProvider.isLoaded) {
        postcardProvider.fetchPostcards();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<PostcardProvider>(context, listen: false).fetchPostcards();
        },
        child: Consumer<PostcardProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: buildShimmer());
            } else if (provider.postcards.isEmpty && !provider.isLoading) {
              return Center(child: Text("No posts available"));
            } else {
              return ListView.builder(
                itemCount: provider.postcards.length,
                itemBuilder: (context, index) {
                  return BuilpostCard(
                    key: ValueKey(provider.postcards[provider.postcards.length - index - 1].sId),
                    postcar: provider.postcards[provider.postcards.length - index - 1]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

// class BuilpostCard extends StatefulWidget {
//   final Postcard postcar;

//   BuilpostCard({required this.postcar});

//   @override
//   State<BuilpostCard> createState() => _BuilpostCardState();
// }

// class _BuilpostCardState extends State<BuilpostCard> {
//   String? logedinuserId;

//   @override
//   void initState() {
//     super.initState();
//     getuserid();
//   }

//   void getuserid() async {
//     logedinuserId = await Helperfunction.getUserId();
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Reseller?>(
//       future: Provider.of<UserProvider>(context, listen: false).
//       fetchResellerinfo_post( widget.postcar.userid),
//       builder: (context, userSnapshot) {
//         if (userSnapshot.connectionState == ConnectionState.waiting) {
//           return buildShimmer();
//         } else if (userSnapshot.hasError || !userSnapshot.hasData) {
//           return SizedBox.shrink();
//         } else {
//           final userModel = userSnapshot.data!;
//           return Card(
//             color: Colors.white,
//             margin: EdgeInsets.all(8.0),
//             elevation: 10,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Profiletile(
//                   usermodel: userModel,
//                   Location: userModel.city ?? '',
//                   ProfileName: userModel.businessName ?? '',
//                   Imagepath: userModel.image ?? '',
//                   loggedInUserId: logedinuserId,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     widget.postcar.description ?? 'description',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//                   decoration: BoxDecoration(color: const Color.fromARGB(255, 232, 232, 232)),
//                   height: 250,
//                   child: PhotoGrid(
//                     imageUrls: widget.postcar.images ?? [],
//                     onImageClicked: (i) => print('Image $i was clicked!'),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       LikeButton(
//                         postId: widget.postcar.sId!,
//                         likes: widget.postcar.likes,
//                       ),
//                       TextButton(
//                         onPressed: () => Get.to(() => CommentScreen(
//                               postcard: widget.postcar,
//                               loggedinuserid: logedinuserId,
//                             )),
//                         iconAlignment: IconAlignment.start, 
//                         child: Text('Comments'),
//                       ),
//                       TextButton(
//                         onPressed: () => Get.to(() => ChatScreen(
//                               loggedInUserId: logedinuserId ?? '',
//                               postOwnerId: widget.postcar.userid ?? '',
//                               reseller: userModel,
//                             )),
//                         child: Row(
//                           children: [
//                             Icon(Iconsax.message, color: Colors.blue),
//                             SizedBox(width: 10),
//                             Text(
//                               "Chat",
//                               style: TextStyle(color: Colors.blue, fontSize: 15),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
// }


class BuilpostCard extends StatefulWidget {
  final Postcard postcar;

  BuilpostCard({required this.postcar, Key? key}) : super(key: key);

  @override
  State<BuilpostCard> createState() => _BuilpostCardState();
}

class _BuilpostCardState extends State<BuilpostCard> {




  String? logedinuserId;

  @override
  void initState() {
    super.initState();
    getuserid();
  }

  void getuserid() async {
    logedinuserId = await Helperfunction.getUserId();
    if (mounted) {
      setState(() {});
    }
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<PostcardProvider>(
      builder: (context, provider, child) {
        final updatedPost = provider.postcards.firstWhere(
          (post) => post.sId == widget.postcar.sId,
          orElse: () => widget.postcar,
        );

        return FutureBuilder<Reseller?>(
          future: Provider.of<UserProvider>(context, listen: false)
              .fetchResellerinfo_post(updatedPost.userid),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return buildShimmer();
            } else if (userSnapshot.hasError || !userSnapshot.hasData) {
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
                      loggedInUserId: logedinuserId,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        updatedPost.description ?? 'description',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 232, 232, 232)),
                      height: 250,
                      child: PhotoGrid(
                        imageUrls: updatedPost.images ?? [],
                        onImageClicked: (i) => print('Image $i was clicked!'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LikeButton(
                            postId: updatedPost.sId!,
                            likes: updatedPost.likes,
                            //post: updatedPost,
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => CommentScreen(
                              postcard: updatedPost,
                              loggedinuserid: logedinuserId,
                            )),
                            iconAlignment: IconAlignment.start, 
                            child: Text('Comments'),
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => ChatScreen(
                              loggedInUserId: logedinuserId ?? '',
                              postOwnerId: updatedPost.userid ?? '',
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
      },
    );
  }
}

class buildShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
