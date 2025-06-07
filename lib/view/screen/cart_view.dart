import 'package:ecommerce/controller/cart/add_controller.dart';
import 'package:ecommerce/view/widget/cart/buttom_navigation_bar.dart';
import 'package:ecommerce/view/widget/cart/custom_cart_list.dart';
import 'package:ecommerce/view/widget/cart/top_app_bar_cart.dart';
import 'package:ecommerce/view/widget/cart/top_card_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
  CartControllerImp controller = Get.put(CartControllerImp());
    return Scaffold(
      bottomNavigationBar: BottomNavgationBarCart(
        price: "${controller.totalPrice}",
        shipping: "300",
        totalprice: "100"
      ),
      body: ListView(
        children: [
          TopAppbarCart(title: 'My Cart'),
          SizedBox(height: 10),
          TopCardCart(message: "You Have ${controller.totalItems} Items in Your List"),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: const [
                CustomItemsCartList(
                  name: "Macbook M1",
                  price: "1100.0 \$",
                  count: "2",
                ),
                CustomItemsCartList(
                  name: "Macbook M2 Max",
                  price: "2100.0 \$",
                  count: "1",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
