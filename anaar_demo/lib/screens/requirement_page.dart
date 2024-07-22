import 'package:anaar_demo/model/consumer_model.dart';
import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/commonuserdataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:anaar_demo/model/Requirement_model.dart';
import 'package:anaar_demo/providers/RequirementProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/chatScreen.dart';

class RequirementsPage extends StatefulWidget {
  @override
  State<RequirementsPage> createState() => _RequirementsPageState();
}

class _RequirementsPageState extends State<RequirementsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RequirementcardProvider>(context, listen: false)
          .fetchreqcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Customers Requirements'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<RequirementcardProvider>(context, listen: false)
            .fetchreqcards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else {
            return Consumer<RequirementcardProvider>(
              builder: (ctx, reqcardProvider, child) {
                if (reqcardProvider.reqcards == null ||
                    reqcardProvider.reqcards.isEmpty) {
                  return Center(child: Text('No requirements available'));
                } else {
                  // final validRequirements = reqcardProvider.reqcards
                  //     .where(
                  //         (req) => req.userId != null && req.userId!.isNotEmpty)
                  //     .toList();

                  return ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: reqcardProvider.reqcards.length,
                    itemBuilder: (context, index) {
                      return OrderCard(
                          requirement: reqcardProvider.reqcards[index]);
                    },
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

class OrderCard extends StatelessWidget {
  final Requirement requirement;

  OrderCard({required this.requirement});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usermodel?>(
      future: Provider.of<UserProvider>(context, listen: false)
          .fetchUserinfo(requirement.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoadingCard();
        } else if (snapshot.hasError) {
          return Text("Error occurred: ${snapshot.error}");
        } else if (snapshot.data == null) {
          return Text("No user data available");
        } else {
          final userModel = snapshot.data!;
          return _buildCard(context, requirement, userModel);
        }
      },
    );
  }

  Widget _buildCard(
      BuildContext context, Requirement requirement, Usermodel user) {
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
                onPressed: () {},
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.blue),
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
                        child: Image.network(
                          image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.connect_without_contact),
                  label: Text('Connect'),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () => Get.to(ChatScreen()),
                  icon: Icon(Icons.chat, color: Colors.white),
                  label: Text('Chat', style: TextStyle(color: Colors.white)),
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
