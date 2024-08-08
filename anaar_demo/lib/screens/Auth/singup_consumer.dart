import 'package:anaar_demo/providers/authProvider.dart';
import 'package:anaar_demo/screens/Auth/login_consumer.dart';
import 'package:anaar_demo/screens/homepage.dart';
import 'package:anaar_demo/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ConsumerRegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<ConsumerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _businessNameController=TextEditingController();
  final _bio_controller=TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
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
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Your Account'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _image != null ? FileImage(_image!) : null,
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
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Owner name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),

 TextFormField(
                  controller: _businessNameController,
                  decoration: InputDecoration(
                    labelText: 'Business Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Owner name';
                    }
                    return null;
                  },
                ),



                SizedBox(width: 16.0),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'cityname',
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
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
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
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
               // Text("bio",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              TextField(
              controller: 
              _bio_controller,
              decoration: InputDecoration(
                label: Text("Bio"),
                border: OutlineInputBorder(),
                hintText: 'Add text here...',
              ),
              maxLines: 5,
            ),SizedBox(height: 5,),

               authProvider.isLoading?CircularProgressIndicator():
               
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      bool val = await authProvider.Consumer_register(
                          _businessNameController.text,
                          _cityController.text,
                          _emailController.text,
                          _phoneNumberController.text,
                          _passwordController.text,
                          _image,
                          _bio_controller.text
                          );

                      if (val) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationExample(),
                          ),
                        );
                      }
                      else{
                          showDialog<String>(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Login failed'),
                                        content: const Text(
                                            'Check Email and password again'),
                                      ),
                                    );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Create Account',style: TextStyle(color: Colors.white),),
                ),
                 Row(children: [
                Text("Already have an account?"),
                TextButton(onPressed: ()=>Get.to(()=>LoginPageConsumer()), child: Text("Login",style: TextStyle(color: Colors.blue),))
               ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
