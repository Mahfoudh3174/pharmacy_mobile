
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ecommerce/controller/checout_controller.dart';

class MapScreenController extends GetxController {
  final MapController mapController = MapController();
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  Rx<LatLng?> initialCenter = Rx<LatLng?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          "Location Error",
          "Location services are disabled. Please enable them.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar(
            "Location Error",
            "Location permissions are denied.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Location Error",
          "Location permissions are permanently denied, we cannot request permissions.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      initialCenter.value = LatLng(position.latitude, position.longitude);
      selectedLocation.value = initialCenter.value;
    } catch (e) {
      debugPrint("Error getting location: $e");
      Get.snackbar(
        "Location Error",
        "Failed to retrieve your location. Error: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void handleTap(dynamic tapPosition, LatLng location) {
    selectedLocation.value = location;
  }

  void confirmLocation() {
    if (selectedLocation.value != null) {
      final checkoutController = Get.find<CheckoutControllerImp>();
      checkoutController.updateUserLocation(selectedLocation.value!);
      Get.back();
    }
  }
}
