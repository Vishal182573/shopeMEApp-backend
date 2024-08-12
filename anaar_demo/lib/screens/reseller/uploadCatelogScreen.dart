import 'dart:io';

import 'package:anaar_demo/model/catelogMode.dart';
import 'package:anaar_demo/providers/catelogProvider.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// class UploadPostScreen extends StatefulWidget {
//   // String? userId;
//   // UploadPostScreen({required this.userId});

//   @override
//   _UploadPostScreenState createState() => _UploadPostScreenState();
// }

// class _UploadPostScreenState extends State<UploadPostScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? userId;
//   String? userType;
//   //final  _userid = TextEditingController();
//   final _description = TextEditingController();
//   final _category = TextEditingController();
//   List<File> _images = [];

//   Future<void> _pickImage() async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         if (_images.length < 4) {
//           _images.add(File(pickedImage.path));
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('You can only upload up to 4 images')));
//         }
//       });
//     }
//   }

//   Future<void> getuserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     userId = prefs.getString('userId');
//     userType = prefs.getString('userType');
//   }

//   void _uploadPost() async {
//     // String? userId = await Helperfunction.getUserId();
//     print('$userId++++++++++++++++++++++++++');
//     print('$userType++++++++++++++++');
//     print(_category.text);
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       Post post = Post(
//           userid: userId,
//           description: _description.text,
//           category: _category.text,
//           likes: [],
//           comments: [],
//           images: [],
//           userType: userType);

//       Provider.of<PostProvider>(context, listen: false)
//           .uploadPostWithImages(post, _images)
//           .then((_) {
//         Navigator.of(context).pop();
//       }).catchError((error) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(error.toString())));
//       });
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getuserId();
//     //_loadUserId();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<PostProvider>(context);
//     return Scaffold(
//       appBar: AppBar(title: Text('Upload Post')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child:  Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _description,
//                       decoration: InputDecoration(labelText: 'Description'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'please enter description';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: _category,
//                       decoration: InputDecoration(labelText: 'Category'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter category';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: _pickImage,
//                       child: Text('Pick Images'),
//                     ),
//                     SizedBox(height: 10),
//                     Wrap(
//                       spacing: 8.0,
//                       runSpacing: 8.0,
//                       children: _images.map((image) {
//                         return Stack(
//                           children: [
//                             Image.file(image,
//                                 width: 100, height: 100, fit: BoxFit.cover),
//                             Positioned(
//                               right: 0,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _images.remove(image);
//                                   });
//                                 },
//                                 child: Container(
//                                   color: Colors.black54,
//                                   child: Icon(Icons.close, color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                     SizedBox(height: 20),
//              authProvider.isLoading
//             ? CircularProgressIndicator()
//             :       ElevatedButton(
//                       onPressed: _uploadPost,
//                       child: Text('Upload Post'),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

class CatelogUploadScreen extends StatefulWidget {
  String? userid;
  CatelogUploadScreen({required this.userid});
  @override
  _CatelogUploadScreenState createState() => _CatelogUploadScreenState();
}

class _CatelogUploadScreenState extends State<CatelogUploadScreen> {
  TextEditingController _productName = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<File> _imageFiles = [];

  void _uploadcatelog() {
    final productName = _productName.text;
    final category = _category.text;
    final price = _price.text;
    final descp = _description.text;

    Catelogmodel cateog = Catelogmodel(
      productName: productName??'',
      userId: widget.userid??'',
      category: category??'',
      images: [],
      description: descp??'',
      price: price??'',
    );
    Provider.of<CatelogProvider>(context, listen: false)
          .uploadCatelogWithImages(cateog, _imageFiles)
          .then((_) {
        Navigator.of(context).pop();
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final catelogProvider= Provider.of<CatelogProvider>(context);
    return
  catelogProvider.isLoading?
       Stack(children: [Container(color: Colors.black.withOpacity(0.1),),Center(child: CircularProgressIndicator(),)],)
       :    
    
     Scaffold(
      appBar: AppBar(
        title: Text("Upload Catalogue"),
      ),
      body:
      
       SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: _imageFiles.isNotEmpty
                    ? Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(
                            _imageFiles[index],
                            fit: BoxFit.cover,
                          );
                        },
                        itemCount: _imageFiles.length,
                        pagination: SwiperPagination(),
                        control: SwiperControl(),
                      )
                    : Center(child: Text("No images selected")),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: Colors.grey, width: 2, style: BorderStyle.solid),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _pickImage,
                child: Text("Upload Image"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                "Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _productName,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide()),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _category,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide()),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _price,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide()),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Product Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                    height: 100,
                    child: TextFormField(
                      controller: _description,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Text here............",
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide()),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product description';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {_uploadcatelog();},
        child: Container(
          height: 40,
          color: Colors.blue,
          child: Center(
            child: Text(
              "Upload Catelogue",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
