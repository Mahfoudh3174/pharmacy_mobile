import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:ecommerce/controller/map_screen_controller.dart';

class MapScreen extends GetView<MapScreenController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MapScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text("select_location".tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: controller.confirmLocation,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.initialCenter.value == null) {
          return const Center(child: Text("Unable to retrieve location."));
        } else {
          return FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              initialCenter: controller.initialCenter.value!,
              initialZoom: 15.0,
              onTap: controller.handleTap,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  if (controller.initialCenter.value != null)
                    Marker(
                      point: controller.initialCenter.value!,
                      width: 24,
                      height: 24,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  if (controller.selectedLocation.value != null)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: controller.selectedLocation.value!,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }
}