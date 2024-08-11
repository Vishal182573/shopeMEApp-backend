import 'package:anaar_demo/widgets/GalleryPhotoViewer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class PhotoGrid extends StatelessWidget {
  final List<String> imageUrls;
  final Function(int) onImageClicked;

  PhotoGrid({
    required this.imageUrls,
    required this.onImageClicked,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
    
      builder: (context, constraints) {
        if (imageUrls.length == 1) {
          return GestureDetector(
            onTap: () => _openPhotoViewer(context, 0),
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              child: Image(
                image: NetworkImage(imageUrls[0]),
                fit: BoxFit.cover,
              ),
            ),
          );
        } else if (imageUrls.length == 2) {
          return Row(
            children: imageUrls.asMap().entries.map((entry) {
              int index = entry.key;
              String url = entry.value;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _openPhotoViewer(context, index),
                  child: Container(
                    width: constraints.maxWidth / 2,
                    height: constraints.maxWidth / 2,
                    child: Image(
                      image: NetworkImage(url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        } else if (imageUrls.length == 3) {
          return Column(
            children: [
              GestureDetector(
                onTap: () => _openPhotoViewer(context, 0),
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxWidth / 2,
                  child: Image(
                    image: NetworkImage(imageUrls[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: imageUrls.sublist(1).asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  String url = entry.value;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _openPhotoViewer(context, index),
                      child: Container(
                        width: constraints.maxWidth / 2,
                        height: constraints.maxWidth / 2,
                        child: Image(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        } else {
          return GridView.builder(
          
scrollDirection: Axis.vertical,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => _openPhotoViewer(context, index),
              child: Container(
                child: Image(
                  image: NetworkImage(imageUrls[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            shrinkWrap: true,
            physics: ScrollPhysics(),
          );
        }
      },
    );
  }

  void _openPhotoViewer(BuildContext context, int initialIndex) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PhotoViewer(
    //       imageUrls: imageUrls,
    //       initialIndex: initialIndex,
    //     ),
    //   ),
    // );

    Get.to(()=>PhotoViewer(imageUrls: imageUrls, initialIndex: initialIndex));
  }
}