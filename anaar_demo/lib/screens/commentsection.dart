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
    final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _comments = List.from(widget.postcard.comments ?? []);
  
  
  
     _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final postcardProvider = Provider.of<PostcardProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _comments.isEmpty
                ? Center(child: Text("No comments"))
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(indent: 25, endIndent: 25);
                    },
                    controller: _scrollController,
                    itemCount: _comments.length,
                    itemBuilder: (ctx, index) {
                      final comment = _comments[index];
                      return Commenttile(
                        userid: comment.userId ?? '',
                        Comment: comment.comment ?? '',
                        commentdate: DateTime.parse(comment.createdAt ?? ''),
                        userType: comment.userType ?? '',
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
                    focusNode: _focusNode,
                    controller: _commentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
                      try {
                         _commentController.clear();
                         _scrollToBottom();
                        await postcardProvider.addComment(widget.postcard.sId!, newComment);

                        setState(() {
                        
                          _comments = List.from(postcardProvider.postcards
                              .firstWhere((post) => post.sId == widget.postcard.sId)
                              .comments ?? []);
                        
                        });
                      } catch (error) {
                        print('Error adding comment: $error');
                      }
                       

                    //  _commentController.clear();
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


void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    _focusNode.dispose();
    Provider.of<PostcardProvider>(context, listen: false).dispose();
    super.dispose();
  }




}
