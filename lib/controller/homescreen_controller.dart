import 'package:ecommerce/view/screen/pharmacie_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int index);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentIndex = 0;
  List<Widget> pages = [
    const PharmacieView(),
    const Center(child: Text("Settings Page")),
  ];
  @override


  @override
  void changePage(int index) {
    currentIndex = index;
    update(); 
    debugPrint("Changing to page: $index");
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}
