import 'package:ecommerce/controller/cart/add_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/cart/custom_button_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavgationBarCart extends GetView<CartControllerImp> {
  final String price;
  final String shipping;
  final String totalprice;
  const BottomNavgationBarCart({
    super.key,
    required this.price,
    required this.shipping,
    required this.totalprice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("price", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("${controller.totalPrice} \$", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('shipping', style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("300 \$", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Total Price",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "$totalprice \$",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        CustomButtonCart(
          textbutton: "Place Order",
          onPressed: () {
            controller.getMedicationFromCart();
          },
        ),
      ],
    );
  }
}
