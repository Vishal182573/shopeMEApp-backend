import 'package:anaar_demo/providers/authProvider.dart';
import 'package:anaar_demo/screens/onboardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
              onPressed: () async {
                authProvider.logout();
                Get.offAll(() => onboardingLoginPage());
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
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
                    backgroundImage: _image != null
                        ? FileImage(_image!)
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
                      onPressed: _pickImage,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            _buildEditableField(title: 'Name', value: name),
            _buildEditableField(title: 'Phone', value: phone),
            _buildEditableField(title: 'Email', value: email),
            _buildEditableField(title: 'Bio', value: bio, isMultiline: true),
          ],
        ),
      ),
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
                maxLines: isMultiline ? null : 1,
                overflow: isMultiline ? null : TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editField(title, value),
            ),
          ],
        ),
        Divider(),
        SizedBox(height: 16),
      ],
    );
  }
}
