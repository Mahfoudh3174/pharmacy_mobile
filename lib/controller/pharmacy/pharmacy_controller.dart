import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/pharmacy/pharmacy_data.dart';
import 'package:ecommerce/data/model/pharmacy_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/data/model/medication_model.dart';

abstract class PharmacyController extends GetxController {
  void getPharmacies({String? query});
  void goToMedications(Pharmacy pharmacy);
  void searchPharmacies(String query);
  void loadMorePharmacies();
}

class PharmacyControllerImp extends PharmacyController {
  final List<Pharmacy> pharmacies = <Pharmacy>[];
  PharmacyData pharmacyData = PharmacyData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController searchController = TextEditingController();
  Myservice storage = Get.find();
  int currentPage = 1;
  int lastPage = 1;
  bool isLoadingMore = false;
  bool hasMoreData = true;

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
      currentPage = 1;
      hasMoreData = true;

      var response = await pharmacyData.getData(query: query, page: currentPage);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        final pharmacyResponse = PharmacyResponse.fromJson(response);
        pharmacies.addAll(pharmacyResponse.pharmacies);
        currentPage = pharmacyResponse.meta.currentPage;
        lastPage = pharmacyResponse.meta.lastPage;
        hasMoreData = currentPage < lastPage;

        if (pharmacies.isEmpty) {
          debugPrint("N======o pharmacies found");
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.serverFailure;
      }
    } catch (e) {
      print(e);
      statusRequest = StatusRequest.serverException;
    }

    print("statusRequest pharma serverException ${statusRequest == StatusRequest.serverException}");
    print("statusRequest pharma serverFailure ${statusRequest == StatusRequest.serverFailure}");
    print("statusRequest pharma success ${statusRequest == StatusRequest.success}");

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

  @override
  Future<void> loadMorePharmacies() async {
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    update();

    try {
      final response = await pharmacyData.getData(
        page: currentPage + 1,
      );

      if (response is Map<String, dynamic> &&
          response.containsKey('pharmacies')) {
        final pharmacyResponse = PharmacyResponse.fromJson(response);
        pharmacies.addAll(pharmacyResponse.pharmacies);
        currentPage = pharmacyResponse.meta.currentPage;
        lastPage = pharmacyResponse.meta.lastPage;
        hasMoreData = currentPage < lastPage;
      }
    } catch (e) {
      debugPrint("Error loading more pharmacies: ${e.toString()}");
    }

    isLoadingMore = false;
    update();
  }

  // @override
  // void onClose() {
  //    searchController.dispose();
  //   pharmacies.clear();
  //   super.onClose();
  // }
}
