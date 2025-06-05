import 'package:ecommerce/controller/homescreen_controller.dart';
import 'package:ecommerce/view/widget/home/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Action for the floating action button
            },
            child: const Icon(Icons.shopping_cart_checkout_outlined),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            notchMargin: 10,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Left side buttons
                CustomIconButton(
                  onPressed: () {
                    controller.changePage(0);
                  },
                  icon: Icons.home_outlined,
                  color: controller.currentIndex == 0 ? Colors.blue :Colors.black,
                ),

                // Spacer to create space for FAB
                const SizedBox(width: 40),

                // Right side buttons
                CustomIconButton(
                  onPressed: () {},
                  icon: Icons.settings,
                  color: controller.currentIndex == 1 ? Colors.blue :Colors.black,
                ),
              ],
            ),
          ),

          body: controller.pages[controller.currentIndex],
        );
      },
    );
  }
}
