import 'package:ecommerce/controller/order/order_pending_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/view/widget/order/orders_list_card.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class OrdersPending extends StatelessWidget {
  const OrdersPending({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OrdersPendingController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
        ),
        body: Container(
          padding:const  EdgeInsets.all(10),
          child: GetBuilder<OrdersPendingController>(
              builder: ((controller) => HandlingDataView(statusRequest: controller.statusRequest, widget: ListView.builder(
                    itemCount: controller.ordersList.length,
                    itemBuilder: ((context, index) =>
                        CardOrdersList(listdata: controller.ordersList[index])),
                  )))),
        ));
  }
}