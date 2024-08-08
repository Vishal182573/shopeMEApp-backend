// import 'package:anaar_demo/helperfunction/helperfunction.dart';
// import 'package:anaar_demo/model/consumer_model.dart';
// import 'package:anaar_demo/model/userModel.dart';
// import 'package:anaar_demo/providers/commonuserdataprovider.dart';
// import 'package:anaar_demo/widgets/GalleryPhotoViewer.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:anaar_demo/model/Requirement_model.dart';
// import 'package:anaar_demo/providers/RequirementProvider.dart';
// import 'package:anaar_demo/providers/userProvider.dart';
// import 'package:anaar_demo/screens/chatScreen.dart';

// class RequirementsPage extends StatefulWidget {
  
  
//   @override
//   State<RequirementsPage> createState() => _RequirementsPageState();
// }

// class _RequirementsPageState extends State<RequirementsPage> {
//   String? loggedInUserId;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<RequirementcardProvider>(context, listen: false)
//           .fetchreqcards();
//     });
//     getlogginuserid();
//   }
//   void getlogginuserid()async{
//       loggedInUserId=await Helperfunction.getUserId();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red.withOpacity(0.9),
//         automaticallyImplyLeading: false,
//         title: Text('Customers Requirements',style: TextStyle(color: Colors.white),),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search,color: Colors.white,),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: Provider.of<RequirementcardProvider>(context, listen: false)
//             .fetchreqcards(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('An error occurred: ${snapshot.error}'));
//           } else {
//             return Consumer<RequirementcardProvider>(
//               builder: (ctx, reqcardProvider, child) {
//                 if (reqcardProvider.reqcards == null ||
//                     reqcardProvider.reqcards.isEmpty) {
//                   return Center(child: Text('No requirements available'));
//                 } else {
//                   // final validRequirements = reqcardProvider.reqcards
//                   //     .where(
//                   //         (req) => req.userId != null && req.userId!.isNotEmpty)
//                   //     .toList();

