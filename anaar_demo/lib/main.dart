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
import 'package:provider/provider.dart';
  // Import notification service

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestNotificationPermission();
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
