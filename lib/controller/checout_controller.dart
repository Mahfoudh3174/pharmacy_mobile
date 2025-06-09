import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ecommerce/data/datasource/remote/checkout_data.dart';

abstract class ChecoutController extends GetxController {
  String? chooseDeliveryType(String type);
  passeOrder();
}

class CheckoutControllerImp extends ChecoutController {
  StatusRequest statusRequest = StatusRequest.none;
  String? deliveryType;
  int? totaPrice;
  List<Cart> cardItems = [];
  CheckoutData checkoutData = CheckoutData(Get.find());

  Position? position;
  @override
  void onInit() {
    cardItems = Get.arguments["cardItems"];
    totaPrice = Get.arguments["totalPrice"];
    super.onInit();
  }

  @override
  String? chooseDeliveryType(String type) {
    deliveryType = type;
    update();
    return deliveryType;
  }

  @override
  passeOrder() async {
    if (deliveryType == null) {
      Get.rawSnackbar(message: "please choose delivery type");
      return;
    }

    try {
      if (deliveryType == "LIVRAISON") {
        position = await getCurrentLocationApp();
        if (position == null) {
          Get.rawSnackbar(message: "please turn on location");
          return;
        }
      }

      statusRequest = StatusRequest.loading;
      update();
      final response = await checkoutData.postData(
        totaPrice!,
        deliveryType!,
        cardItems,
        position,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        Get.snackbar("success", "order passed successfully");
        Get.offAllNamed(Routes.home);
      }
      update();
    } catch (e) {
      statusRequest = StatusRequest.serverException;
      update();
    }
  }

  Future<Position?> getCurrentLocationApp() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return null;
      }

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, handle accordingly
          throw LocationServiceDisabledException();
        }
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        return position;
      }
      return null;
    } catch (e) {
      Get.snackbar(
        "Erreur",
        "Une erreur est survenue lors de la récupération de la localisation",

        snackPosition: SnackPosition.TOP,
      );
    }
    return null;
  }
}
