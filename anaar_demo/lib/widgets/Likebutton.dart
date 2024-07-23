import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatelessWidget {
  final String postId;
  final List<Likes>? likes;
  final String? loggedinuser;
  LikeButton(
      {required this.postId, required this.likes, required this.loggedinuser});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostcardProvider>(
      builder: (ctx, postcardProvider, child) {
        bool isLiked = likes!.any((like) => like.userId == loggedinuser);

        return Row(
          children: [
            IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: likes!.any((like) => like.userId == loggedinuser)
                    ? Colors.red
                    : Colors.yellow,
              ),
              onPressed: () async {
                postcardProvider.likePost(postId, loggedinuser);
              },
            ),
            Text('${likes!.length ?? '0'}'),
          ],
        );
      },
    );
  }
}
