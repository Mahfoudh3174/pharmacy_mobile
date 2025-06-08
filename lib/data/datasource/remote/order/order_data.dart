

import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:get/get.dart';

class OrderData {

  Crud crud;
  OrderData(this.crud);
  Myservice storage = Get.find();


Future<dynamic> getOrdersData({required String status, int? id}) async {
  final String token = storage.sharedPreferences.getString("token")!;

  String url = id != null
      ? "${AppLinks.orders}/$id?status=$status"
      : "${AppLinks.orders}?status=$status";

  // Send request with headers
  var response = await crud.getData(
    url,
    {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  return response.fold((l) => l, (r) => r);
}

}