//                   return ListView.builder(
//                     physics: ScrollPhysics(),
//                     scrollDirection: Axis.vertical,
//                     itemCount: reqcardProvider.reqcards.length,
//                     itemBuilder: (context, index) {
//                       return OrderCard(
//                           requirement: reqcardProvider.reqcards[reqcardProvider.reqcards.length-
//                           index-1],
//                           loggedinuserid: loggedInUserId,
//                           );
//                     },
//                   );
//                 }
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class OrderCard extends StatelessWidget {
//   final Requirement requirement;
//   final loggedinuserid;

//   OrderCard({required this.requirement,required this.loggedinuserid});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Usermodel?>(
//       future: Provider.of<UserProvider>(context, listen: false)
//           .fetchUserinfo(requirement.userId),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return ShimmerLoadingCard();
//         } else if (snapshot.hasError) {
//           return Text("Error occurred: ${snapshot.error}");
//         } else if (snapshot.data == null) {
//           return Text("No user data available");
//         } else {
//           final userModel = snapshot.data!;
//           return _buildCard(context, requirement, userModel,loggedinuserid);
//         }
//       },
//     );
//   }

//   Widget _buildCard(
//       BuildContext context, Requirement requirement, Usermodel user,String? loggedinuser) {
// final userProvider = Provider.of<UserProvider>(context);
//     final bool isConnected = userProvider.connections.contains(user.id);



//     return Card(
//       elevation: 10,
//       margin: EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(user.image ?? ''),
//               ),
//               title: Text(user.businessName ?? ''),
//               trailing: TextButton(
//                 onPressed: () async{
//                        if(!isConnected){
//                       print("coonected function hitted............");
//                        await userProvider.connectUser(loggedinuser, user.id, user.type);

//                        }

//                 },
//                 child: Text(
//                  isConnected? 'Connected':'Connect',
//                   style: TextStyle(color:isConnected? Colors.red:Colors.blue),
//                 ),
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text('Product Details:',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(height: 8.0),
//             Text("Product Name: ${requirement.productName}"),
//             Text('Category: ${requirement.category}'),
//             Text('QTY: ${requirement.quantity}'),
//             Text('Total Price: ${requirement.totalPrice}'),
//             SizedBox(height: 8.0),
//             Text('More Details:',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(height: 8.0),
//             Text(requirement.details ?? ''),
//             SizedBox(height: 8.0),
//             Text('Attached Images:',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(height: 8.0),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: requirement.images?.map((image) {
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: GestureDetector(
//                           onTap: ()=> _openPhotoViewer(context,requirement.images.indexOf(image)),
//                           child: Image.network(
//                             image!,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       );
//                     }).toList() ??
//                     [],
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton.icon(
//                   onPressed: () {},
//                   icon: Icon(Icons.connect_without_contact),
//                   label: Text('Connect'),
//                 ),
//                 TextButton.icon(
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                   ),

//                   //navigate to chatscreen
              
//                   onPressed:() => Get.to(() => ChatScreen(loggedInUserId:loggedinuserid
//                         , postOwnerId: requirement.userId??'',user:user ,)),
//                   icon: Icon(Icons.chat, color: Colors.white),
//                   label: Text('Chat', style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }


  






import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/chatScreen.dart';
import 'package:anaar_demo/screens/show_My_req.dart';
import 'package:anaar_demo/widgets/GalleryPhotoViewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/Requirement_model.dart';
import 'package:anaar_demo/providers/RequirementProvider.dart';
import 'package:shimmer/shimmer.dart';


class RequirementsPage extends StatefulWidget {
  @override
  State<RequirementsPage> createState() => _RequirementsPageState();
}

class _RequirementsPageState extends State<RequirementsPage> {
  String? loggedInUserId;
  bool _showSearch = false;
  TextEditingController _searchController = TextEditingController();
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RequirementcardProvider>(context, listen: false).fetchreqcards();
    });
    getlogginuserid();
    _loadSearchHistory();
  }

  void getlogginuserid() async {
    loggedInUserId = await Helperfunction.getUserId();
  }

  void _loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = prefs.getStringList('searchHistory') ?? [];
    });
  }

  void _saveSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', _searchHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.9),
        automaticallyImplyLeading: false,
        title: _showSearch
            ? Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  _buildSearchField(),
                ],
              ),
            )
            : Text('Customers Requirements', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
                if (!_showSearch) {
                  _searchController.clear();
                  Provider.of<RequirementcardProvider>(context, listen: false).clearSearch();
                }
              });
            },
          ),
        ],
      ),
      body: 
      
      Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: Divider()),TextButton(onPressed:()=>Get.to(()=>MY_requirements(loggedInUserId: loggedInUserId)), child: 
            Text("Your requirements",style: TextStyle(color: Colors.blue),))],),
          Expanded(child: _buildBody()),
        ],
      ),
      
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: AnimatedContainer(
        
        duration: Duration(milliseconds: 300),
        width: _showSearch ? MediaQuery.of(context).size.width - 56 : 0,
        child: Column(
          children: [
            TextField(
              
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
               // enabledBorder: OutlineInputBorder(),
                hintText: 'Search requirements...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                Provider.of<RequirementcardProvider>(context, listen: false).searchRequirements(value);
              },
              onSubmitted: (value) {
                if (value.isNotEmpty && !_searchHistory.contains(value)) {
                  setState(() {
                    _searchHistory.insert(0, value);
                    if (_searchHistory.length > 5) _searchHistory.removeLast();
                  });
                  _saveSearchHistory();
                }
              },
            ),
            if (_showSearch) _buildSearchHistoryDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHistoryDropdown() {
    return DropdownButton<String>(
      items: _searchHistory.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _searchHistory.remove(item);
                  });
                  _saveSearchHistory();
                },
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          _searchController.text = newValue;
          Provider.of<RequirementcardProvider>(context, listen: false).searchRequirements(newValue);
        }
      },
    );
  }

  Widget _buildBody() {
    return Consumer<RequirementcardProvider>(
      builder: (ctx, reqcardProvider, child) {
        if (reqcardProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (reqcardProvider.reqcards.isEmpty) {
          return Center(child: Text('No requirements available'));
        } else {
          return ListView.builder(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: reqcardProvider.reqcards.length,
            itemBuilder: (context, index) {
              return OrderCard(
                requirement: reqcardProvider.reqcards[reqcardProvider.reqcards.length - index - 1],
                loggedinuserid: loggedInUserId,
              );
            },
          );
        }
      },
    );
  }
}



