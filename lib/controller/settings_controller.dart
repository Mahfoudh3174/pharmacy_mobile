
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/routes.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  Myservice storage = Get.find();

  logout() {
    storage.sharedPreferences.clear();
    Get.offAllNamed(Routes.login) ; 
  }
}