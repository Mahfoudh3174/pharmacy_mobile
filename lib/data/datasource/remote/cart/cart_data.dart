import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartData {
  Crud crud;
  CartData(this.crud);
  Myservice storage = Get.find();
  getCartData() async {
    String? token = storage.sharedPreferences.getString("token");
    int? pharmacyId = storage.sharedPreferences.getInt("current_pharmacy_id",
    );
    var url =
        pharmacyId != null
            ? "${AppLinks.cart}?pharmacy_id=$pharmacyId"
            : AppLinks.cart;

    var response = await crud.getData(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    return response.fold((l) => l, (r) => r);
  }

  postCartdata(int medicationId) async {
    String? token = storage.sharedPreferences.getString("token");
    int? pharmacyId = storage.sharedPreferences.getInt(
      "current_pharmacy_id",
    );
    debugPrint("==pharma id ===$pharmacyId");
    var response = await crud.postJsonData(
      AppLinks.cart,
      {"medication_id": medicationId, "pharmacy_id": pharmacyId},
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
    );
    debugPrint("Cart API Response: $response");

    return response.fold((l) => l, (r) => r);
  }

  deleteCartData(int id) async {
    String? token = storage.sharedPreferences.getString("token");
    int? pharmacyId = storage.sharedPreferences.getInt(
      "current_pharmacy_id",
    );
    var url = "${AppLinks.cart}/$id";
    if (pharmacyId != null) {
      url += "?pharmacy_id=$pharmacyId";
    }

    var response = await crud.deleteData(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    return response.fold((l) => l, (r) => r);
  }

  getCountCart(int id) async {
    debugPrint("id in getcard count $id");
    String? token = storage.sharedPreferences.getString("token");
    int? pharmacyId = storage.sharedPreferences.getInt(
      "current_pharmacy_id",
    );
    var url = "${AppLinks.cartCount}/$id";
    if (pharmacyId != null) {
      url += "?pharmacy_id=$pharmacyId";
    }

    var response = await crud.getData(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    debugPrint("show response $response");
    return response.fold((l) => l, (r) => r);
  }
}
