import 'package:anaar_demo/model/reseller_model.dart';
import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/screens/chatScreen.dart';
import 'package:anaar_demo/widgets/Catelog_grib_builder.dart';
import 'package:anaar_demo/widgets/Post_Grib_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResellerShowprofile extends StatefulWidget {

Reseller? usermodel;
String? loggedInUserId;
ResellerShowprofile({required this.usermodel,this.loggedInUserId});

  @override
  State<ResellerShowprofile> createState() => _ResellerShowprofileState();
}

class _ResellerShowprofileState extends State<ResellerShowprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildProfileInfo(),
              _buildStatistics(),
              _buildAboutSection(),
              _buildActionButtons(),
              _buildTabBar(),
              //_buildProductGrid(),
            ],
          ),
          Positioned(
            top: 140,
            left: 140,
            child: CircleAvatar(
              radius: 53,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 50,
               // backgroundColor: Colors.yellow[200],
               backgroundImage: NetworkImage(widget.usermodel?.image??'',),
                // child: Text('RV',
                //     style: TextStyle(fontSize: 30, color: Colors.black)),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child:Image.network(widget.usermodel?.bgImage??"",fit: BoxFit.cover,)
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: EdgeInsets.only(top: 60, bottom: 20),
      child: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.usermodel?.businessName??'',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Manufacturers . ${widget.usermodel?.city}', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Product details: ${widget.usermodel?.catalogueCount}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 20),
          Text('Connections: ${widget.usermodel?.connections?.length}', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
              "${widget.usermodel?.aboutUs}",maxLines: 3,overflow: TextOverflow.ellipsis,),
         
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final bool isSameUser = widget.loggedInUserId ==widget.usermodel?.id;
   
   final Listofconnection=widget.usermodel?.connections;
   final bool isConnected=Listofconnection?.any((connections)=>connections.userId==widget.loggedInUserId)??false;
    //bool isConnected=Listofconnection?.
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      // isSameUser
      //     ? null
      //     : TextButton(
      //         onPressed: () async {
      //           if (!isConnected) {
      //             print(" connected function hitted.......................");
      //             await userProvider.connectUser(loggedInUserId, usermodel.id,usermodel.type);
      //           }
      //         },
      //         child: Text(
      //           isConnected ? 'Connected' : 'Connect',
      //           style: TextStyle(
      //             color: isConnected ? Colors.red : Colors.blue,
      //             fontSize: 18,
      //           ),
      //         ),
      //       )>,
      

      
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor:Colors.green ),
              child: Text('Chat',style: TextStyle(color: Colors.white),),
              onPressed:()=>Get.to(()=>ChatScreen(loggedInUserId: widget.loggedInUserId, postOwnerId: widget.usermodel?.id??'',reseller: 
              widget.usermodel,)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Post'),
              Tab(text: 'Catalog'),
            
            ],
          ),

          Container(
          height: 200,
          child: TabBarView(children: [
                   Post_Grid(
                    userid: widget.usermodel?.id,
                  userprofile: widget.usermodel,
                
                    ),
                      Catelog_Grid(
                                      userid: widget.usermodel?.id,
                                    ),
            

          ]),
 

          )


        ],
      ),
    );
  }

  // Widget _buildProductGrid() {
  //   return Post_Grid(
  //     userid: widget.usermodel.id,
  //   );
  // }

  // Widget _buildProductItem(String imagePath) {
  //   return Card(
  //     child: Image.asset(imagePath, fit: BoxFit.cover),
  //   );
  // }
}



