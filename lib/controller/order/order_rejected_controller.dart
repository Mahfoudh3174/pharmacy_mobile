import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/order/order_data.dart';
import 'package:ecommerce/data/model/order_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRejectedController extends GetxController {
  OrderData orderData = OrderData(Get.find());
  List<Order> ordersList = [];
  StatusRequest statusRequest = StatusRequest.none;
  
  // Pagination variables
  int currentPage = 1;
  int lastPage = 1;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  @override
  void onInit() {
    debugPrint("onInit");
    getRejectedOrders();
    super.onInit();
  }

  getRejectedOrders() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      var response = await orderData.getOrdersData(status: "REJETEE", page: 1);

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        final orderResponse = OrderResponse.fromJson(response);
        ordersList = orderResponse.orders;
        currentPage = orderResponse.meta.currentPage;
        lastPage = orderResponse.meta.lastPage;
        hasMoreData = orderResponse.meta.hasNextPage;
        
        if (ordersList.isEmpty) {
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      // Optional: Print/log error
      statusRequest = StatusRequest.serverException;
    }

    update();
  }

  loadMoreOrders() async {
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    update();

    try {
      var response = await orderData.getOrdersData(
        status: "REJETEE", 
        page: currentPage + 1
      );

      if (response is Map<String, dynamic> && response.containsKey('orders')) {
        final orderResponse = OrderResponse.fromJson(response);
        ordersList.addAll(orderResponse.orders);
        currentPage = orderResponse.meta.currentPage;
        lastPage = orderResponse.meta.lastPage;
        hasMoreData = orderResponse.meta.hasNextPage;
      }
    } catch (e) {
      debugPrint("Error loading more orders: ${e.toString()}");
    }

    isLoadingMore = false;
    update();
  }

  goToOrderDetails(Order order) {
    Get.toNamed(Routes.ordersdetails, arguments: {"order": order});
  }

  deleteOrder(int orderid) async {
    try {
      ordersList.clear();
      statusRequest = StatusRequest.loading;
      update();
      await orderData.deleteData(orderid);

      statusRequest = StatusRequest.success;

      refrehOrder();
    } catch (e) {
      statusRequest = StatusRequest.serverException;
    }

    update();
  }

  refrehOrder() {
    getRejectedOrders();
  }
}
