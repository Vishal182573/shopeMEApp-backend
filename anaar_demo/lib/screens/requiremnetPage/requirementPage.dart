import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/Requirement_model.dart';
import 'package:anaar_demo/providers/RequirementProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequirementPostScreen extends StatefulWidget {
  @override
  _RequirementScreenState createState() => _RequirementScreenState();
}

class _RequirementScreenState extends State<RequirementPostScreen> {
  String selectedProduct = 'saree';
  int quantity = 70;
  String totalValue = '1000';
  TextEditingController productController =
      TextEditingController(text: 'saree');
TextEditingController categorycontroller=TextEditingController();
TextEditingController Quantitycontroller=TextEditingController();
TextEditingController detailscontroller=TextEditingController();
TextEditingController pricecontroller=TextEditingController();
  List<File> attachedImages = [];
  String? loggedInUserId;
String? userType;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loaduserid();
  }

 void _loaduserid()async{
 
 loggedInUserId=await Helperfunction.getUserId();
   final prefs = await SharedPreferences.getInstance();
   // userId = prefs.getString('userId');
    userType = prefs.getString('userType');
 

 } 


void _upload(){
print(productController.text);
print(categorycontroller.text);
print(loggedInUserId);
print(Quantitycontroller.text);
print(detailscontroller.text);
print(userType);
print(pricecontroller.text);
Requirement  req=Requirement(userId: loggedInUserId??'', 
productName: productController.text??'', 
category:categorycontroller.text??'' , quantity: quantity??'', 
totalPrice: pricecontroller.text??'',
 details: detailscontroller.text??'', images:[],
userType: userType??''
);

Provider.of<RequirementProvider>(context,listen: false).postrequiremnetwithimage(req, attachedImages).
then((_){
  Navigator.of(context).pop();
}).catchError((onError)
{ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(onError.toString())));
      });
;


}
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        attachedImages.add(File(image.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reqprovide=Provider.of<RequirementProvider>(context);
    
    return reqprovide.isLoading?Container(color: Colors.white.withOpacity(0.1),child: Center(child: CircularProgressIndicator(),),):
    
    Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Requirement'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('What Product do You want to buy?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: productController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter product name',
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children:
                  ['saree', 'Langha', 'Kurta', 'Penta'].map((String product) {
                return ChoiceChip(
                  label: Text(product),
                  selected: selectedProduct == product,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedProduct = product;
                      productController.text = product;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text('Quantity Required?',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                    Expanded(
                      child: Text('category?',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    )
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: Quantitycontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '70',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: categorycontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'category',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['1-10', '100-200', '500-900'].map((String range) {
                return Chip(label: Text(range));
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('Total value?*',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: pricecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixText: '₹ ',
                hintText: '1000',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text('Add more detail about the product to get quick response*',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: detailscontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add text here...',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            Text('Attach Images',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.attach_file),
                  label: Text('Attach Image'),
                  onPressed: _pickImage,
                ),
              ],
            ),
            SizedBox(height: 8),
            if (attachedImages.isNotEmpty)
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: attachedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Stack(
                        children: [
                          Image.file(
                            attachedImages[index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  attachedImages.removeAt(index);
                                });
                              },
                              child: Container(
                                color: Colors.white,
                                child: Icon(Icons.close, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          child: Text('POST'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            // Handle post action
            _upload();
          },
        ),
      ),
    );
  }
}
