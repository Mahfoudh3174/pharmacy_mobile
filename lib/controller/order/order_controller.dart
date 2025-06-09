
import 'package:ecommerce/view/screen/order/order_pending.dart';
import 'package:ecommerce/view/screen/order/order_valid.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OrderViewController extends GetxController {
  changePage(int index);

}

class OrderViewControllerImp extends OrderViewController {
  int currentIndex = 0;
  List<Widget> pages = [const OrdersPending(), const OrderValidated()];
  List<String> pageTitles = ["Commandes en attente", "Commandes reçues"];
  List<Map<String, IconData>> bottomItems = [
    {"icon": Icons.checklist_rtl_outlined},
    {"icon": Icons.pending_actions_outlined},
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
  

}
