import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/auth/password_reset_data.dart';
import 'package:ecommerce/routes.dart';
import 'package:get/get.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode();
  goToResetPassword();
  onOtpChanged(String code);
  validateOtp(String code);
  clearOtp();
}

class VerifyCodeControllerImp extends VerifyCodeController {
  late String verifycode;
  late String email;
  late PasswordResetData passwordResetData;
  StatusRequest statusRequest = StatusRequest.none;
  String otpCode = "";

  @override
  onOtpChanged(String code) {
    otpCode = code;
    print("OTP Changed: '$otpCode' (length: ${otpCode.length})");
    update();
  }

  void setOtp(String code) {
    otpCode = code;
    print("OTP Set: '$otpCode' (length: ${otpCode.length})");
    update();
  }

  @override
  validateOtp(String code) {
    // Remove any non-digit characters
    String cleanCode = code.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanCode.isEmpty) {
      Get.snackbar(
        "error".tr,
        "please_enter_otp".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (cleanCode.length != 6) {
      Get.snackbar(
        "error".tr,
        "please_enter_valid_otp".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // Check if all characters are digits
    if (!RegExp(r'^[0-9]{6}$').hasMatch(cleanCode)) {
      Get.snackbar(
        "error".tr,
        "please_enter_valid_otp".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  @override
  checkCode() async {
    print("Checking OTP: '$otpCode' (length: ${otpCode.length})");

    if (!validateOtp(otpCode)) {
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    var response = await passwordResetData.verifyOtp(email, otpCode);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == 'success' || response['message'] != null) {
        Get.snackbar(
          "success".tr,
          response['message'] ?? "otp_verified_successfully".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
        goToResetPassword();
      } else {
        Get.snackbar(
          "error".tr,
          response['message'] ?? "invalid_otp".tr,
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
  goToResetPassword() {
    Get.offNamed(
      Routes.resetPassword,
      arguments: {"email": email, "otp": otpCode},
    );
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    passwordResetData = PasswordResetData(Get.put(Crud()));
    super.onInit();
  }

  @override
  clearOtp() {
    otpCode = "";
    update();
  }
}
