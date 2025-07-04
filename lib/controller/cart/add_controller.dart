import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/cart/cart_data.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/data/model/medication_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  addMedicationToCart(Medication medication);
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
  final storage = Get.find<Myservice>();

  @override
  void onInit() {
    initialData();
    super.onInit();
  }

  Future<void> initialData() async {
    statusRequest = StatusRequest.loading;
    update();
    await getMedicationFromCart();
    statusRequest = StatusRequest.success;
    update();
  }

  @override
  addMedicationToCart(Medication medication) async {
    try {
      final response = await cartData.postCartdata(medication.id);
      final status = handlingData(response);

      if (status == StatusRequest.success) {
        await getMedicationFromCart();

        Get.rawSnackbar(
          title: "notification".tr,
          messageText: Text(
            "medication_added".tr,
            style: const TextStyle(color: Colors.white),
          ),
        );
      } else {
        statusRequest = status;
        update();
      }
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
      update();
    }
  }

  @override
  deleteMedicationFromCart(int medicationId) async {
    try {
      final response = await cartData.deleteCartData(medicationId);
      final status = handlingData(response);

      if (status == StatusRequest.success) {
        await getMedicationFromCart();

        Get.rawSnackbar(
          title: "notification".tr,
          messageText: Text(
            "medication_removed".tr,
            style: const TextStyle(color: Colors.white),
          ),
        );
      } else {
        statusRequest = status;
        update();
      }
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
      update();
    }
  }

  @override
  getMedicationFromCart() async {
    try {
      if (cardItems.isEmpty) {
        statusRequest = StatusRequest.loading;
        update();
      }

      final response = await cartData.getCartData();
      final status = handlingData(response);

      if (status == StatusRequest.success) {
        cardItems.clear();

        for (var item in response['cartItems']) {
          cardItems.add(Cart.fromJson(item));
        }
        totalPrice = response['totalCard'];
        totalItems = response['totalItems'];

        statusRequest = StatusRequest.success;
        update();
      } else {
        statusRequest = status;
        update();
      }
    } catch (e) {
      Get.rawSnackbar(
        title: "error".tr,
        messageText: Text(
          "unexpected_error".tr,
          style: const TextStyle(color: Colors.white),
        ),
      );
      statusRequest = StatusRequest.serverException;
      update();
    }
  }

  @override
  refreshData() {
    resetVariables();
    initialData();
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
        title: "notification".tr,
        messageText: Text(
          "cart_is_empty".tr,
          style: const TextStyle(color: Colors.white),
        ),
      );
      return;
    }
    Get.toNamed(
      Routes.checkout,
      arguments: {
        'cardItems': cardItems,
        'totalPrice': totalPrice,
      },
    );
  }
}

