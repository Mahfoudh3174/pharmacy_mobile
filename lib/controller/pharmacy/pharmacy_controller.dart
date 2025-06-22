import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/core/services/services.dart';

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
  Myservice storage = Get.find();
 


  @override
  onInit() {
    getPharmacies();
    super.onInit();
  }

  @override
  Future<void> getPharmacies({String? query}) async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      pharmacies.clear();

      var response = await pharmacyData.getData(query: query);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        List pharmacyList = response["pharmacies"] ?? [];
        for (var pharmacy in pharmacyList) {
          pharmacies.add(Pharmacy.fromJsonBasic(pharmacy));
          print("======${pharmacies.first}");
        }

        if (pharmacies.isEmpty) {
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.serverFailure;
      }
    } catch (e) {
      print(e);
      statusRequest = StatusRequest.serverException;
    }
    print("statusRequest ${statusRequest == StatusRequest.serverException}");

    update();
  }

  @override
  void goToMedications(Pharmacy pharmacy) {
    storage.sharedPreferences.setInt("current_pharmacy_id", pharmacy.id);
    storage.sharedPreferences.setDouble("latitude", pharmacy.latitude!);
    storage.sharedPreferences.setDouble("longitude", pharmacy.longitude!);
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

  // @override
  // void onClose() {
  //    searchController.dispose();
  //   pharmacies.clear();
  //   super.onClose();
  // }
}
