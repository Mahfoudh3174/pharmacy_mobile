import 'package:ecommerce/controller/medication/medication_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ecommerce/data/datasource/remote/checkout_data.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ChecoutController extends GetxController {
  String? chooseDeliveryType(String type);
  passeOrder();
  updateUserLocation(LatLng location);
}

class CheckoutControllerImp extends ChecoutController {
  StatusRequest statusRequest = StatusRequest.none;
  String? deliveryType;
  int? totaPrice;
  int shipping = 0;
  List<Cart> cardItems = [];
  CheckoutData checkoutData = CheckoutData(Get.find());
  final storage = Get.find<Myservice>();

  Position? position;
  LatLng? userLocation;

  @override
  void onInit() {
    cardItems = Get.arguments["cardItems"];
    totaPrice = Get.arguments["totalPrice"];
    super.onInit();
  }

  @override
  String? chooseDeliveryType(String type) {
    deliveryType = type;
    debugPrint("Delivery type selected: $deliveryType");
    update();
    return deliveryType;
  }

  @override
  passeOrder() async {
    if (deliveryType == null) {
      Get.rawSnackbar(message: "please choose delivery type");
      return;
    }
    if (deliveryType == "LIVRAISON" && userLocation == null) {
      Get.toNamed(Routes.map);
      return;
    }

    try {
      if (deliveryType == "LIVRAISON") {
        position = Position(
          latitude: userLocation!.latitude,
          longitude: userLocation!.longitude,
          timestamp: DateTime.now(),
          accuracy: 1.0,
          altitude: 1.0,
          altitudeAccuracy: 1.0,
          heading: 1.0,
          headingAccuracy: 1.0,
          speed: 1.0,
          speedAccuracy: 1.0,
        );
      } else {
        position = await getCurrentLocationApp();
      }

      if (position == null) {
        Get.rawSnackbar(message: "please turn on location");
        return;
      }
      await getNotificationsPermission();

      statusRequest = StatusRequest.loading;
      update();

      final response = await checkoutData.postData(
        cardItems: cardItems,
        deliveryType: deliveryType!,
        shipping: shipping,
        totalPrice: totaPrice!,
        position: position!,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response["error"] == null) {
          Get.find<MedicationsControllerImp>().getMedications();
          Get.snackbar("success".tr, "order_success".tr);
          Get.until((route) => route.settings.name == Routes.medications);
        } else {
          Get.snackbar(
            "error".tr,
            "out_of_stock".tr,
            messageText: Text(
              "${response["error"].toString()} ${"out_of_stock".tr}",
            ),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      }
      debugPrint("==========end");
      update();
    } catch (e) {
      statusRequest = StatusRequest.serverException;
      update();
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

  Future<Permission> getNotificationsPermission() async {
    PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      return Permission.notification;
    } else {
      PermissionStatus newStatus = await Permission.notification.request();
      if (newStatus.isGranted) {
        return Permission.notification;
      } else {
        return Future.error(
          "Notification permission denied",
        );
      }
    }
  }

  @override
  updateUserLocation(LatLng location) {
    userLocation = location;
    shipping = getShipingPrice();
    update();
  }

  int getShipingPrice() {
    double distance = Geolocator.distanceBetween(
      userLocation!.latitude,
      userLocation!.longitude,
      storage.sharedPreferences.getDouble("latitude")!,
      storage.sharedPreferences.getDouble("longitude")!,
    );
    if (distance <= 5000) {
      return 50;
    } else if (distance <= 10000) {
      return 100;
    } else {
      return 150;
    }
  }
}
