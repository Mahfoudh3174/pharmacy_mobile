
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';

import 'package:ecommerce/data/datasource/remote/pharmacy/pharmacy_data.dart';
import 'package:ecommerce/data/model/pharmacy_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



abstract class PharmacyController extends GetxController {
  void getPharmacies();
  void goToMedications(int id);
}


class PharmacyControllerImp extends PharmacyController {

  final List<Pharmacy> pharmacies = <Pharmacy>[];
  PharmacyData pharmacyData = PharmacyData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  
  @override
onInit() {
  getPharmacies();
  super.onInit();
}

  @override
  Future<void> getPharmacies() async {
    
    statusRequest = StatusRequest.loading;
    update();
    var response = await pharmacyData.getData();
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      debugPrint("Pharmacies loaded successfully=====$statusRequest");
      debugPrint("Response body ========: ${response["pharmacies"]}");
      for(var pharmacy in response["pharmacies"]) {
        pharmacies.add(Pharmacy.fromJson(pharmacy));
      }
      update();
    } else {
      // Handle error
      debugPrint("Failed to load pharmacies===========");
    }
  }

  @override
  void goToMedications(int id) {
    Get.toNamed(Routes.medications, arguments: {'pharmacyId': id});
  }
  @override
  void onClose() {
    pharmacies.clear();
    super.onClose();
  }
  



  
}