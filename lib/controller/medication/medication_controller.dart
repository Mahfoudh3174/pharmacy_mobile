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
  loadMoreMedications() {}
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
  
  // Pagination variables
  int currentPage = 1;
  int lastPage = 1;
  bool isLoadingMore = false;
  bool hasMoreData = true;

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
  Future<void> getCategories() async {
    try {
      final response = await medicationData.getCategoriesData();
      if (response is Map<String, dynamic> && response.containsKey('categories')) {
        List categoriesList = response['categories'];
        categories = categoriesList.map((e) => Category.fromJson(e)).toList();
      } else {
        // Fallback to static categories if API fails
        categories = CategoriesData.categories;
      }
    } catch (e) {
      debugPrint("Error fetching categories: ${e.toString()}");
      // Fallback to static categories
      categories = CategoriesData.categories;
    }
    update();
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
    currentPage = 1;
    hasMoreData = true;

    try {
      final response = await medicationData.getData(
        pharmacy!.id,
        categoryId: selectedCategoryId,
        page: currentPage,
      );
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        final medicationResponse = MedicationResponse.fromJson(response);
        medications = medicationResponse.medications;
        currentPage = medicationResponse.meta.currentPage;
        lastPage = medicationResponse.meta.lastPage;
        hasMoreData = medicationResponse.meta.hasNextPage;

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
  Future<void> loadMoreMedications() async {
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    update();

    try {
      final response = await medicationData.getData(
        pharmacy!.id,
        categoryId: selectedCategoryId,
        page: currentPage + 1,
      );
      
      if (response is Map<String, dynamic> && response.containsKey('medications')) {
        final medicationResponse = MedicationResponse.fromJson(response);
        medications.addAll(medicationResponse.medications);
        currentPage = medicationResponse.meta.currentPage;
        lastPage = medicationResponse.meta.lastPage;
        hasMoreData = medicationResponse.meta.hasNextPage;

        // Update allMedications if no category filter is active
        if (selectedCategoryId == null) {
          allMedications = List.from(medications);
        }
      }
    } catch (e) {
      debugPrint("Error loading more medications: ${e.toString()}");
    }

    isLoadingMore = false;
    update();
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
          pharmacy!.id,
          categoryId: categoryId,
          page: 1,
        );
        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          final medicationResponse = MedicationResponse.fromJson(response);
          medications = medicationResponse.medications;
          currentPage = medicationResponse.meta.currentPage;
          lastPage = medicationResponse.meta.lastPage;
          hasMoreData = medicationResponse.meta.hasNextPage;

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
