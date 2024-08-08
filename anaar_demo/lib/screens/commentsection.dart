import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/widgets/commentTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/providers/commentProvider.dart';
//import 'package:anaar_demo/providers/postcard_provider.dart';

class CommentScreen extends StatefulWidget {
  final Postcard postcard;
  final String? loggedinuserid;

  CommentScreen({required this.postcard, required this.loggedinuserid});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  late List<Comments> _comments;

  @override
  void initState() {
    super.initState();
    _comments = List.from(widget.postcard.comments ?? []);
  }

  @override
  Widget build(BuildContext context) {
    final postcardProvider =
        Provider.of<PostcardProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body:
               
       Column(
        children: [
          Expanded(
            child: _comments.isEmpty
                ? Center(child: Text("No comments"))
                : ListView.builder(
                    itemCount: _comments.length,
                    itemBuilder: (ctx, index) {
                      final comment = _comments[index];
                      return Commenttile(
                     userid:    comment.userId ?? '',
                        Comment: comment.comment ?? '',
                        commentdate: DateTime.parse(comment.createdAt??''),
                        userType:comment.userType??'',
                      

                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    String? userId = widget.loggedinuserid;
                    if (_commentController.text.isNotEmpty) {
                      final newComment = Comments(
                        userId: userId,
                        comment: _commentController.text,
                        createdAt: DateTime.now().toString(),
                      );

                      // Update the local state
                      setState(() {
                        _comments.add(newComment);
                      });

                      // Update the provider state
                      await postcardProvider.addComment(
                          widget.postcard.sId!, newComment);

                      _commentController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
