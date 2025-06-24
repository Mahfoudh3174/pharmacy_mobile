// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/controller/cart/add_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/cart/buttom_navigation_bar.dart';
import 'package:ecommerce/view/widget/cart/custom_cart_list.dart';
import 'package:ecommerce/view/widget/cart/top_card_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    CartControllerImp cartController = Get.put(CartControllerImp());

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'cart'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      bottomNavigationBar: GetBuilder<CartControllerImp>(
        builder:
            (controller) => Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: BottomNavgationBarCart(
                price: "${cartController.totalPrice}",
                shipping: "${cartController.shipping}",
                totalprice:
                    "${cartController.totalPrice + cartController.shipping}",
              ),
            ),
      ),
      body: GetBuilder<CartControllerImp>(
        builder:
            (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Top Card with modern styling
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColor.secondary,
                          AppColor.secondary.withOpacity(0.8),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.secondary.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const TopCardCart(),
                  ),

                  // Cart Items Container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withOpacity(0.05),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: AppColor.primary,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "cart_items".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.primary,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${cartController.cardItems.length}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Cart Items List
                        ...List.generate(
                          cartController.cardItems.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade100,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CustomItemsCartList(
                              imagename:
                                  "${cartController.cardItems[index].medication.imageUrl}",
                              name:
                                  "${cartController.cardItems[index].medication.name}",
                              price:
                                  "${cartController.cardItems[index].medication.price} MRU",
                              count:
                                  "${cartController.cardItems[index].quantity}",
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
