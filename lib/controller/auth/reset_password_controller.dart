import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/auth/password_reset_data.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  resetpassword();
  goToSuccessResetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  late TextEditingController password;
  late TextEditingController repassword;
  late String email;
  late String otp;
  late PasswordResetData passwordResetData;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  resetpassword() async {
    if (password.text.isEmpty) {
      Get.snackbar(
        "error".tr,
        "please_enter_password".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (password.text.length < 6) {
      Get.snackbar(
        "error".tr,
        "password_too_short".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (password.text != repassword.text) {
      Get.snackbar(
        "error".tr,
        "passwords_dont_match".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    var response = await passwordResetData.resetPassword(
      email,
      otp,
      password.text,
      repassword.text,
    );
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == 'success' || response['message'] != null) {
        Get.snackbar(
          "success".tr,
          response['message'] ?? "password_reset_successfully".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
        goToSuccessResetPassword();
      } else {
        Get.snackbar(
          "error".tr,
          response['message'] ?? "failed_to_reset_password".tr,
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
  goToSuccessResetPassword() {
    Get.offNamed(Routes.successResetPassword);
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    otp = Get.arguments['otp'];
    password = TextEditingController();
    repassword = TextEditingController();
    passwordResetData = PasswordResetData(Get.put(Crud()));
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}
