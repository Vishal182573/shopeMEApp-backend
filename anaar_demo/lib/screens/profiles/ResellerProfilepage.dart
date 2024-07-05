import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class resellerProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<resellerProfilePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
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
              title: Text('Aardra collections'),
              subtitle: Text('Wholesaler • Bangalore • Yeswanthpura'),
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
      ),
    );
  }
}