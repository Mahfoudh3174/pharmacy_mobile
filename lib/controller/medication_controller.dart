import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/data/model/medication_model.dart';
import 'package:ecommerce/data/model/pharmacy_model.dart';
import 'package:ecommerce/data/model/category_model.dart';

abstract class MedicationsController extends GetxController {
  getMedications() {}
  getCategories() {}
}

class MedicationsControllerImp extends MedicationsController {
  Myservice storage = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  int? id;
  List<Category> categories = [];
  List<Medication> medications = [];
  Pharmacy? pharmacy;

  String? token;

  initialData() {
    token = storage.sharedPreferences.getString("token");
  }

  @override
  void onInit() {
    initialData();
    
    pharmacy = Get.arguments['pharmacy'];
    debugPrint("Pharmacy======: $pharmacy");
    debugPrint("Pharmacy ID: ${pharmacy?.id}");
    getCategories();
    getMedications();
    super.onInit();
  }

  Future<void> getData() async {}

  @override
  getMedications() {
    statusRequest = StatusRequest.loading;
    update();
    for(var medication in pharmacy?.medications ?? []) {

      medications.add(medication);
    }
    statusRequest = StatusRequest.success;
    update();
    
  }
  @override
  getCategories() {
    for(var category in pharmacy?.categories ?? []) {
      categories.add(category);
    }
  }
  
}
