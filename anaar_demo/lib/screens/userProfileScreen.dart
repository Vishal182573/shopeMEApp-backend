import 'package:flutter/material.dart';

class ResellerProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              _buildHeader(context),
              _buildProfileInfo(),
              _buildStatistics(),
              _buildAboutSection(),
              _buildActionButtons(),
              _buildTabBar(),
              _buildProductGrid(),
            ],
          ),
          Positioned(
            top: 140,
            left: 140,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.yellow[200],
              child: Text('RV',
                  style: TextStyle(fontSize: 30, color: Colors.black)),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: Image.asset(
            'assets/images/manufacturer 2.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: EdgeInsets.only(top: 60, bottom: 20),
      child: Column(
        children: [
          Text('Vijay sarees',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Manufacturers . Delhi', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('147:Product details',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 20),
          Text('69:Connection', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
              'saree with a fine work and hand crafted with skilled labours dicpict.we are mumbai based saree interprse and trading ferm......'),
          TextButton(
            child: Text('More'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.person_add),
          label: Text('Connect'),
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
        OutlinedButton(
          child: Text('Chat'),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return DefaultTabController(
      length: 3,
      child: TabBar(
        tabs: [
          Tab(text: 'Products'),
          Tab(text: 'Posts'),
          Tab(text: 'About'),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: [
        _buildProductItem('assets/images/sareev 5.jpeg'),
        _buildProductItem('assets/images/saree2.jpeg'),
        _buildProductItem('assets/images/saree 1.jpeg'),
        _buildProductItem('assets/images/saree 3.jpeg'),
      ],
    );
  }

  Widget _buildProductItem(String imagePath) {
    return Card(
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}
