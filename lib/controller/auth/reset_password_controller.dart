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

  @override
  resetpassword() {}

  @override
  goToSuccessResetPassword() {
    Get.offNamed(Routes.verfiyCode);
  }

  @override
  void onInit() { 
    password = TextEditingController(); 
    repassword = TextEditingController(); 
    super.onInit();
  }

  @override
  void dispose() { 
    password.dispose(); 
    repassword.dispose(); 
    super.dispose();
  }
}