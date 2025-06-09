import 'package:ecommerce/controller/order/order_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/home/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderViewControllerImp());
    return GetBuilder<OrderViewControllerImp>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.primary,
            title: Text(
              controller.pageTitles[controller.currentIndex],
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColor.background),
            ),
          ),
          body: Column(
            children: [
              
              Container(
                color: AppColor.secondary,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    controller.pages.length,
                    (index) => CustomIconButton(
                      onPressed: () {
                        controller.changePage(index);
                      },
                      icon: controller.bottomItems[index]['icon']!,
                      color: controller.currentIndex == index
                          ? AppColor.background
                          : Colors.black,
                    ),
                  ),
                ),
              ),

              // The current page view
              Expanded(
                child: controller.pages[controller.currentIndex],
              ),
            ],
          ),
        );
      },
    );
  }
}
