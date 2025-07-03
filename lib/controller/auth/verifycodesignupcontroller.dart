
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/core/functions/translate_db.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/auth/signup_data.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode();
  goToSuccessSignUp();
  onOtpChanged(String code);
  validateOtp(String code);
  clearOtp();
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {  

   String? verifycode; 
  String otpCode = "";
  StatusRequest statusRequest = StatusRequest.none;
  late String email;
  SignupData signupData = SignupData(Get.find());
  Myservice storage = Get.find();

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'] ?? ''; // Add null check
    debugPrint("Email for OTP: $email");
    sendOtp();
  }

  Future<void> sendOtp() async {
    try {
       await signupData.sendOtp(email);
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
      update();
      Get.snackbar("Error", "error".tr);
    }
  }


    @override
  onOtpChanged(String code) {
    otpCode = code;
    debugPrint("OTP Changed: '$otpCode' (length: ${otpCode.length})");
    update();
  }
    void setOtp(String code) {
    otpCode = code;
    debugPrint("OTP Set: '$otpCode' (length: ${otpCode.length})");
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
    debugPrint("Checking OTP: '$otpCode' (length: ${otpCode.length})");

    if (!validateOtp(otpCode)) {
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    var response = await signupData.verifyOtp(email, otpCode);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['fr_message'] != null) {
        Get.snackbar(
          "success".tr,
          translateDb(response['ar_message'], response['fr_message']),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
        goToSuccessSignUp() ;
      } else {
        Get.snackbar(
          "error".tr,
                    "verification_failed".tr,

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
  goToSuccessSignUp() {
    if(storage.sharedPreferences.getString("token") != null) {
      Get.offNamed(Routes.home);
      return;
    }
    Get.offNamed(Routes.successSignUp);
  }
  
  @override
  clearOtp() {
    otpCode = "";
    debugPrint("OTP Cleared: '$otpCode' (length: ${otpCode.length})");
    update();
  }


 
}