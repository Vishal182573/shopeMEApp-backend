import 'package:anaar_demo/screens/chatScreen.dart';
import 'package:anaar_demo/screens/requirement_page.dart';
import 'package:anaar_demo/widgets/photGrid.dart';
import 'package:anaar_demo/widgets/profileTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

List<String> url1 = [
  "assets/images/saree 1.jpeg",
  "assets/images/saree2.jpeg",
  "assets/images/sareev 5.jpeg",
  "assets/images/saree 3.jpeg"
];
List<String> url2 = [
  "assets/images/fur4.jpg",
  "assets/images/fur3.jpg",
  "assets/images/fur2.jpg",
  "assets/images/fur1.jpg"
];
List<String> url3 = [
  "assets/images/decor 2.jpg",
  "assets/images/decor 3.jpg",
  "assets/images/decor1.jpg",
  "assets/images/decor4.jpg"
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopME',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'clothing',
      'Electronic',
      'Medication',
      'others'
    ];
    String selectedCategory = 'clothing';

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          'ShopME',
          style: TextStyle(
              color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          DropdownButton<String>(
            value: selectedCategory,
            icon: Icon(Icons.arrow_drop_down,
                color: const Color.fromARGB(255, 115, 115, 115)),
            underline: Container(),
            onChanged: (String? newValue) {
              selectedCategory = newValue!;
            },
            items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              );
            }).toList(),
          ),
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications, color: Colors.grey),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Handle notifications tap
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Feed'),
            Tab(text: 'Requirements'),
            Tab(text: 'Trending'),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  Center(
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 40,
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                Icons.mail,
                color: Colors.grey,
              ),
              title: const Text('Support'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                Icons.error,
                color: Colors.grey,
              ),
              title: const Text('About Us'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildRequirementsTab(),
          _buildTrendingTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          "Add Requirment",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildFeedTab() {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildShareProduct(),
            _buildPostCard(url1),
            _buildPostCard(url2),
            _buildPostCard(url3),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementsTab() {
    return RequirementsPage();
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [Text("Trending"), Divider()],
          ),
          _buildPostCard(url1),
          _buildPostCard(url2),
          _buildPostCard(url3)
        ],
      ),
    );
  }

  Widget _buildShareProduct() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Share your Product.....',
        ),
      ),
    );
  }

  Widget _buildPostCard(List<String> url) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Profiletile(
              Location: "Delhi",
              ProfileName: "vijay Sarees",
              Imagepath: "assets/images/manufacturer 1.jpeg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Premium sarees on the affordable prices with a range of variety. Best deal in the market.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 250,
            child: PhotoGrid(
              imageUrls: url,
              onImageClicked: (i) => print('Image $i was clicked!'),
              // onExpandClicked: () => print('Expand Image was clicked'),
              //maxImages: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.red),
                  onPressed: () {},
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Comments'),
                ),
                TextButton(
                  onPressed: () => Get.to(() => ChatScreen()),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Notification'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
