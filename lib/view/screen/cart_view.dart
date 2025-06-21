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
      appBar: AppBar(
        title: Text(
          'cart'.tr, // key: cart
          style: TextStyle(
            color: AppColor.background,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      bottomNavigationBar: GetBuilder<CartControllerImp>(
        builder:
            (controller) => BottomNavgationBarCart(
              price: "${cartController.totalPrice}",
              shipping: "${cartController.shipping}",
              totalprice:
                  "${cartController.totalPrice + cartController.shipping}",
            ),
      ),
      body: GetBuilder<CartControllerImp>(
        builder:
            (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView(
                children: [
                  SizedBox(height: 10),
                  TopCardCart(
                    message: "cart_items_message".trParams({
                      'count': cartController.totalItems.toString(),
                    }),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ...List.generate(
                          cartController.cardItems.length,
                          (index) => CustomItemsCartList(
                            imagename:
                                "${cartController.cardItems[index].medication.imageUrl}",
                            name:
                                "${cartController.cardItems[index].medication.name}",
                            price:
                                "${cartController.cardItems[index].medication.price} \$",
                            count:
                                "${cartController.cardItems[index].quantity}",
                          ),
                        ),
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
