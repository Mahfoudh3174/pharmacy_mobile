import 'package:ecommerce/controller/cart/add_controller.dart';
import 'package:ecommerce/data/model/medication_model.dart';
import 'package:get/get.dart';

abstract class MedicationsDetailsController extends GetxController {
  getMedicationDetails(int id);
}

class MedicationsDetailsControllerImp extends MedicationsDetailsController {
  
  CartControllerImp cartController = Get.put(CartControllerImp());
  
  late Medication medication;
  List subitems = [];

      @override
    void onInit() {
      initialData();
      super.onInit();
    }
  @override
  getMedicationDetails(int id) {
    
  }
  initialData() {
      medication = Get.arguments['medication'];
    }


}
