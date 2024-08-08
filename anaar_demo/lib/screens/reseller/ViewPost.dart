import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/model/reseller_model.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/commentsection.dart';
import 'package:anaar_demo/widgets/Likebutton.dart';
import 'package:anaar_demo/widgets/photGrid.dart';
import 'package:anaar_demo/widgets/profileTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class Viewpost extends StatefulWidget{
  final Postcard postcard;
 // String? loggedInUserId;
UserProvider? userProvider;
Reseller? userprofile;

  Viewpost({
     this.userProvider,
      required this.postcard,
     // this.loggedInUserId,
      this.userprofile

  });

  @override
  State<Viewpost> createState() => _ViewpostState();
}

class _ViewpostState extends State<Viewpost> {
  var loggedinuserid;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  _loggedinuserid();
  }

void _loggedinuserid()async{
 loggedinuserid=await Helperfunction.getUserId();

}

@override
  Widget build(BuildContext context) {
    // TODO: implement build
  var postcardProvider= Provider.of<PostcardProvider>(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(backgroundColor: Colors.red,
          title: Text("Post",style: TextStyle(color: Colors.white),),
          foregroundColor: Colors.white,
          ),
          body: Container(height: MediaQuery.of(context).size.height/1.7,
            child: Card(shadowColor: Colors.grey,
                  margin: EdgeInsets.all(8.0),
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                //  onTap: () => Get.to(() => ResellerShowprofile(usermodel: usermodel)),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.userProvider?.reseller?.image??widget.userprofile?.image??''),
            ),
            title: Text(widget.userProvider?.reseller?.businessName??widget.userprofile?.businessName??''),
            subtitle: Row(
              children: [
                Text('Manufacturers'),
                SizedBox(width: 10),
                Text(widget.userProvider?.reseller?.city??widget.userprofile?.city??''),
              ],
            ),
        
            trailing: 
            widget.userprofile?.id==loggedinuserid?
            TextButton(
              onPressed: ()=>
               showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Delet'),
              content: const Text('Do you want to Delet this post?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: ()async {
                     Navigator.pop(context, 'ok');
                    bool val= await postcardProvider.deletePost(widget.postcard!.sId??'');
                  if(val){
                      Navigator.of(context).pop();
                  }
                  
                  },
                  child: const Text('OK'),
                )
                ,
              ],
            ),
          )
              
              ,
              child: Text("Delete",style: TextStyle(color: Colors.red,fontSize: 15),)):null,
                ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                         widget.postcard.description ?? 'description',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 250,
                        child: PhotoGrid(
                          imageUrls: widget.postcard.images ?? [],
                          onImageClicked: (i) => print('Image $i was clicked!'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LikeButton(
                              postId: widget.postcard.sId!,
                              likes: widget.postcard.likes,
                             // loggedinuser: widget.loggedInUserId,
                            ),
                            TextButton(
                              onPressed: () => Get.to(() => CommentScreen(
                                    postcard: widget.postcard,
                                    loggedinuserid: loggedinuserid,
                                  )),
                              child: Text('Comments'),
                            ),
            
                        
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          )
        
        
        ),

//................................. loading .....................

if (postcardProvider.isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (postcardProvider.isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),



      ],
    );
  }
}