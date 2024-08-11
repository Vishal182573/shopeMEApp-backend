// import 'package:anaar_demo/helperfunction/helperfunction.dart';
// import 'package:anaar_demo/model/postcard_model.dart';
// import 'package:anaar_demo/providers/postProvider.dart';
// import 'package:anaar_demo/providers/userProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LikeButton extends StatefulWidget {
//   final String postId;
//   final List<Likes>? likes;
//    String? loggedinuser;
//    bool? isLiked;
//   LikeButton(
//       {required this.postId, required this.likes, required this.loggedinuser,this.isLiked});

//   @override
//   State<LikeButton> createState() => _LikeButtonState();
// }

// class _LikeButtonState extends State<LikeButton> {
//  String? loginuse;
//  @override
//   void initState() {
//     // TODO: implement initState
//   }
//   void _loaduserid()async{
//          loginuse=await Helperfunction.getUserId();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PostcardProvider>(
//       builder: (ctx, postcardProvider, child) { 
//        final isLiked = widget.likes?.any((like) => like.userId == loginuse);
//   print("${widget.isLiked}...................post is liked......");
//         return Row(
//           children: [
//             IconButton(
//               icon: Icon(
//                 widget.isLiked==true ? Icons.favorite : Icons.favorite_border,
//                 color: widget.isLiked==true
//                     ? Colors.red
//                     : Colors.yellow,
//               ),
//               onPressed: () async {
//                 postcardProvider.likePost(widget.postId, widget.loggedinuser);
//               },
//             ),
//             Text('${widget.likes!.length ?? '0'}'),
//           ],
//         );
//       },
//     );
//   }
// // }












import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class LikeButton extends StatefulWidget {
//   final String postId;
//   final List<Likes>? likes;
//   LikeButton({required this.postId, required this.likes});

//   @override
//   State<LikeButton> createState() => _LikeButtonState();
// }

// class _LikeButtonState extends State<LikeButton> {
//   String? loggedinuser;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//   }

//   void _loadUserId() async {
//     loggedinuser = await Helperfunction.getUserId();
//     setState(() {}); // Update the state to reflect the loaded user ID
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PostcardProvider>(
//       builder: (ctx, postcardProvider, child) {
//         if (loggedinuser == null) {
//           return CircularProgressIndicator(); // Show a loading indicator while the user ID is being fetched
//         }

//         final isLiked = widget.likes?.any((like) => like.userId == loggedinuser) ?? false;
//         print("$isLiked ...................post is liked......");

//         return Row(
//           children: [
//             IconButton(
//               icon: Icon(
//                 isLiked ? Icons.favorite : Icons.favorite_border,
//                 color: isLiked ? Colors.red : Colors.yellow,
//               ),
//               onPressed: () async {
//                 await postcardProvider.likePost(widget.postId, loggedinuser!);
//                 // setState(() {
//                 //   // Toggle the isLiked state locally to reflect the change immediately
//                 //   if (isLiked) {
//                 //     widget.likes?.removeWhere((like) => like.userId == loggedinuser);
//                 //   } else {
//                 //     widget.likes?.add(Likes(userId: loggedinuser!));
//                 //   }
//                 // }
                
//                // );
//               },
//             ),
//             Text('${widget.likes?.length ?? '0'}'),
//           ],
//         );
//       },
//     );
//   }
// }

class LikeButton extends StatefulWidget {
  final String postId;
  final List<Likes>? likes;

  LikeButton({required this.postId, required this.likes});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  String? loggedInUserId;
  bool isLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    loggedInUserId = await Helperfunction.getUserId();

    // Ensure setState is only called if the widget is still mounted
    if (mounted) {
      setState(() {
        isLiked = widget.likes?.any((like) => like.userId == loggedInUserId) ?? false;
        likeCount = widget.likes?.length ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.yellow,
          ),
          onPressed: () async {
            // Optimistically update the UI
            setState(() {
              if (isLiked) {
                likeCount--;
              } else {
                likeCount++;
              }
              isLiked = !isLiked;
            });

            // Send like/unlike request to the server
            await Provider.of<PostcardProvider>(context, listen: false).likePost(widget.postId, loggedInUserId!);
          },
        ),
        Text('$likeCount'),
      ],
    );
  }

  @override
  void dispose() {
    // If there are any subscriptions or controllers, dispose of them here
    super.dispose();
  }
}