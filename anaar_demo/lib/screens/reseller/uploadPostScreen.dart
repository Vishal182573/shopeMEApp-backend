import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/Post_model.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class UploadPostScreen extends StatefulWidget {
  // String? userId;
  // UploadPostScreen({required this.userId});

  @override
  _UploadPostScreenState createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String? userId;
  String? userType;
  //final  _userid = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();
  List<File> _images = [];

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        if (_images.length < 4) {
          _images.add(File(pickedImage.path));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You can only upload up to 4 images')));
        }
      });
    }
  }

  Future<void> getuserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    userType = prefs.getString('userType');
  }

  void _uploadPost() async {
    // String? userId = await Helperfunction.getUserId();
    print('$userId++++++++++++++++++++++++++');
    print('$userType++++++++++++++++');
    print(_category.text);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Post post = Post(
          userid: userId,
          description: _description.text,
          category: _category.text,
          likes: [],
          comments: [],
          images: [],
          userType: userType);

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
    // TODO: implement initState
    super.initState();
    getuserId();
    //_loadUserId();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Upload Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _description,
                      decoration: InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _category,
                      decoration: InputDecoration(labelText: 'Category'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter category';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Pick Images'),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _images.map((image) {
                        return Stack(
                          children: [
                            Image.file(image,
                                width: 100, height: 100, fit: BoxFit.cover),
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
             authProvider.isLoading
            ? CircularProgressIndicator()
            :       ElevatedButton(
                      onPressed: _uploadPost,
                      child: Text('Upload Post'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
