import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/cart/cart_data.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  Position? position;

  List<Cart> cardItems = [];
  int totalPrice = 0;
  int totalItems = 0;
  int shipping = 0;
  double distance = 0;
  final storage = Get.find<Myservice>();

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
    initialData();
    super.onInit();
  }

  Future<void> initialData() async {
    position = await getCurrentLocationApp();
    if (position == null) {
      Get.rawSnackbar(message: "please turn on location");
      return;
    }

    distance = Geolocator.distanceBetween(
      position!.latitude,
      position!.longitude,
      storage.sharedPreferences.getDouble("latitude")!,
      storage.sharedPreferences.getDouble("longitude")!,
    );
    shipping = int.tryParse(getShipingPrice().toString()) ?? 0;
    update();
  }

  int getShipingPrice() {
    if (distance <= 5000) {
      return 50;
    } else if (distance <= 10000) {
      return 100;
    } else {
      return 150;
    }
  }

  Future<Position?> getCurrentLocationApp() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return null;
      }

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, handle accordingly
          throw LocationServiceDisabledException();
        }
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        return position;
      }
      return null;
    } catch (e) {
      Get.snackbar(
        "Erreur",
        "Une erreur est survenue lors de la récupération de la localisation",

        snackPosition: SnackPosition.TOP,
      );
    }
    return null;
  }

  @override
  addMedicationToCart(int productId) async {
    try {
      final response = await cartData.postCartdata(productId);
      final status = handlingData(response);

      if (status == StatusRequest.success) {
        // Refresh cart data without showing loading
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
      // Don't show loading state for better UX
      final response = await cartData.deleteCartData(medicationId);
      final status = handlingData(response);

      if (status == StatusRequest.success) {
        // Refresh cart data without showing loading
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
      // Only show loading on initial load, not on refresh
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
          style: TextStyle(color: Colors.white),
        ),
      );
      statusRequest = StatusRequest.serverException;
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
    shipping = 0;
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
      arguments: {
        'cardItems': cardItems,
        'totalPrice': totalPrice,
        'shipping': shipping,
      },
    );
  }
}
