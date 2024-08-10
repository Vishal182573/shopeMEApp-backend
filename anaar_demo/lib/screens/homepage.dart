// import 'package:anaar_demo/model/userModel.dart';
// import 'package:anaar_demo/providers/commonuserdataprovider.dart';
// import 'package:anaar_demo/screens/FeedSection.dart';
// import 'package:anaar_demo/screens/TrendingPage.dart';
// import 'package:anaar_demo/screens/requiremnetPage/requirementPage.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:get/get.dart';
// import 'package:anaar_demo/helperfunction/helperfunction.dart';
// import 'package:anaar_demo/model/postcard_model.dart';
// import 'package:anaar_demo/providers/postProvider.dart';
// import 'package:anaar_demo/providers/userProvider.dart';
// import 'package:anaar_demo/screens/chatScreen.dart';
// import 'package:anaar_demo/screens/commentsection.dart';
// import 'package:anaar_demo/screens/requirement_page.dart';
// import 'package:anaar_demo/widgets/Likebutton.dart';
// import 'package:anaar_demo/widgets/photGrid.dart';
// import 'package:anaar_demo/widgets/profileTile.dart';
// import 'package:shimmer/shimmer.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   String? logedinuserId;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<PostcardProvider>(context, listen: false).fetchPostcards();
//     });
//     getuser();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void getuser() async {
//     logedinuserId = await Helperfunction.getUserId();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'ShopME',
//           style: TextStyle(
//               color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'Feed'),
//             Tab(text: 'Requirements'),
//             Tab(text: 'Trending'),
//           ],
//           labelColor: Colors.red,
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: Colors.red,
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           Feedsection(
//             //loginuse: logedinuserId,
//           ),
//           _buildRequirementsTab(),
//           _buildTrendingTab(),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => Get.to(() => RequirementPostScreen()),
//         label: Text(
//           "Add Requirement",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.red,
//         icon: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   Widget _buildRequirementsTab() {
//     return RequirementsPage();
//   }

//   Widget _buildTrendingTab() {
//     return Trendingpage();
//   }
// }
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/screens/FeedSection.dart';
import 'package:anaar_demo/screens/TrendingPage.dart';
import 'package:anaar_demo/screens/requirement_page.dart';
import 'package:anaar_demo/screens/requiremnetPage/requirementPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final postProvider = Provider.of<PostcardProvider>(context, listen: false);
    //   if (!postProvider.isLoaded) {
    //     postProvider.fetchPostcards();
    //   }
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopME', style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Requirements'),
          ],
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.red,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
         Feedsection(),
         Trendingpage(),
         RequirementsPage(),
           
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => RequirementPostScreen()),
        label: Text("Add Requirement",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        icon: Icon(Iconsax.add,color: Colors.white,),
      ),
    );
  }
}