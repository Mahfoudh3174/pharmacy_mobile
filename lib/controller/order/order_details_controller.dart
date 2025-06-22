

import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/data/datasource/remote/order/order_data.dart';
import 'package:ecommerce/data/model/order_model.dart';
import 'package:get/get.dart';

class OrdersDetailsController extends GetxController {
  OrderData ordersDetailsData = OrderData(Get.find());

  // List<CartModel> data = [];

  StatusRequest statusRequest = StatusRequest.none;

  Order? order;

  @override
  void onInit() {
    order = Get.arguments['order'];
    // getData();
    super.onInit();
  }

  // getData() async {
  //   try {
  //     statusRequest = StatusRequest.loading;

  //     var response = await ordersDetailsData.getSingleOrderData(id: order!.id);

  //     statusRequest = handlingData(response);

  //     if (StatusRequest.success == statusRequest) {
  //       // Start backend

  //       order = Order.fromJson(response['order']);


  //       // End
  //     }
  //   } catch (e) {
  //     statusRequest = StatusRequest.failure;
  //     debugPrint("$e=====================");
  //   }
  //   update();
  // }

}
