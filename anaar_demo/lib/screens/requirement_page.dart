import 'package:anaar_demo/screens/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequirementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Customers Requirements'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          OrderCard(
            ProfilImage: "assets/images/tv3.jpg",
            businessName: 'Vijay Electronics',
            businessType: 'Manufacturers',
            location: 'Delhi',
            postedTime: '2 days ago',
            productName: 'LG TV',
            category: 'Electronic',
            quantity: '15 Pcs',
            totalPrice: '₹10,50,000/-',
            moreDetails:
                'We are an Electronic items resellers. We need 15 pcs of LG TV. Any authenticated dealer can connect with us for more further enquiries.',
            images: [
              'assets/images/tv1.jpg',
              'assets/images/tv3.jpg',
              'assets/images/tv2.jpg',
            ],
          ),
          OrderCard(
            ProfilImage: "assets/images/pents.jpeg",
            businessName: 'Laxmi Textiles',
            businessType: 'Manufacturers',
            location: 'Delhi',
            postedTime: '2 days ago',
            productName: 'Product Name',
            category: 'Textile',
            quantity: '200',
            totalPrice: '1,00,000',
            moreDetails:
                'We are a clothig /Textile company .we need varansi saree with high quality.',
            images: [
              'assets/images/saree 4.jpeg',
              'assets/images/saree2.jpeg',
              'assets/images/saree 3.jpeg',
            ],
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String businessName;
  final String businessType;
  final String location;
  final String postedTime;
  final String productName;
  final String category;
  final String quantity;
  final String totalPrice;
  final String moreDetails;
  final String ProfilImage;
  final List<String> images;

  const OrderCard({
    required this.businessName,
    required this.businessType,
    required this.location,
    required this.postedTime,
    required this.productName,
    required this.category,
    required this.quantity,
    required this.totalPrice,
    required this.moreDetails,
    required this.images,
    required this.ProfilImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(ProfilImage),
              ),
              title: Text(businessName),
              subtitle: Text('$businessType • $location'),
              trailing: TextButton(
                onPressed: () {},
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text('Product Details:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('Product Name: $productName'),
            Text('Category: $category'),
            Text('QTY: $quantity'),
            Text('Total Price: $totalPrice'),
            SizedBox(height: 8.0),
            Text('More Details:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(moreDetails),
            SizedBox(height: 8.0),
            Text('Attached Images:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: images.map((image) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset(image, width: 100, height: 100),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.connect_without_contact),
                  label: Text('Connect'),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () => Get.to(ChatScreen()),
                  icon: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
