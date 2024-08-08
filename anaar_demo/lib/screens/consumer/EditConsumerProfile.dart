import 'dart:io';

import 'package:anaar_demo/model/consumer_model.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class Editconsumerprofile extends StatefulWidget{
String? email;
String? name;
String? phoneno_;
String? bio;
String? city;
String? imgurl;
List<Connections>? connnections;

Editconsumerprofile({
  required this.email,
 required this.name,
 required this.phoneno_,
 required this.bio,
 required this.city,
  this.imgurl,
  required this.connnections

});

  @override
  State<Editconsumerprofile> createState() => _EditconsumerprofileState();
}

class _EditconsumerprofileState extends State<Editconsumerprofile> {

TextEditingController _namecontroller=TextEditingController();
TextEditingController _contactcontroller=TextEditingController();
TextEditingController _bioController=TextEditingController();
TextEditingController _cityController=TextEditingController();
// TextEditingController _EmailController=TextEditingController();
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

void _updateInfo() {
    // Consumer reseller = Reseller(
    //     bgImage: '',
    //     ownerName: _ownerNameController.text,
    //     businessName: _businessNameController.text,
    //     email: widget.email ?? '',
    //     password: widget.password ?? '',
    //     address: _addressController.text,
    //     contact: _phonenocontroller.text,
    //     city: _cityController.text,
    //     image: '',
    //     connections: widget.connections,
    //     aboutUs:_aboutUscontroller.text ,
    //     type: 'reseller');

    ConsumerModel consumer=ConsumerModel(
      connections:widget.connnections ,
     name: _namecontroller.text, businessName:
      '',
       city: _cityController.text, 
       email: widget.email, 
       contact: _contactcontroller.text,
        image: widget.imgurl,
         type: 'Consumer', );

    Provider.of<UserProvider>(context, listen: false)
        .updaterConsumer_infowithImage(consumer, _image,
        )
        .then((_) {
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }








@override
  void initState() {
    // TODO: implement initState
    super.initState();
  _namecontroller=TextEditingController(text: widget.name);
  _contactcontroller=TextEditingController(text: widget.phoneno_);
  _bioController=TextEditingController(text: widget.bio);
  _cityController=TextEditingController(text: widget.city);
  }



@override
  Widget build(BuildContext context) {
    // TODO: implement build
    final authprovider=Provider.of<UserProvider>(context);
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
                                _image != null ? FileImage(_image!) : widget.imgurl!=null?NetworkImage(widget.imgurl!):null,
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
                                                              labelText: 'Name',
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
                               controller: _cityController,
                               decoration: InputDecoration(
                                 labelText: 'city',
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
                       
                      //  Padding(
                      //    padding: const EdgeInsets.symmetric(vertical: 10),
                      //    child: TextFormField(
                      //          controller: _namecontroller,
                      //          decoration: InputDecoration(
                      //            labelText: 'City',
                      //            border: OutlineInputBorder(),
                      //          ),
                      //          validator: (value) {
                      //            if (value == null || value.isEmpty) {
                      //              return 'Please enter your phone number';
                      //            }
                      //            return null;
                      //          },
                      //        ),
                      //  ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 10),
                         child: TextFormField(
                               controller: _contactcontroller,
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
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 10),
                         child: TextFormField(
                               controller: _bioController,
                               decoration: InputDecoration(
                                 hintText: "Enter Text here.....",
                                 labelText: 'bio',
                                 border: OutlineInputBorder(),
                               ),
                              
                             ),
                       ),
                    authprovider.isloading?Center(child: CircularProgressIndicator(),):
                         Center(child: ElevatedButton(onPressed: (){_updateInfo();}, child: Text("Save",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),),)
          
                       ],),
                     )
          
          ],),
        )),

    );
  }
}