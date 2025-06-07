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
    var response = await crud.getData(AppLinks.cart, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    return response.fold((l) => l, (r) => r);
  }

  postCartdata(int id) async {
    String? token = storage.sharedPreferences.getString("token");
    // Use the proper API endpoint from AppLinks
    var response = await crud.postJsonData(
      AppLinks.cart,
      {
        "medication_id":
            id, // Changed from 'id' to 'medication_id' to match API
      },
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
    var response = await crud.deleteData("${AppLinks.cart}/$id", {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    return response.fold((l) => l, (r) => r);
  }

  getCountCart(int id) async {
    debugPrint("id in getcard count $id");
    String? token = storage.sharedPreferences.getString("token");
    var response = await crud.getData("${AppLinks.cartCount}/$id", {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    debugPrint("show response $response");
    return response.fold((l) => l, (r) => r);
  }
}
