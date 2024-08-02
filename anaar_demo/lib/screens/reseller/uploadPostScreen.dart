import 'package:anaar_demo/model/Post_model.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class UploadPostScreen extends StatefulWidget {
  @override
  _UploadPostScreenState createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String? userId;
  String? userType;
  final _description = TextEditingController();
  final _category = TextEditingController();
  List<File> _images = [];

  Future<void> _pickImage() async {
    if (_images.length < 4) {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _images.add(File(pickedImage.path));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only upload up to 4 images')),
      );
    }
  }

  Future<void> getuserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    userType = prefs.getString('userType');
  }

  void _uploadPost() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Post post = Post(
        userid: userId,
        description: _description.text,
        category: _category.text,
        likes: [],
        comments: [],
        images: [],
        userType: userType,
      );

      Provider.of<PostProvider>(context, listen: false)
        .uploadPostWithImages(post, _images)
        .then((_) {
          Navigator.of(context).pop();
        }).catchError((error) {
          ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
        });
    }
  }

  @override
  void initState() {
    super.initState();
    getuserId();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Upload Post')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _description,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _category,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Upload Images', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text('Pick Images'),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _images.map((image) {
                  return Stack(
                    children: [
                      Image.file(
                        image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _images.remove(image);
                            });
                          },
                          child: Container(
                            color: Colors.black54,
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Center(
                child: authProvider.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _uploadPost,
                      child: Text('Upload Post'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
