import 'package:anaar_demo/providers/authProvider.dart';
import 'package:anaar_demo/screens/Auth/singup_consumer.dart';
import 'package:anaar_demo/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginPageConsumer extends StatefulWidget {
  @override
  State<LoginPageConsumer> createState() => _LoginPageConsumerState();
}

class _LoginPageConsumerState extends State<LoginPageConsumer> {
  final _formKey = GlobalKey<FormState>();
  final _emailfieldcontroller = TextEditingController();
  final _passwordfieldcontroller = TextEditingController();
  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final email = _emailfieldcontroller.text;
    final password = _passwordfieldcontroller.text;

    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .Consumer_Login(email, password);
      Get.offAll(() => NavigationExample());
    } catch (error) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred!'),
          content: Text(error.toString()),
        
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log into your Consumer Account',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'your account',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _emailfieldcontroller,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email ID';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordfieldcontroller,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: UnderlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Add your forgot password logic here
                        },
                        child: Text('Forgot Password?'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: 
                      authProvider.isLoading?CircularProgressIndicator():
                      ElevatedButton(
                        onPressed: () {
                          _login(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'LOG IN',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'or log in with',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 20),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/google-icon.png'), // Add your asset image path
                        ),
                        SizedBox(width: 20),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/facebook-icon.png'), // Add your asset image path
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account? ',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Get.to(() => ConsumerRegistrationPage()),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.blue,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
