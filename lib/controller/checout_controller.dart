import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
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

  @override
  void onInit() {
    cardItems = Get.arguments["cardItems"];
    totaPrice = Get.arguments["totalPrice"];

    for (var element in cardItems) {
      debugPrint("elements:== ${element.medication.name}");
    }
    super.onInit();
  }

  @override
  String? chooseDeliveryType(String type) {
    deliveryType = type;
    update();
    return deliveryType;
  }

  @override
  passeOrder() async{
    if(deliveryType==null){
      Get.rawSnackbar(message: "please choose delivery type");
      return;
      }
    try {
      statusRequest = StatusRequest.loading;
      update();
      final response=await   checkoutData.postData(totaPrice!, deliveryType!, cardItems);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        Get.snackbar("success", "order passed successfully");
        Get.offAllNamed(Routes.pharmacies);
      }
      update();
    } catch (e) {
      debugPrint("error===== ${e.toString()}");
    }
  }
}
