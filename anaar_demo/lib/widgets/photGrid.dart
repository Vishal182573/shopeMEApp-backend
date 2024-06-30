import 'dart:math';
import 'package:flutter/material.dart';

class PhotoGrid extends StatelessWidget {
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  //final Function onExpandClicked;

  PhotoGrid({
    required this.imageUrls,
    required this.onImageClicked,
    // required this.onExpandClicked,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index) => Container(
        child: Image(
          image: AssetImage(imageUrls[index]),
          fit: BoxFit.contain,
        ),
        height: 40,
        width: 50,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
    );
  }
}
