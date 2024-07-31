import 'package:anaar_demo/providers/authProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/consumer/EditConsumerProfile.dart';
import 'package:anaar_demo/screens/onboardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Consumerprofilepage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<Consumerprofilepage> {
  String name = 'vipin';
  String phone = '989120000';
  String email = 'test.test@gmail.com';
  String bio = 'Saree Retailer .situated in Ahemdabadh.';
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _editField(String title, String currentValue) async {
    String? newValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String updatedValue = currentValue;
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter new $title'),
            onChanged: (value) {
              updatedValue = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () => Navigator.of(context).pop(updatedValue),
            ),
          ],
        );
      },
    );

    if (newValue != null && newValue.isNotEmpty) {
      setState(() {
        switch (title) {
          case 'Name':
            name = newValue;
            break;
          case 'Phone':
            phone = newValue;
            break;
          case 'Email':
            email = newValue;
            break;
          case 'Bio':
            bio = newValue;
            break;
        }
      });
    }
  }

//,.................................shimmer loading ......................

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




  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              onPressed: ()async {
                 authProvider.logout();
               Get.offAll(() => onboardingLoginPage());

              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body:
      FutureBuilder(future:
      Provider.of<UserProvider>(context,listen: false).fetchConsumerData()
       , builder: (context,snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
      return _buildShimmerLoading();
      }
    else if(snapshot.error!=null){
      print('Error: ${snapshot.error}');
            return Center(child: Text('An error occurred!'));
    }
   else{
            return Consumer<UserProvider>(builder: (ctx,userProvider,child){
            if(userProvider.consumer==null){
              return Center(child: Text('no user data available'),);

            }
            else{
          return  SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: userProvider.consumer!.image != null
                        ? NetworkImage(userProvider.consumer!.image??'')
                        : AssetImage('assets/profile_image.jpg')
                            as ImageProvider,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: ()=>Get.to(()=>Editconsumerprofile()),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
             Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("17"),SizedBox(width: 10,) ,Text("Connections.")],),
            _buildEditableField(title: 'Name', value: userProvider.consumer!.name??''),
            _buildEditableField(title: 'Phone', value:userProvider.consumer!.contact??'' ),
            _buildEditableField(title: 'Email', value: userProvider.consumer!.email??''),
            _buildEditableField(title: 'Bio', value: userProvider.consumer!.businessName??'', isMultiline: true),
          ],
        ),
      );
            }
            }            
            );

      }
      
      
   
   
   } )

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
        Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: isMultiline
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                value,
              
                style: TextStyle(
                
                
                  fontSize: 14,
                ),
                maxLines: 20,
                overflow:  TextOverflow.ellipsis,
              ),
            ),
           
          ],
        ),
        Divider(),
        SizedBox(height: 16),
      ],
    );
  }
}
