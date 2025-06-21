
import 'package:ecommerce/controller/order/order_rejected_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/view/widget/order/orders_list_card.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class OrderRejected extends StatelessWidget {
  const OrderRejected({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OrderRejectedController());
    return  Container(
          padding:const  EdgeInsets.all(10),
          child: GetBuilder<OrderRejectedController>(
              builder: ((controller) => RefreshIndicator(
                onRefresh: () => controller.getRejectedOrders(),
                child: HandlingDataView(statusRequest: controller.statusRequest, widget: ListView.builder(
                      itemCount: controller.ordersList.length,
                      itemBuilder: ((context, index) =>
                          CardOrdersList(listdata: controller.ordersList[index])),
                    )),
              ))),
        );
  }
}