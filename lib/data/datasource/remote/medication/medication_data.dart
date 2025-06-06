import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:get/get.dart';

class MedicationData {
  Crud crud;

  MedicationData(this.crud);
  Myservice storage = Get.find();

  getData(int id) async {
    String? token=storage.sharedPreferences.getString("token");
    var response = await crud.getData("${AppLinks.pharmacies}/$id", {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    return response.fold((l) => l, (r) => r);
  }
}
