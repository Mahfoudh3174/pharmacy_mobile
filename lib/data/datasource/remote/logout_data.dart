import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:get/get.dart';

class LogoutData {
  Crud crud;

  LogoutData(this.crud);
  Myservice storage = Get.find();


  Future<void> logout() async {
    final String token=storage.sharedPreferences.getString("token")!;
    
    await crud.postData(AppLinks.logout, {

    }, {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
  }
}
