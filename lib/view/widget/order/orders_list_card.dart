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
                Text(
                  listdata.pharmacy?.name ?? '',
                  style: const TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
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
            Text("${"delivery_price".tr} : NAN MRU"), // Update once dynamic
            Text(
              "${"status".tr} : ${listdata.status}",
              style: const TextStyle(
                color: AppColor.warningColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  "${"total_price".tr} : ${listdata.totalAmount} MRU",
                  style: const TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                MaterialButton(
                  onPressed: () {
                    controller.goToOrderDetails(listdata);
                  },
                  color: AppColor.accent,
                  textColor: AppColor.background,
                  child: Text("details".tr),
                ),
                const SizedBox(width: 10),
                if (listdata.status == "ENCOURS")
                  MaterialButton(
                    onPressed: () {
                      controller.deleteOrder(listdata.id);
                    },
                    color: AppColor.errorColor,
                    textColor: AppColor.background,
                    child: Text("delete".tr),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
