import 'package:anaar_demo/backend/notification_services.dart';
import 'package:anaar_demo/backend/permissionhandleer.dart';
import 'package:anaar_demo/providers/RequirementProvider.dart';
import 'package:anaar_demo/providers/TrendingProvider.dart';
import 'package:anaar_demo/providers/authProvider.dart';
import 'package:anaar_demo/providers/catelogProvider.dart';
import 'package:anaar_demo/providers/chat_provider.dart';
import 'package:anaar_demo/providers/commentProvider.dart';
import 'package:anaar_demo/providers/commonuserdataprovider.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/Auth/Login_reseller.dart';
import 'package:anaar_demo/screens/Auth/Signup_reseller.dart';
import 'package:anaar_demo/screens/chatScreen.dart';
import 'package:anaar_demo/screens/discoverPage.dart';
import 'package:anaar_demo/screens/homepage.dart';
import 'package:anaar_demo/screens/onboardingScreens.dart';
import 'package:anaar_demo/screens/requirement_page.dart';
import 'package:anaar_demo/screens/resellerShowProfile.dart';
import 'package:anaar_demo/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
  // Import notification service
void main()async{
 await Hive.initFlutter();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the NotificationService
    final NotificationService notificationService = NotificationService();
NotificationService.initNotification();

    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthProvider()..tryAutoLogin()), // Handles authentication
        ChangeNotifierProvider(create: (context) => UserProvider()), // Handles user data
        ChangeNotifierProvider(create: (context) => CommentProvider()), // Handles comments
        ChangeNotifierProvider(create: (context) => CommenUserProvider()), // Common user data provider
        ChangeNotifierProvider(
          create: (context) => RequirementProvider(), // Handles requirements
        ),
        ChangeNotifierProvider(create: (context) => PostcardProvider()), // Handles post cards
        ChangeNotifierProvider(create: (context) => RequirementcardProvider()), // Handles requirement cards
        ChangeNotifierProvider(create: (context) => PostProvider()), // Handles posts
        ChangeNotifierProvider(create: (context) => Trendingprovider()), // Handles trending items
        ChangeNotifierProvider(create: (context) => CatelogProvider()), // Handles catalog
        ChangeNotifierProvider(create: (context) => ChatProvider()), // Handles chat
      ],
      child: GetMaterialApp(
        title: 'Registration Form',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Poppins',
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.isAuth) {
              // If the user is authenticated, navigate to the main screen
              return NavigationExample();
            } else {
              // If the user is not authenticated, show the onboarding screen
              return onboardingScreen();
            }
          },
        ),
      ),
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 4), () {
      // After the delay, check authentication status and navigate accordingly
      final authProvider = Provider.of<AuthProvider>(context, listen: false)..tryAutoLogin();
      if (authProvider.isAuth) {
        // If the user is authenticated, navigate to the main screen
        Get.off(() => NavigationExample());
      } else {
        // If the user is not authenticated, show the onboarding screen
        Get.off(() => onboardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 200,
              height: 200, // Adjust the height as needed
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/welcome.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('"App for all your cab needs"', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
