import 'package:anaar_demo/screens/Auth/Login_reseller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class onboradingContorller extends GetxController {
  var currenPage = 1.obs;
  var pageController = PageController();
  final storage = GetStorage();

  void updatePageIndicator(index) {
    currenPage.value = index;
  }

  void dotNavigatorClick(index) {
    currenPage.value = index;
    pageController.jumpToPage(index);
  }

  void nexpage() {
    if (currenPage.value == 3) {
      storage.write('isFirttime', false);
      pageController.jumpToPage(currenPage.value);
    } else {
      pageController.jumpToPage(currenPage.value++);
    }
  }

  void onSkip() {
    currenPage.value = 3;
    pageController.jumpToPage(currenPage.value);
  }
}
