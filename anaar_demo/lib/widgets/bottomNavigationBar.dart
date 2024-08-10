import 'package:anaar_demo/screens/MessageScreen.dart';
import 'package:anaar_demo/screens/discoverPage.dart';
import 'package:anaar_demo/screens/homepage.dart';
import 'package:anaar_demo/screens/profiles/ConsumerprofilePage.dart';
import 'package:anaar_demo/screens/profiles/ResellerProfilepage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  String? userType = '';
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserType();
  }

  Future<void> _loadUserType() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.getString('userType');
      userId = prefs.getString('userId');
    });
    print("$userType.................................");
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            // selectedIcon: Icon(Iconsax.home1),
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Iconsax.search_normal),
            icon: Icon(Iconsax.search_normal),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              
              child: Icon(Iconsax.message),
            ),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Iconsax.profile_2user),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        HomePage(),
        SearchCatalogScreen(),
        MessageListScreen(),
        userType == "reseller" ? ResellerProfilePage() : Consumerprofilepage(),
      ][currentPageIndex],
    );
  }
}
