import 'package:anaar_demo/screens/userProfileScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String url = "assets/images/saree 4.jpeg";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Discover'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: Icon(Icons.filter_list),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Explore Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryCard(
                      title: "kurti",
                      imagePath: "assets/images/kurti.jpeg",
                      CategoryType: "Clothes",
                    ),
                    CategoryCard(
                      title: "kurti",
                      imagePath: "assets/images/ElectroniceItems.jpg",
                      CategoryType: "Electical",
                    ),
                    CategoryCard(
                      title: "kurti",
                      imagePath: "assets/images/furniture.jpg",
                      CategoryType: "furniture",
                    ),
                    CategoryCard(
                      title: "kurti",
                      imagePath: "assets/images/decor1.jpg",
                      CategoryType: "Home Decor",
                    )
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Business Nearby',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: NearbyBusinessCard(
                        title: 'vijay sarees',
                        subtitle: 'Reseller',
                        imagePath: 'assets/images/manufacturer 1.jpeg',
                        brandlogo: 'assets/images/clothes logo.jpeg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: NearbyBusinessCard(
                        title: 'Furnitures',
                        subtitle: 'Reseller',
                        imagePath: 'assets/images/fur1.jpg',
                        brandlogo: 'assets/images/clothes logo  2.jpeg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: NearbyBusinessCard(
                        title: 'Dharma Electronics',
                        subtitle: 'Reseller',
                        imagePath: 'assets/images/ElectroniceItems.jpg',
                        brandlogo: 'assets/images/clothes logo.jpeg',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String CategoryType;

  const CategoryCard(
      {required this.title,
      required this.imagePath,
      required this.CategoryType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        Container(
          width: 120,
          height: 150,
          //color: Colors.amber,
          child: Image(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
        Container(
          height: 150,
          width: 120,
          color: Colors.black.withOpacity(0.3),
        ),
        Positioned(
          top: 50,
          left: 35,
          child: Text(
            CategoryType,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}

class NearbyBusinessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String brandlogo;

  const NearbyBusinessCard(
      {required this.title,
      required this.subtitle,
      required this.imagePath,
      required this.brandlogo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ResellerProfilePage()),
      child: Container(
        width: 250,
        height: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 4.0, spreadRadius: 2)
            ]),
        child: Stack(children: [
          Column(
            children: [
              Container(
                height: 150,
                width: 250,
                child: Container(
                  child: Image(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(subtitle,
                  style: TextStyle(
                    fontSize: 15,
                  ))
            ],
          ),
          Positioned(
              top: 90,
              left: 85,
              child: Container(
                height: 70,
                width: 70,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Image(
                    image: AssetImage(brandlogo),
                    fit: BoxFit.contain,
                  ),
                ),
                decoration: BoxDecoration(
                  // color: Colors.red,
                  shape: BoxShape.circle,
                ),
              )),
        ]),
      ),
    );
  }
}
