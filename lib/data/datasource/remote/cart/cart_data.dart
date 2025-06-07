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
    final String token = storage.sharedPreferences.getString("token")!;

    var response = await crud.postData(
      'http://192.168.100.13/api/cart',
      {"id": id},
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/x-www-form-urlencoded",
        'Accept': 'application/json',
      },
    );
    debugPrint("$response received");

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
}
