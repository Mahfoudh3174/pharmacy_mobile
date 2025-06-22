import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:get/get.dart';

class OrderData {

  Crud crud;
  OrderData(this.crud);
  Myservice storage = Get.find();


Future<dynamic> getOrdersData({required String status, int? id, int page = 1}) async {
  final String token = storage.sharedPreferences.getString("token")!;

  String url = id != null
      ? "${AppLinks.orders}/$id?status=$status&page=$page"
      : "${AppLinks.orders}?status=$status&page=$page";

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


Future<dynamic> getSingleOrderData({required int id}) async {
  final String token = storage.sharedPreferences.getString("token")!;

  String url = "${AppLinks.orders}/$id";

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

Future<dynamic> deleteData(int id)async{

  final String token = storage.sharedPreferences.getString("token")!;
  var response = await crud.deleteData("${AppLinks.orders}/$id", {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json",
    "Accept": "application/json",
  });
  print("response delete order $response");
  return response.fold((l) => l, (r) => r);
}

}