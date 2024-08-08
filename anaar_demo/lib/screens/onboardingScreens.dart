import 'package:anaar_demo/controller/onBoardingController.dart';
import 'package:anaar_demo/screens/Auth/Login_reseller.dart';
import 'package:anaar_demo/screens/Auth/Signup_reseller.dart';
import 'package:anaar_demo/screens/Auth/singup_consumer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

var boradingcontorller = Get.put(onboradingContorller());

class onboardingScreen extends StatefulWidget {
  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {
  @override
  Widget build(BuildContext context) {
    //  bool dark = THelperFunctions.isDarkMode(context);
    // TODO: implement build
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: boradingcontorller.pageController,
          children: [
            boradingScreen(
              "assets/images/grow_bussiness.gif",
              "Grow Your Business with Us",
              "Join us Grow your business journey with us.Get connected with new People",
            ),
            boradingScreen(
                "assets/images/business.gif",
                "Make new Contacts and Find new Businesses",
                "Make new connection .Find and Explore different business.Make your choice and your own requirement"),
            onboardingLoginPage(),
          ],
        ),
//skip button
        Positioned(
            top: 28,
            right: 10,
            child: TextButton(
                onPressed: () => boradingcontorller.onSkip(),
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.blue),
                ))),

        //smooth Page indicator (dot navigator)

        Positioned(
            bottom: 30,
            left: 10,
            child: SmoothPageIndicator(
                effect: ExpandingDotsEffect(
                    activeDotColor: Colors.red, dotWidth: 8, dotHeight: 6),
                controller: boradingcontorller.pageController,
                onDotClicked: boradingcontorller.dotNavigatorClick,
                count: 3)),
        //skip arrow butoom
        onboardingCirluarbutton(),
      ]),
    );
  }
}

class boradingScreen extends StatelessWidget {
  final String image;
  final String Title;
  final String sutile;

  boradingScreen(
    this.image,
    this.Title,
    this.sutile,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        children: [
          Image(
            image: AssetImage(image),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          Text(
            Title,
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Text(
            sutile,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class onboardingCirluarbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //bool dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: 30,
        right: 10,
        child: ElevatedButton(
            onPressed: () => boradingcontorller.nexpage(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: CircleBorder(),
                fixedSize: Size.fromRadius(34)),
            child: const Icon(
              Iconsax.arrow_right_3,
              color: Colors.white,
              size: 25,
            )));
  }
}

class onboardingLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Image(
            image: AssetImage("assets/images/getinContactwithUS.gif"),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          Text(
            "Connect and Start your Journey",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => Get.to(() => ConsumerRegistrationPage()),
            child: Text(
              "Register as Consumer",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, fixedSize: Size(280, 40)),
          ),
          Divider(
            indent: 40,
            endIndent: 40,
            color: Colors.black,
            thickness: 0.5,
          ),
          ElevatedButton(
            onPressed: () => Get.to(() => ResellerRegistrationPage()),
            child: Text(
              "Register as supplier",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, fixedSize: Size(280, 40)),
          ),
        ],
      ),
    );
  }
}
