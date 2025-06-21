import 'package:ecommerce/controller/order/order_valid_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/view/widget/order/orders_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class OrderValidated extends StatelessWidget {
  const OrderValidated({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ValidOrdersController());
    return Container(
          padding:const  EdgeInsets.all(10),
          child: GetBuilder<ValidOrdersController>(
              builder: ((controller) => HandlingDataView(statusRequest: controller.statusRequest, widget: ListView.builder(
                    itemCount: controller.ordersList.length,
                    itemBuilder: ((context, index) =>
                        CardOrdersList(listdata: controller.ordersList[index])),
                  )))),
        );
  }
}