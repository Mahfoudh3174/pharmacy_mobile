import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/cart/cart_data.dart';
import 'package:ecommerce/data/model/medication_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class MedicationsDetailsController extends GetxController {
  increment();
  decriment();
  goToCarte();
  addMedicationToCart(int productId);
  deleteMedicationFromCart(int medicationId);
  getCountItems(int id);
}

class MedicationsDetailsControllerImp extends MedicationsDetailsController {
  // CartControllerImp cartController = Get.put(CartControllerImp());

  late Medication medication;
  List subitems = [];
  int medicationsCount = 0;
  CartData cartData = CartData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;
    // Position? position;


  @override
  void onInit() {
    initialData();

    super.onInit();
  }

  initialData() async {
    medication = Get.arguments['medication'];
    statusRequest = StatusRequest.loading;
    medicationsCount = await getCountItems(medication.id!);
    statusRequest = StatusRequest.success;
    update();
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
  addMedicationToCart(int productId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      final response = await cartData.postCartdata(productId);
      statusRequest = handlingData(response);
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
  increment() {
    addMedicationToCart(medication.id!);
    medicationsCount++;
    update();
  }

  @override
  decriment() {
    if (medicationsCount > 0) {
      deleteMedicationFromCart(medication.id!);
      medicationsCount--;
      update();
    }
  }

  @override
  goToCarte() {
    
    Get.toNamed(Routes.cart);
  }
}
