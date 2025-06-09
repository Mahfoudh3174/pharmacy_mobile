import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handeling_data.dart';
import 'package:ecommerce/data/datasource/remote/auth/login_data.dart';
import 'package:ecommerce/routes.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ecommerce/core/services/services.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  togglePassword();
  goToForgetPassword();
  goToHome();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;
  bool isPasswordVisible = true;
  StatusRequest statusRequest = StatusRequest.none;
  Myservice storage = Get.find();
  LoginData loginData = LoginData(Get.find());

  @override
  togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  @override
  login() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.getData(email.text, password.text);
      statusRequest = handlingData(response);
      update();
      if (statusRequest == StatusRequest.success) {
        storage.sharedPreferences.setString("token", response['token']);
        goToHome();
      } else {
        Fluttertoast.showToast(
          msg: "invalid_credentials".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
    }
  }

  @override
  goToHome() {
    Get.offNamed(Routes.home);
  }

  @override
  goToSignUp() {
    Get.offNamed(Routes.signUp);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(Routes.forgetPassword);
  }
}
