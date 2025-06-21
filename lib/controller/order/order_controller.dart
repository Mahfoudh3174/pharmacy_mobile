import 'package:ecommerce/controller/order/order_pending_controller.dart';
import 'package:ecommerce/controller/order/order_rejected_controller.dart';
import 'package:ecommerce/controller/order/order_valid_controller.dart';
import 'package:ecommerce/view/screen/order/order_pending.dart';
import 'package:ecommerce/view/screen/order/order_rejected.dart';
import 'package:ecommerce/view/screen/order/order_valid.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OrderViewController extends GetxController {
  changePage(int index);
}

class OrderViewControllerImp extends OrderViewController {
  int currentIndex = 0;
  List<Widget> pages = [
    const OrdersPending(),
    const OrderValidated(),
    const OrderRejected(),
  ];
  List<String> pageTitles = [
    "Commandes en attente",
    "Commandes reçues",
    "Commandes rejettées",
  ];
  List<Map<String, IconData>> bottomItems = [
    {"icon": Icons.pending_actions_outlined},
    {"icon": Icons.checklist_rtl_outlined},
    {"icon": Icons.cancel_outlined},
  ];
  @override
  void onInit() {
    changePage(0);
    super.onInit();
  }

  @override
  void changePage(int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        Get.delete<OrdersPendingController>();
        Get.put(OrdersPendingController());
        break;
      case 1:
        Get.delete<ValidOrdersController>();
        Get.put(ValidOrdersController());
        break;
      case 2:
        Get.delete<OrderRejectedController>();
        Get.put(OrderRejectedController());
        break;
    }
    update();
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}
