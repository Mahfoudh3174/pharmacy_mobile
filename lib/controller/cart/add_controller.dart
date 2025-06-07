import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/cart/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  addMedicationToCart(int medicationId);
  deleteMedicationFromCart(int medicationId);
  getMedicationFromCart();
}

class CartControllerImp extends CartController {
  StatusRequest statusRequest = StatusRequest.none;
  CartData cartData = CartData(Get.find());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void addMedicationToCart(int productId) async {
    try {
    debugPrint("====medication $productId");

      statusRequest = StatusRequest.loading;
      update();
      final response = await cartData.postCartdata(productId);
      statusRequest = handlingData(response);
      update();

      if (statusRequest == StatusRequest.success) {
        debugPrint("====medication $productId added");
      }else{
        statusRequest = StatusRequest.failure;
        update();
      }
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
      update();
    }
  }

  @override
  deleteMedicationFromCart(int medicationId) {
    throw UnimplementedError();
  }

  @override
  getMedicationFromCart() {
    // TODO: implement getMedicationFromCart
    throw UnimplementedError();
  }
}
