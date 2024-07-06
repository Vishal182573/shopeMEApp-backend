import 'dart:io';

import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/onboardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:anaar_demo/providers/authProvider.dart';
import 'package:shimmer/shimmer.dart';

class ResellerProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ResellerProfilePage> {
  String? backgroundImagePath;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        backgroundImagePath = image.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Ensure fetchUserData is called
    Provider.of<UserProvider>(context, listen: false).fetchUserData().catchError((error) {
      print('Error fetching user data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              authProvider.logout();
              Get.offAll(() => onboardingLoginPage());
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        height: 16.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        width: 200.0,
                        height: 16.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        height: 16.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        height: 16.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        width: 200.0,
                        height: 16.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.error != null) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<UserProvider>(
              builder: (ctx, userProvider, child) {
                if (userProvider.reseller == null) {
                  return Center(child: Text('No user data available'));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              child: backgroundImagePath != null
                                  ? Image.file(File(backgroundImagePath!), fit: BoxFit.cover)
                                  : Container(color: Colors.blue),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: IconButton(
                                icon: Icon(Icons.camera_alt, color: Colors.white),
                                onPressed: _pickImage,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.share),
                                label: Text('Share'),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/profile_pic.jpg'),
                          ),
                          title: Text(userProvider.reseller!.businessName),
                          subtitle: Text(userProvider.reseller!.city),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('17 Connections • 2 Products'),
                        ),
                        ElevatedButton(
                          child: Text('Add Products'),
                          onPressed: () {},
                        ),
                        DefaultTabController(
                          length: 3,
                          child: Column(
                            children: [
                              TabBar(
                                tabs: [
                                  Tab(text: 'About'),
                                  Tab(text: 'Catalog'),
                                  Tab(text: 'Posts'),
                                ],
                              ),
                              Container(
                                height: 200, // Adjust as needed
                                child: TabBarView(
                                  children: [
                                    Center(child: Text('About content')),
                                    Center(child: Text('Catalog content')),
                                    Center(child: Text('Posts content')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text('Owner is Aardra.j'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              child: Text('My Catalog'),
                              onPressed: () {},
                            ),
                            ElevatedButton(
                              child: Text('Add New'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
