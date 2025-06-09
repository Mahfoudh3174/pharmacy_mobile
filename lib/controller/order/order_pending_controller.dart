

import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/order/order_data.dart';
import 'package:ecommerce/data/model/order_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class  OrdersPendingController extends GetxController{

OrderData orderData=OrderData(Get.find());
  List<Order> ordersList=[];
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {

    getPendingOrdersData();
    super.onInit();
  }

getPendingOrdersData() async {
  try {
    statusRequest = StatusRequest.loading;
    update();

    var response = await orderData.getOrdersData(status: "ENCOURS");

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      for(var element in response["orders"]){
        debugPrint(element.toString());
        ordersList.add(Order.fromJson(element));
      }
      if (ordersList.isEmpty) {
        statusRequest = StatusRequest.failure;
      }
      // List orders = response["orders"];
      // ordersList = orders.map((e) => Order.fromJson(e)).toList();
    } else {
      statusRequest = StatusRequest.failure;
    }
  } catch (e) {
    // Optional: Print/log error
    print("Error in getPendingOrdersData: $e");
    statusRequest = StatusRequest.serverException;
  }

  update();
}

goToOrderDetails(Order order) {
  
    Get.toNamed(Routes.ordersdetails, arguments: {"order": order});
  
}

  deleteOrder(int orderid) async {
    try{
    ordersList.clear();
    statusRequest = StatusRequest.loading;
    update();
     await orderData.deleteData(orderid);

    statusRequest= StatusRequest.success;

        refrehOrder();
    }
    catch(e){
    
      statusRequest = StatusRequest.serverException;
    }

    update();
  }

  refrehOrder() {
    getPendingOrdersData();
  }
}