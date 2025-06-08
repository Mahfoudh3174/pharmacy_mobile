
import 'package:ecommerce/controller/order/order_pending_controller.dart';
import 'package:ecommerce/core/constant/color.dart';

import 'package:ecommerce/data/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class CardOrdersList extends GetView<OrdersPendingController> {
  final Order listdata;
  const CardOrdersList({super.key, required this.listdata});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Order Number : #${listdata.id}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  // Text(listdata.ordersDatetime!)
                  Text(
                    Jiffy.parse(listdata.createdAt.toString() ).fromNow(),
                    style: const TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(),
              Text(
                  "Order Type : ${listdata.type}"),
              Text("Order Price : ${listdata.totalAmount} \$"),
              Text("Delivery Price : NAN MRU "),
              Text(
                  "Order Status : ${listdata.status} "),
              const Divider(),
              Row(
                children: [
                  Text("Total Price : NAN \$ ",
                      style: const TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {
                      // Get.toNamed(AppRoute.ordersdetails,
                      //     arguments: {"ordersmodel": listdata});
                    },
                    color: AppColor.accent,
                    textColor: AppColor.background,
                    child: const Text("Details"),
                  ),
                  SizedBox(width: 10),
                 if (listdata.status == "Received") MaterialButton(
                    onPressed: () {
                      // controller.deleteOrder(listdata.ordersId!);
                    },
                    color: AppColor.errorColor,
                    textColor: AppColor.background,
                    child: const Text("Delete"),
                  )
                ],
              ),
            ],
          )),
    );
  }
}