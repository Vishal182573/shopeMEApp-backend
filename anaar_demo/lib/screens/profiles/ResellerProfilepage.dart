import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/providers/authProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/onboardingScreens.dart';
import 'package:anaar_demo/screens/reseller/edit_resellerProfile.dart';
import 'package:anaar_demo/screens/reseller/uploadCatelogScreen.dart';
import 'package:anaar_demo/screens/reseller/uploadPostScreen.dart';
import 'package:anaar_demo/widgets/Catelog_grib_builder.dart';
import 'package:anaar_demo/widgets/Post_Grib_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ResellerProfilePage extends StatefulWidget {
  @override
  _ResellerProfilePageState createState() => _ResellerProfilePageState();
}

class _ResellerProfilePageState extends State<ResellerProfilePage> {
  Future<void>? _fetchUserDataFuture;
  String? userid;

  @override
  void initState() {
    super.initState();
    getuser();
    _fetchUserDataFuture = Provider.of<UserProvider>(context, listen: false).fetchUserData();
  }

  void getuser() async {
    String? fetchedUserid = await Helperfunction.getUserId();
    setState(() {
      userid = fetchedUserid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
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
                      authProvider.logout();
                      Get.offAll(() => onboardingLoginPage());
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<UserProvider>(context, listen: false).fetchUserData();
        },
        child: Consumer<UserProvider>(
          builder: (ctx, userProvider, child) {
            final user = userProvider.reseller;
            if (user == null) {
              return FutureBuilder<void>(
                future: _fetchUserDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
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
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(child: Text('No user data available'));
                  }
                },
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey,
                          child: user.bgImage == ''
                              ? Container(color: Colors.grey)
                              : Image.network(
                                  user.bgImage??'',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(user.image??''),
                      ),
                      title: Text(
                        user.businessName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            "Location.",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(width: 10),
                          Text(user.city),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Get.to(() => EditResellerprofile(
                          bgImage: user.bgImage,
                          profileimage: user.image,
                          ownername: user.ownerName,
                          adress: user.address,
                          businessname: user.businessName,
                          city: user.city,
                          phoneno_: user.contact,
                          connections: user.connections,
                          email: user.email,
                          password: user.password,
                          aboutUs: user.aboutUs,
                        )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Connections ${user.connections?.length}   •   Products ${user.catalogueCount} '),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.blue),
                          ),
                          child: Text(
                            'Add Catelog',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => Get.to(
                              () => CatelogUploadScreen(userid: userid)),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                          child: Text('Add Post',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () => Get.to(() => UploadPostScreen()),
                        ),
                      ],
                    ),
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          TabBar(
                            tabs: [
                              Tab(text: 'Post'),
                              Tab(text: 'Catalog'),
                              Tab(text: 'About us'),
                            ],
                          ),
                          Container(
                            height: 200, // Adjust as needed
                            child: TabBarView(
                              children: [
                                Post_Grid(
                                  userid: userid,
                                  userProvider: userProvider,
                                ),
                                Catelog_Grid(
                                  userid: userid,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    user.aboutUs??'',
                                    maxLines: 45,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
