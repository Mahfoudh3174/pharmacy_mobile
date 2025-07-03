import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/auth/signup_data.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
  goToVerify();
  togglePassword() {}
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  bool isPasswordVisible = true;

  StatusRequest? statusRequest;
  SignupData signupData = SignupData(Get.find());

  @override
  togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  @override
  goToVerify() {
    Get.offNamed(Routes.verifiercheckmail,
        arguments: {"email": email.text});
  }

  @override
  signUp() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await signupData.getData(
        username.text,
        email.text,
        phone.text,
        password.text,
      );
      statusRequest = handlingData(response);
      update();

      if (statusRequest == StatusRequest.success) {

        
        goToVerify();
      } else {
        Fluttertoast.showToast(
          msg: "user_already_exists".tr,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {}
  }



  @override
  goToSignIn() {
    Get.offNamed(Routes.login);
  }

  @override
  void onInit() {
    username = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }


}
