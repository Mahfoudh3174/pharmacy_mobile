import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/cart/cart_data.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  addMedicationToCart(int medicationId);
  deleteMedicationFromCart(int medicationId);
  getMedicationFromCart();
  getCountItems(int id);
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
        // Refresh cart data after successful addition
        resetVariables();
        await getMedicationFromCart();
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
  deleteMedicationFromCart(int medicationId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      final response = await cartData.deleteCartData(medicationId);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        
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
          debugPrint("====controller fetch cardItems $item");
          cardItems.add(Cart.fromJson(item));
        }
        debugPrint("====controller fetch cardItems $cardItems");
        totalPrice = response['totalCard'];
        totalItems = response['totalItems'];
        debugPrint("====total $totalPrice");
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      debugPrint("====cart get exception ${e.toString()}");
    } finally {
      update();
    }
  }

  @override
  Future<int> getCountItems(int id) async {
    int medicationsCount = 0;

    try {
      final response = await cartData.getCountCart(id);

      medicationsCount = response['count'];
    } catch (e) {
      debugPrint("====medication count not found ${e.toString()}");
    }
    return medicationsCount;
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
  }
}
