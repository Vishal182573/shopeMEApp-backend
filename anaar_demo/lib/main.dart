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
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthProvider()..tryAutoLogin()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CommentProvider()),
        ChangeNotifierProvider(create: (context) => CommenUserProvider()),
        ChangeNotifierProvider(
          create: (context) => RequirementProvider(),
        ),
        ChangeNotifierProvider(create: (context) => PostcardProvider()),
        ChangeNotifierProvider(create: (context) => RequirementcardProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider()),
        ChangeNotifierProvider(create: (context) => Trendingprovider()),















        
        ChangeNotifierProvider(create: (context) => CatelogProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        
      ],
      child: GetMaterialApp(
        title: 'Registration Form',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.isAuth) {
              return NavigationExample();
            } else {
            
              return onboardingScreen();

            
            }
          },
        ),
      ),
    );
  }
}
