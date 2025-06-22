import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/auth/password_reset_data.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ForgetPasswordController extends GetxController {
  checkemail();
  goToVerfiyCode();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  late TextEditingController email;
  late PasswordResetData passwordResetData;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  checkemail() async {
    if (email.text.isEmpty) {
      Get.snackbar(
        "error".tr,
        "please_enter_email".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!GetUtils.isEmail(email.text)) {
      Get.snackbar(
        "error".tr,
        "please_enter_valid_email".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    var response = await passwordResetData.sendOtp(email.text);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == 'success' || response['message'] != null) {
        Get.snackbar(
          "success".tr,
          response['message'] ?? "otp_sent_successfully".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
        goToVerfiyCode();
      } else {
        Get.snackbar(
          "error".tr,
          response['message'] ?? "failed_to_send_otp".tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "error".tr,
        "connection_error".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    update();
  }

  @override
  goToVerfiyCode() {
    Get.offNamed(Routes.verfiyCode, arguments: {"email": email.text});
  }

  @override
  void onInit() {
    email = TextEditingController();
    passwordResetData = PasswordResetData(Get.put(Crud()));
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
