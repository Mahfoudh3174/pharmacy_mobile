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

    // Get count without showing loading state
    medicationsCount = await getCountItems(medication.id);

    // Set success state only once at the end
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
      final response = await cartData.postCartdata(productId);
      final status = handlingData(response);

      if (status == StatusRequest.success) {
        // Operation successful, optimistic update was correct
        // No need to update count again
      } else {
        // Operation failed, revert the optimistic update
        medicationsCount--;
        statusRequest = status;
        update();

        // Show error notification
        Get.rawSnackbar(
          title: "error".tr,
          messageText: Text(
            "failed_to_add_medication".tr,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Operation failed, revert the optimistic update
      medicationsCount--;
      statusRequest = StatusRequest.serverFailure;
      update();

      // Show error notification
      Get.rawSnackbar(
        title: "error".tr,
        messageText: Text(
          "failed_to_add_medication".tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  deleteMedicationFromCart(int medicationId) async {
    try {
      final response = await cartData.deleteCartData(medicationId);
      final status = handlingData(response);

      if (status == StatusRequest.success) {
        // Operation successful, optimistic update was correct
        // No need to update count again
      } else {
        // Operation failed, revert the optimistic update
        medicationsCount++;
        statusRequest = status;
        update();

        // Show error notification
        Get.rawSnackbar(
          title: "error".tr,
          messageText: Text(
            "failed_to_remove_medication".tr,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Operation failed, revert the optimistic update
      medicationsCount++;
      statusRequest = StatusRequest.serverFailure;
      update();

      // Show error notification
      Get.rawSnackbar(
        title: "error".tr,
        messageText: Text(
          "failed_to_remove_medication".tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  increment() {
    // Optimistic update
    medicationsCount++;
    update();

    // Perform the actual operation
    addMedicationToCart(medication.id);
  }

  @override
  decriment() {
    if (medicationsCount > 0) {
      // Optimistic update
      medicationsCount--;
      update();

      // Perform the actual operation
      deleteMedicationFromCart(medication.id);
    }
  }

  @override
  goToCarte() {
    Get.toNamed(Routes.cart);
  }
}
