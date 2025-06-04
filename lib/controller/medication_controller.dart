import 'package:ecommerce/core/services/services.dart';
import 'package:get/get.dart';

class MedicationsController extends GetxController {}

class MedicationsControllerImp extends MedicationsController {
  Myservice storage = Get.find();

  String? token;

  initialData() {
    token = storage.sharedPreferences.getString("token");
  }

  @override
  void onInit() {
    initialData();
    super.onInit();
  }
}
