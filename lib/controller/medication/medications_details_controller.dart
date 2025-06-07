import 'package:ecommerce/controller/cart/add_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/data/model/medication_model.dart';
import 'package:get/get.dart';

abstract class MedicationsDetailsController extends GetxController {
  getMedicationDetails(int id) {}
  increment() {}
  decriment() {}
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
    medicationsCount++;
    update();
  }

  @override
  decriment() {
    medicationsCount > 0 ? medicationsCount-- : medicationsCount = 0;
    update();
  }
}
