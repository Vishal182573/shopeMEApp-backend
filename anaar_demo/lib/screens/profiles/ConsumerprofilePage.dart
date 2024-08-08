// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import 'package:anaar_demo/providers/authProvider.dart';
// import 'package:anaar_demo/providers/userProvider.dart';
// import 'package:anaar_demo/screens/consumer/EditConsumerProfile.dart';
// import 'package:anaar_demo/screens/onboardingScreens.dart';

// class Consumerprofilepage extends StatefulWidget {
//   @override
//   _UserProfilePageState createState() => _UserProfilePageState();
// }

// class _UserProfilePageState extends State<Consumerprofilepage> {
//   @override
//   void initState() {
//     super.initState();
//     // Pre-fetch user data when the screen is initialized
//     Provider.of<UserProvider>(context, listen: false).fetchConsumerData();
//   }

//   Future<void> _refreshData() async {
//     try {
//       await Provider.of<UserProvider>(context, listen: false).fetchConsumerData();
//     } catch (error) {
//       // Handle error if necessary
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//         backgroundColor: Colors.red,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () => showDialog<String>(
//               context: context,
//               builder: (BuildContext context) => AlertDialog(
//                 title: const Text('Log out'),
//                 content: const Text('Do you want to logout?'),
//                 actions: <Widget>[
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, 'Cancel'),
//                     child: const Text('Cancel'),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       await Provider.of<AuthProvider>(context, listen: false).logout();
//                       Get.offAll(() => onboardingLoginPage());
//                     },
//                     child: const Text('OK'),
//                   ),
//                 ],
//               ),
//             ),
//             icon: Icon(Icons.logout, color: Colors.white),
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _refreshData,
//         child: Consumer<UserProvider>(
//           builder: (context, userProvider, child) {
//             if (userProvider.consumer == null) {
//               return FutureBuilder(
//                 future: userProvider.fetchConsumerData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return _buildShimmerLoading();
//                   } else if (snapshot.error != null) {
//                     return Center(child: Text('An error occurred!'));
//                   } else {
//                     return _buildProfileContent(userProvider);
//                   }
//                 },
//               );
//             } else {
//               return _buildProfileContent(userProvider);
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileContent(UserProvider userProvider) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Stack(
//               alignment: Alignment.bottomRight,
//               children: [
//                 CircleAvatar(
//                   radius: 60,
//                   backgroundImage: userProvider.consumer!.image != null
//                       ? NetworkImage(userProvider.consumer!.image ?? '')
//                       : AssetImage('assets/profile_image.jpg') as ImageProvider,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.edit, color: Colors.white),
//                     onPressed: () => Get.to(() => Editconsumerprofile(
//                       connnections: userProvider.consumer?.connections,
//                       email: userProvider.consumer!.email,
//                       name: userProvider.consumer!.name,
//                       phoneno_: userProvider.consumer!.contact,
//                       bio: userProvider.consumer!.bio,
//                       city: userProvider.consumer!.city,
//                       imgurl: userProvider.consumer!.image,
//                     )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("${userProvider.consumer?.connections!.length}"),
//               SizedBox(width: 10),
//               Text("Connections."),
//             ],
//           ),
//           _buildEditableField(title: 'Name', value: userProvider.consumer!.name ?? ''),
//           _buildEditableField(title: 'Phone', value: userProvider.consumer!.contact ?? ''),
//           _buildEditableField(title: 'Email', value: userProvider.consumer!.email ?? ''),
//           _buildEditableField(title: 'Bio', value: userProvider.consumer!.bio ?? '', isMultiline: true),
//         ],
//       ),
//     );
//   }

//   Widget _buildEditableField({
//     required String title,
//     required String value,
//     bool isMultiline = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         Row(
//           crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Text(
//                 value,
//                 style: TextStyle(fontSize: 14),
//                 maxLines: 20,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         Divider(),
//         SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildShimmerLoading() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.white,
//             ),
//           ),
//           SizedBox(height: 16),
//           _buildShimmerLine(),
//           SizedBox(height: 16),
//           _buildShimmerLine(),
//           SizedBox(height: 16),
//           _buildShimmerLine(),
//           SizedBox(height: 16),
//           _buildShimmerLine(),
//         ],
//       ),
//     );
//   }

//   Widget _buildShimmerLine() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         height: 20,
//         color: Colors.white,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:anaar_demo/providers/authProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/consumer/EditConsumerProfile.dart';
import 'package:anaar_demo/screens/onboardingScreens.dart';

class Consumerprofilepage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<Consumerprofilepage> {
  @override
  void initState() {
    super.initState();
    // Pre-fetch user data when the screen is initialized
    Provider.of<UserProvider>(context, listen: false).fetchConsumerData();
  }

  Future<void> _refreshData() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).fetchConsumerData();
    } catch (error) {
      // Handle error if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Log out'),
                content: const Text('Do you want to logout?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Provider.of<AuthProvider>(context, listen: false).logout();
                      Get.offAll(() => onboardingLoginPage());
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.consumer == null) {
              return FutureBuilder(
                future: userProvider.fetchConsumerData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildShimmerLoading();
                  } else if (snapshot.error != null) {
                    return Center(child: Text('An error occurred!'));
                  } else {
                    return _buildProfileContent(userProvider);
                  }
                },
              );
            } else {
              return _buildProfileContent(userProvider);
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(UserProvider userProvider) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: userProvider.consumer!.image != null
                    ? NetworkImage(userProvider.consumer!.image ?? '')
                    : AssetImage('assets/profile_image.jpg') as ImageProvider,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () => Get.to(() => Editconsumerprofile(
                    connnections: userProvider.consumer?.connections,
                    email: userProvider.consumer!.email,
                    name: userProvider.consumer!.name,
                    phoneno_: userProvider.consumer!.contact,
                    bio: userProvider.consumer!.bio,
                    city: userProvider.consumer!.city,
                    imgurl: userProvider.consumer!.image,
                  )),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${userProvider.consumer?.connections!.length}"),
            SizedBox(width: 10),
            Text("Connections."),
          ],
        ),
        _buildEditableField(title: 'Name', value: userProvider.consumer!.name ?? ''),
        _buildEditableField(title: 'Phone', value: userProvider.consumer!.contact ?? ''),
        _buildEditableField(title: 'Email', value: userProvider.consumer!.email ?? ''),
        _buildEditableField(title: 'Bio', value: userProvider.consumer!.bio ?? '', isMultiline: true),
      ],
    );
  }

  Widget _buildEditableField({
    required String title,
    required String value,
    bool isMultiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 14),
                maxLines: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Divider(),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          _buildShimmerLine(),
          SizedBox(height: 16),
          _buildShimmerLine(),
          SizedBox(height: 16),
          _buildShimmerLine(),
          SizedBox(height: 16),
          _buildShimmerLine(),
        ],
      ),
    );
  }

  Widget _buildShimmerLine() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 20,
        color: Colors.white,
      ),
    );
  }
}

