
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';

import 'package:ecommerce/data/datasource/remote/pharmacy/pharmacy_data.dart';
import 'package:ecommerce/data/model/pharmacy_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



abstract class PharmacyController extends GetxController {
  void getPharmacies({String? query});
  void goToMedications(Pharmacy pharmacy);
  void searchPharmacies(String query);
}


class PharmacyControllerImp extends PharmacyController {
  final List<Pharmacy> pharmacies = <Pharmacy>[];
  PharmacyData pharmacyData = PharmacyData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController searchController = TextEditingController();
  
  @override
onInit() {
  getPharmacies();
  super.onInit();
}  @override
  Future<void> getPharmacies({String? query}) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      
      // Clear existing data before fetching new data
      pharmacies.clear();
      
      var response = await pharmacyData.getData(query: query);
      statusRequest = handlingData(response);
      
      if (statusRequest == StatusRequest.success) {
        debugPrint("Response received =====$statusRequest");
        List pharmacyList = response["pharmacies"] ?? [];
        
        if (pharmacyList.isEmpty) {
          statusRequest = StatusRequest.failure;
          debugPrint("No pharmacies found");
        } else {
          pharmacies.addAll(
            pharmacyList.map((pharmacy) => Pharmacy.fromJson(pharmacy)).toList()
          );
          debugPrint("Found ${pharmacies.length} pharmacies");
        }
      } else {
        debugPrint("Failed to load pharmacies: $statusRequest");
      }
    } catch (e) {
      debugPrint("Error loading pharmacies: $e");
      statusRequest = StatusRequest.serverException;
    }
    
    update();
  }
  @override
  void goToMedications(Pharmacy pharmacy) {
    Get.toNamed(Routes.medications, arguments: {'pharmacy': pharmacy});
  }

  @override
  void searchPharmacies(String query) {
    if (query.isEmpty) {
      getPharmacies();
    } else {
      
      getPharmacies(query: query);
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    pharmacies.clear();
    super.onClose();
  }


  
}