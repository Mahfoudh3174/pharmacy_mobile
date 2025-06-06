import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/medication/medication_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/data/model/medication_model.dart';
import 'package:ecommerce/data/model/pharmacy_model.dart';
import 'package:ecommerce/data/model/category_model.dart';

abstract class MedicationsController extends GetxController {
  getMedications() {}
  getCategories() {}
  filterMedicationsByCategory(int categoryId) {}
}

class MedicationsControllerImp extends MedicationsController {
  Myservice storage = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  int? id;
  List<Category> categories = [];
  List<Medication> medications = [];
  List<Medication> allMedications = [];
  int? selectedCategoryId;
  Pharmacy? pharmacy;

  MedicationData medicationData = MedicationData(Get.find());

  @override
  void onInit() {

    
    pharmacy = Get.arguments['pharmacy'];
    debugPrint("Pharmacy======: $pharmacy");
    debugPrint("Pharmacy ID: ${pharmacy?.id}");
    getCategories();
    getMedications();
    super.onInit();
  }


  @override
  getMedications()async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      medications.clear();
      final response=await medicationData.getData(pharmacy!.id!);
      statusRequest = handlingData(response);
      
      if (statusRequest == StatusRequest.success) {
        for(var medication in response["medications"]) {
          medications.add(Medication.fromJson(medication));
          allMedications.add(Medication.fromJson(medication));
        }
        update();
      }
      
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
      update();
    }
  }

  @override
  filterMedicationsByCategory(int categoryId) {
    if (selectedCategoryId == categoryId) {
      // If clicking the same category again, show all medications
      selectedCategoryId = null;
      medications = List.from(allMedications);
    } else {
      selectedCategoryId = categoryId;
      medications = allMedications.where((med) => med.category?.id == categoryId).toList();
    }
    update();
  }
  @override
  getCategories() {
    for(var category in pharmacy?.categories ?? []) {
      categories.add(category);
    }
  }
  
}
