import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Editconsumerprofile extends StatefulWidget{

  @override
  State<Editconsumerprofile> createState() => _EditconsumerprofileState();
}

class _EditconsumerprofileState extends State<Editconsumerprofile> {

TextEditingController _namecontroller=TextEditingController();
TextEditingController _contactcontroller=TextEditingController();
TextEditingController _businessNameController=TextEditingController();
TextEditingController _cityController=TextEditingController();
TextEditingController _EmailController=TextEditingController();
//TextEditingController _contactc=TextEditingController();
File? _image;

 Future<void> _pickImage2() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
        title: Text("Edit Profile",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        ),
                             
        body: SafeArea(child: SingleChildScrollView(
          child: Column(children: [
          
                  GestureDetector(
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
                
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(children: [
                       
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: TextFormField(
                                                            controller: _namecontroller,
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
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 10),
                         child: TextFormField(
                               controller: _namecontroller,
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
                       
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 10),
                         child: TextFormField(
                               controller: _namecontroller,
                               decoration: InputDecoration(
                                 labelText: 'City',
                                 border: OutlineInputBorder(),
                               ),
                               validator: (value) {
                                 if (value == null || value.isEmpty) {
                                   return 'Please enter your phone number';
                                 }
                                 return null;
                               },
                             ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 10),
                         child: TextFormField(
                               controller: _namecontroller,
                               decoration: InputDecoration(
                                 labelText: 'Phone no.',
                                 border: OutlineInputBorder(),
                               ),
                               validator: (value) {
                                 if (value == null || value.isEmpty) {
                                   return 'Please enter your City';
                                 }
                                 return null;
                               },
                             ),
                       ),
          
                         Center(child: ElevatedButton(onPressed: (){}, child: Text("Save",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),),)
          
                       ],),
                     )
          
          ],),
        )),

    );
  }
}