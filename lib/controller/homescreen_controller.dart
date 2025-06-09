import 'package:ecommerce/routes.dart';
import 'package:ecommerce/view/screen/order/order_view.dart';
import 'package:ecommerce/view/screen/pharmacie_view.dart';
import 'package:ecommerce/view/screen/setting/setting_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int index);
  goToCart();
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentIndex = 0;
  List<Widget> pages = [const PharmacieView(), const SettingView(),const OrderView()];
  List<Map<String, IconData>> bottomItems = [
    {"icon": Icons.home_outlined},
    {"icon": Icons.settings_outlined},
    {"icon": Icons.view_list_outlined},
  ];

  @override
  void changePage(int index) {
    currentIndex = index;
    update();
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
  
  @override
  goToCart() {
  
    Get.toNamed(Routes.cart);
  }
}
