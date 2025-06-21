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
                // Pharmacy name
                Expanded(
                  child: Text(
                    listdata.pharmacy?.name ?? '',
                    style: const TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                // Formatted date
                Text(
                  Jiffy.parse(listdata.createdAt.toString()).fromNow(),
                  style: const TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            Text(
              "${"order_reference".tr} : #${listdata.reference}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.errorColor,
              ),
            ),
            Text("${"order_type".tr} : ${listdata.type}"),
            Text("${"order_price".tr} : ${listdata.totalAmount} MRU"),
            Text(
              "${"delivery_price".tr} : ${listdata.shippingPrice} MRU",
            ), // Update once dynamic
            Text(
              "${"status".tr} : ${listdata.status}",
              style: TextStyle(
                color:
                    listdata.status == "ENCOURS"
                        ? AppColor.warningColor
                        : listdata.status == "VALIDEE"
                        ? AppColor.successColor
                        : AppColor.errorColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            // Fixed the problematic Row - using Column for better layout
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${"total_price".tr} : ${listdata.totalAmount! + listdata.shippingPrice!} MRU",
                  style: const TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: MaterialButton(
                        onPressed: () {
                          controller.goToOrderDetails(listdata);
                        },
                        color: AppColor.accent,
                        textColor: AppColor.background,
                        child: Text("details".tr),
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (listdata.status == "ENCOURS")
                      Flexible(
                        child: MaterialButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "delete".tr,
                              content: Text("delete_order".tr),
                              onConfirm: () {
                                controller.deleteOrder(listdata.id);
                                Get.back();
                              },
                              textConfirm: "yes".tr,
                              textCancel: "no".tr,
                            );
                          },
                          color: AppColor.errorColor,
                          textColor: AppColor.background,
                          child: Text("delete".tr),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
