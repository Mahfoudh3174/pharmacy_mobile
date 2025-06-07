
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/logout_data.dart';
import 'package:ecommerce/routes.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  Myservice storage = Get.find();
  LogoutData logoutData = LogoutData(Get.find());

  logout()async{
    await logoutData.logout();
    storage.sharedPreferences.remove("token");
    Get.offAllNamed(Routes.login); 
  }
}