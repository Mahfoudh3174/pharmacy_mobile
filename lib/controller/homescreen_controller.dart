import 'package:ecommerce/controller/order/order_controller.dart';
import 'package:ecommerce/controller/pharmacy/pharmacy_controller.dart';
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
  List<Widget> pages = [
    const PharmacieView(),
    const SettingView(),
    const OrderView(),
  ];

  List<Map<String, dynamic>> bottomItems = [
    {"icon": Icons.home_outlined, "title": "home"},
    {"icon": Icons.settings_outlined, "title": "settings"},
    {"icon": Icons.view_list_outlined, "title": "orders"},
  ];

  @override
  void changePage(int index) {
    currentIndex = index;

    // Reinitialize controller for each page
    switch (index) {
      case 0:
        Get.delete<PharmacyControllerImp>();
        Get.put(PharmacyControllerImp());
        break;
      case 1:
        // If you have a controller for setting view, reset it
        break;
      case 2:
        Get.delete<OrderViewControllerImp>();
        Get.put(OrderViewControllerImp());
        break;
    }

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
