import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:get/get.dart';

class MedicationData {
  Crud crud;

  MedicationData(this.crud);
  Myservice storage = Get.find();
  getData(int id, {int? categoryId}) async {
    String? token = storage.sharedPreferences.getString("token");
    String url = "${AppLinks.pharmacies}/$id";
    if (categoryId != null) {
      url += "?category_id=$categoryId";
    }
    var response = await crud.getData(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    return response.fold((l) => l, (r) => r);
  }

  getCategoriesData() async {
    String? token = storage.sharedPreferences.getString("token");
    String url = AppLinks.categories;
    var response = await crud.getData(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    return response.fold((l) => l, (r) => r);
  }
}
