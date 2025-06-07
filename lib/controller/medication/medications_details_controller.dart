import 'package:ecommerce/controller/cart/add_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/data/model/medication_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:get/get.dart';

abstract class MedicationsDetailsController extends GetxController {
  getMedicationDetails(int id) {}
  increment() {}
  decriment() {}
  goToCarte() {}
}

class MedicationsDetailsControllerImp extends MedicationsDetailsController {
  CartControllerImp cartController = Get.put(CartControllerImp());

  late Medication medication;
  List subitems = [];
  int medicationsCount = 0;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    initialData();

    super.onInit();
  }

  @override
  getMedicationDetails(int id) {}

  initialData() async {
    medication = Get.arguments['medication'];
    statusRequest = StatusRequest.loading;
    medicationsCount = await cartController.getCountItems(medication.id!);
    update();
    statusRequest = StatusRequest.success;
  }

  @override
  increment() {
    cartController.addMedicationToCart(medication.id!);
    medicationsCount++;
    update();
  }

  @override
  decriment() {
    if (medicationsCount > 0) {
      cartController.deleteMedicationFromCart(medication.id!);
      medicationsCount--;
      update();
    }
  }

  @override
  goToCarte() {
    
    Get.toNamed(Routes.cart);
  }
}
