import 'package:anaar_demo/providers/authProvider.dart';
import 'package:anaar_demo/screens/Auth/Login_reseller.dart';
import 'package:anaar_demo/screens/homepage.dart';
import 'package:anaar_demo/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ResellerRegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<ResellerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _ownerNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _aboutUscontroller=TextEditingController();
  File? _image;
  bool _obscureText = true;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

     void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }




  Future<bool> _singup(BuildContext context) async {
 
   
    final email = _emailController.text;
    final password = _passwordController.text;
    final owernername = _ownerNameController.text;
    final address = _addressController.text;
    final contact = _phoneNumberController.text;
    final businessname = _businessNameController.text;
    final city = _cityController.text;
    final aboutus=_aboutUscontroller.text;
    var image = _image;
  

    try {
    bool val=  await Provider.of<AuthProvider>(context, listen: false).resllerregister(
        owernername,
        businessname,
        city,
        email,
        contact,
        password,
        address,
        aboutus,
        image,
      );
      return val;
    
    } catch (error) {
    
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred!'),
          content: Text(error.toString()),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
      return false;
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
      body: authProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
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
                              controller: _businessNameController,
                              decoration: InputDecoration(
                                labelText: 'Businessname',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter  Business name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter City';
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
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        suffixIcon: IconButton(onPressed: (){_toggle();}, icon:  Icon(
              // Based on passwordVisible state choose the icon
              _obscureText
               ? Icons.visibility
               : Icons.visibility_off,
               color: Theme.of(context).primaryColorDark,
               ),)
                        
                        ),

                        
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16,),
                      TextFormField(
                        controller: _addressController,
                       // obscureText: true,
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
                      ),
                      SizedBox(height: 16.0),
 TextField(
              controller: _aboutUscontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add text here...',
              ),
              maxLines: 5,
            ),SizedBox(height: 10,),

                     
                     authProvider.isLoading?CircularProgressIndicator():
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        // onPressed: () {
                        //   _singup(context);
                        // },
                        onPressed: ()
                        async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  bool val = await _singup(context);
                                  if (val) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NavigationExample(),
                                      ),
                                    );


//Get.offAll(()=>NavigationExample());
                                  } else {
                                    ///................alert dialogbox...............
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
                        

                        child: Text('Create Account',style: TextStyle(color: Colors.white),),
                      ),
                      Row(
                        children: [
                          Text("Already have an account?"),
                          TextButton(
                              onPressed: () =>
                                  Get.to(() => LoginPageReseller()),
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