class OrderCard extends StatelessWidget {
  final Requirement requirement;
  final String? loggedinuserid;

  OrderCard({required this.requirement, required this.loggedinuserid});
  
 void _openPhotoViewer(BuildContext context, int initialIndex) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PhotoViewer(
    //       imageUrls: imageUrls,
    //       initialIndex: initialIndex,
    //     ),
    //   ),
    // );

    Get.to(()=>PhotoViewer(imageUrls: requirement.images, initialIndex: initialIndex));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usermodel?>(future: 
    Provider.of<UserProvider>(context,listen: false).fetchUserinfo(requirement.userId,userType: requirement.userType)
    , builder:(context,snapshot,){
       if(snapshot.connectionState==ConnectionState.waiting)  {
           return ShimmerLoadingCard();

       }
       else if(snapshot.hasError){
        print("Eroor in getting requirements..................");
        return SizedBox.shrink();
       }
       else{
              final usermodel=snapshot.data!;
              return _buildCard(context, requirement, usermodel, 
              
              loggedinuserid);



        
       }                   

    });
  }
  
  Widget _buildCard(
      BuildContext context, Requirement  requirement, Usermodel user,String? loggedinuser) {
final userProvider = Provider.of<UserProvider>(context);
    final bool isConnected = userProvider.connections.contains(user.id);



    return Card(
      elevation: 10,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.image ?? ''),
              ),
              title: Text(user.businessName ?? ''),
              trailing: TextButton(
                onPressed: () async{
                       if(!isConnected){
                      print("coonected function hitted............");
                       await userProvider.connectUser(loggedinuser, user.id, user.type);

                       }

                },
                child: Text(
                 isConnected? 'Connected':'Connect',
                  style: TextStyle(color:isConnected? Colors.red:Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text('Product Details:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text("Product Name: ${requirement.productName}"),
            Text('Category: ${requirement.category}'),
            Text('QTY: ${requirement.quantity}'),
            Text('Total Price: ${requirement.totalPrice}'),
            SizedBox(height: 8.0),
            Text('More Details:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(requirement.details ?? ''),
            SizedBox(height: 8.0),
            Text('Attached Images:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: requirement.images?.map((image) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: ()=> _openPhotoViewer(context,requirement.images.indexOf(image)),
                          child: Image.network(
                            image!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ),
            SizedBox(height: 8.0),
            
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  
                    //navigate to chatscreen
                                
                    onPressed:() => Get.to(() => ChatScreen(loggedInUserId:loggedinuserid
                          , postOwnerId: requirement.userId??'',user:user ,)),
                    icon: Icon(Icons.chat, color: Colors.white),
                    label: Text('Chat', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }















}


class ShimmerLoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(radius: 30),
                title: Container(height: 16, color: Colors.white),
                trailing: Container(width: 60, height: 24, color: Colors.white),
              ),
              SizedBox(height: 8.0),
              Container(height: 16, width: 120, color: Colors.white),
              SizedBox(height: 8.0),
              Container(
                  height: 16, width: double.infinity, color: Colors.white),
              SizedBox(height: 4.0),
              Container(
                  height: 16, width: double.infinity, color: Colors.white),
              SizedBox(height: 4.0),
              Container(
                  height: 16, width: double.infinity, color: Colors.white),
              SizedBox(height: 8.0),
              Container(
                  height: 100, width: double.infinity, color: Colors.white),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width: 100, height: 36, color: Colors.white),
                  Container(width: 100, height: 36, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

