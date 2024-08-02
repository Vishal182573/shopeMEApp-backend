import 'dart:io';
//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:anaar_demo/model/reseller_model.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditResellerprofile extends StatefulWidget {
  String ownername;
  String businessname;
  //String username;
  String? aboutUs;
  String? email;
  String? password;
  String phoneno_;
  String adress;
  String city;
  List<String?> connections;
  String? profileimage;
  String? bgImage;
  EditResellerprofile({
    this.aboutUs,
    this.bgImage,
    this.profileimage,
    this.email,
    this.password,
    required this.connections,
    required this.ownername,
    required this.adress,
    required this.businessname,
    required this.city,
    required this.phoneno_,
    //required this.username,
  });
  @override
  State<EditResellerprofile> createState() => _EditResellerprofileState();
}

class _EditResellerprofileState extends State<EditResellerprofile> {
  // String ownername = widget.businessname;

  var _formKey = GlobalKey<FormState>();
  var _ownerNameController = TextEditingController(text: "ooooo");
  var _businessNameController = TextEditingController();
  var _cityController = TextEditingController();
  //final _passwordController = TextEditingController();
  var _addressController = TextEditingController();
  var _phonenocontroller = TextEditingController();
  var _aboutUscontroller=TextEditingController();
  File? _image;
  File? forgroundimage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile1 = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile1 != null) {
      setState(() {
        forgroundimage = File(pickedFile1.path);
      });
    }
  }

  Future<void> _pickImage2() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _updateInfo() {
    Reseller reseller = Reseller(
        bgImage: '',
        ownerName: _ownerNameController.text,
        businessName: _businessNameController.text,
        email: widget.email ?? '',
        password: widget.password ?? '',
        address: _addressController.text,
        contact: _phonenocontroller.text,
        city: _cityController.text,
        image: '',
        connections: widget.connections,
        aboutUs:_aboutUscontroller.text ,
        type: 'reseller');

    Provider.of<UserProvider>(context, listen: false)
        .updateresellerinfowithImage(reseller, _image, forgroundimage)
        .then((_) {
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  @override
  void initState() {
    _businessNameController =
        new TextEditingController(text: widget.businessname);
    _ownerNameController = new TextEditingController(text: widget.ownername);
    _phonenocontroller = new TextEditingController(text: widget.phoneno_);
    _addressController = new TextEditingController(text: widget.adress);
    // _businessNameController = new TextEditingController();
    _cityController = new TextEditingController(text: widget.city);
    _aboutUscontroller=new TextEditingController(text: widget.aboutUs);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Profile Changes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                // color: Colors.black,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,
                      child: forgroundimage != null
                          ? Expanded(
                              child: Image(
                              image: FileImage(forgroundimage!),
                              fit: BoxFit.cover,
                            ))
                          : null,
                    ),
                    Positioned(
                        top: 20,
                        right: 10,
                        child: IconButton(
                            onPressed: _pickImage,
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              size: 35,
                              color: Colors.white,
                            ))),
                    Positioned(
                      bottom: 0,
                      left: 118,
                      child: GestureDetector(
                        onTap: _pickImage2,
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 120,
                      child: GestureDetector(
                        onTap: _pickImage2,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          backgroundImage:
                              _image != null ? FileImage(_image!) : null,
                          child: _image == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                  color: Colors.grey[700],
                                )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ownerNameController,
                      decoration: InputDecoration(
                        labelText: 'Ownername',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Owner name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      // initialValue: "delhisssh",
                      controller: _businessNameController,
                      decoration: InputDecoration(
                        //hintText: 'Delhi',
                        labelText: 'Businessname',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your business name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                //  initialValue: 'Delhi',

                controller: _cityController,
                enableSuggestions: true,
                decoration: InputDecoration(
                  hintText: 'Delhi',
                  labelText: 'city',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phonenocontroller,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                //obscureText: true,
                decoration: InputDecoration(
                  labelText: 'address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter Address';
                  }
                  return null;
                },
              ),SizedBox(height: 10,),
               TextFormField(
                controller: _aboutUscontroller,
                //obscureText: true,
                decoration: InputDecoration(
                  labelText: 'about us',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _updateInfo();
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
