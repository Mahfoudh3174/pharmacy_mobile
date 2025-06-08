import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/cart/cart_data.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  addMedicationToCart(int medicationId);
  deleteMedicationFromCart(int medicationId);
  getMedicationFromCart();
  goToCheckout();
  resetVariables();
  refreshData();
}

class CartControllerImp extends CartController {
  StatusRequest statusRequest = StatusRequest.none;
  CartData cartData = CartData(Get.find());

  List<Cart> cardItems = [];
  int totalPrice = 0;
  int totalItems = 0;

  // void clearCurrentPharmacy() {
  //   Get.find<Myservice>().sharedPreferences.remove('current_pharmacy_id');
  //   cardItems.clear();
  //   totalPrice = 0;
  //   totalItems = 0;
  //   update();
  // }

  @override
  void onInit() {
    getMedicationFromCart();
    super.onInit();
  }

  @override
  addMedicationToCart(int productId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      final response = await cartData.postCartdata(productId);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        Get.rawSnackbar(
          title: "Notification",
          messageText: const Text(
            "Medication added to cart",
            style: TextStyle(color: Colors.white),
          ),
        );
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
    }
    update();
  }

  @override
  deleteMedicationFromCart(int medicationId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      final response = await cartData.deleteCartData(medicationId);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        Get.rawSnackbar(
          title: "Notification",
          messageText: const Text(
            "Medication removed from cart",
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
    }
    update();
  }

  @override
  getMedicationFromCart() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final response = await cartData.getCartData();
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        cardItems.clear();

        for (var item in response['cartItems']) {
          cardItems.add(Cart.fromJson(item));
        }
        totalPrice = response['totalCard'];
        totalItems = response['totalItems'];
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      Get.rawSnackbar(
        title: "67".tr,
        messageText:  Text(
          "68".tr,
          style: TextStyle(color: Colors.white),
        ),
      );
    } finally {
      update();
    }
  }

  @override
  refreshData() {
    resetVariables();
    getMedicationFromCart();
  }

  @override
  resetVariables() {
    totalItems = 0;
    totalPrice = 0;
    cardItems.clear();
  }

  @override
  goToCheckout() {
    if (cardItems.isEmpty) {
      Get.rawSnackbar(
        title: "Notification",
        messageText: const Text(
          "Your cart is empty",
          style: TextStyle(color: Colors.white),
        ),
      );
      return;
    }
    Get.toNamed(
      Routes.checkout,
      arguments: {'cardItems': cardItems, 'totalPrice': totalPrice},
    );
  }
}
