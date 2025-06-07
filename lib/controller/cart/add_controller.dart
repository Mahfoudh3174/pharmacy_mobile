import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/cart/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  addMedicationToCart(int medicationId);
  deleteMedicationFromCart(int medicationId);
  getMedicationFromCart();
  getCountItems(int id);
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
        update();
      } else {
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
    try {
      statusRequest = StatusRequest.loading;
      update();
      final response = cartData.deleteCartData(medicationId);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        debugPrint("====medication $medicationId deleted");
      }
    } catch (e) {
      debugPrint("====medication $medicationId not deleted");
    }
    update();
  }

  @override
  getMedicationFromCart() {
    // TODO: implement getMedicationFromCart
    throw UnimplementedError();
  }

  @override
  Future<int> getCountItems(int id) async {
    int medicationsCount = 0;

    try {
      final response = await cartData.getCountCart(id);

      debugPrint("==controller count show ${response['count'].runtimeType}");
      medicationsCount = response['count'];
      debugPrint("====medication count found $medicationsCount");
    } catch (e) {
      debugPrint("====medication count not found ${e.toString()}");
    }
    return medicationsCount;
  }
}
