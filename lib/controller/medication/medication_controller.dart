import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/medication/medication_data.dart';
import 'package:ecommerce/routes.dart';
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
  goToDetails(Medication medication) {}
  goToCarte();
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
      medications =
          selectedCategoryId != null
              ? allMedications
                  .where((med) => med.category?.id == selectedCategoryId)
                  .toList()
              : List.from(allMedications);

      statusRequest = StatusRequest.none;
    } else {
      medications =
          allMedications.where((med) {
            final matchesQuery = med.name!.toLowerCase().contains(
              query.toLowerCase(),
            );
            final matchesCategory =
                selectedCategoryId == null ||
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
      final response = await medicationData.getData(
        pharmacy!.id,
        categoryId: selectedCategoryId,
      );
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        List meds = response["medications"];
        medications = meds.map((e) => Medication.fromJson(e)).toList();

        // Only update allMedications if no category filter is active
        if (selectedCategoryId == null) {
          allMedications = List.from(medications);
        }

        if (medications.isEmpty) {
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.serverFailure;
      }
    } catch (e) {
      debugPrint(e.toString());
      statusRequest = StatusRequest.serverException;
    }

    update(); // Single update after data and status are set
  }

  @override
  void filterMedicationsByCategory(int categoryId) async {
    if (selectedCategoryId == categoryId) {
      selectedCategoryId = null;
      await getMedications(); // Fetch all medications
    } else {
      selectedCategoryId = categoryId;
      statusRequest = StatusRequest.loading;
      update();

      try {
        final response = await medicationData.getData(
          pharmacy!.id!,
          categoryId: categoryId,
        );
        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          List meds = response["medications"];
          medications = meds.map((e) => Medication.fromJson(e)).toList();

          if (medications.isEmpty) {
            statusRequest = StatusRequest.failure;
          }
        } else {
          statusRequest = StatusRequest.serverFailure;
        }
      } catch (e) {
        statusRequest = StatusRequest.serverException;
      }
    }

    // Apply search if there's an active search query
    if (searchController.text.isNotEmpty) {
      searchMedications(searchController.text);
    } else {
      update();
    }
  }

  @override
  void getCategories() {
    categories = List.from(pharmacy?.categories ?? []);
  }

  @override
  void goToDetails(Medication medication) {
    Get.toNamed(
      Routes.medicationDetails,
      arguments: {'medication': medication},
    );
  }

  @override
  goToCarte() async {
    await Get.toNamed(Routes.cart);
  }
}
