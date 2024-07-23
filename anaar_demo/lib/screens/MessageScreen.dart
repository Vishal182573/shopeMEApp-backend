import 'package:flutter/material.dart';

class Messagescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        backgroundColor: Colors.red,
        elevation: 20,
      ),
      body: Center(
        child: Text(
          "No Messages Yet!!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

      ),
    );
  }
}
