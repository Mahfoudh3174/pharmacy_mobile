import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/static.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OnboarderController extends GetxController {
  next();
  onPageChanged(int index);

}

class OnboarderControllerImp extends OnboarderController {
  int currentPage = 0;
  late PageController pageController;
  Myservice storage = Get.find();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  next() {
    if (currentPage < onBoardingData.length - 1) {
      currentPage++;
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      update();
    } else {
    debugPrint("Next Page: $currentPage");
      storage.sharedPreferences.setBool("onBoarding", true);
      Get.offAllNamed(Routes.signUp);
    }
    debugPrint("Next Page: $currentPage");

    
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    debugPrint("Current Page: $currentPage");
    update();
    
  }
}
