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
  searchMedications(String query) {}
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
  TextEditingController searchController = TextEditingController();

  MedicationData medicationData = MedicationData(Get.find());

  @override
  void onInit() {
    pharmacy = Get.arguments['pharmacy'];
    searchController.addListener(() {
      searchMedications(searchController.text);
    });
    getCategories();
    getMedications();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
  void searchMedications(String query) {
    if (query.isEmpty) {
      medications = selectedCategoryId != null
          ? allMedications
              .where((med) => med.category?.id == selectedCategoryId)
              .toList()
          : List.from(allMedications);

      statusRequest = StatusRequest.none;
    } else {
      medications = allMedications.where((med) {
        final matchesQuery =
            med.name!.toLowerCase().contains(query.toLowerCase());
        final matchesCategory = selectedCategoryId == null ||
            med.category?.id == selectedCategoryId;
        return matchesQuery && matchesCategory;
      }).toList();

      statusRequest =
          medications.isEmpty ? StatusRequest.failure : StatusRequest.none;
    }

    update(); // Only one update call
  }

  @override
  Future<void> getMedications() async {
    statusRequest = StatusRequest.loading;
    update();

    medications.clear();
    allMedications.clear();

    try {
      final response = await medicationData.getData(pharmacy!.id!);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        List meds = response["medications"];
        allMedications = meds.map((e) => Medication.fromJson(e)).toList();
        medications = List.from(allMedications);

        if (medications.isEmpty) {
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.serverFailure;
      }
    } catch (e) {
      statusRequest = StatusRequest.serverException;
    }

    update(); // Single update after data and status are set
  }

  @override
  void filterMedicationsByCategory(int categoryId) {
    if (selectedCategoryId == categoryId) {
      selectedCategoryId = null;
      medications = List.from(allMedications);
    } else {
      selectedCategoryId = categoryId;
      medications = allMedications
          .where((med) => med.category?.id == categoryId)
          .toList();
    }

    // Apply search again in case search is active
    if (searchController.text.isNotEmpty) {
      searchMedications(searchController.text);
    } else {
      update(); // Only update if not calling search
    }
  }

  @override
  void getCategories() {
    categories = List.from(pharmacy?.categories ?? []);
  }
}

