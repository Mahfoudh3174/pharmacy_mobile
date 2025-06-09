import 'package:ecommerce/controller/auth/signup_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:ecommerce/view/widget/auth/customtextbodyauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:ecommerce/view/widget/auth/customtexttitleauth.dart';
import 'package:ecommerce/view/widget/auth/cutomtextsign.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
   Get.put(SignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text('create_account'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.grey)),
      ),
      body: GetBuilder<SignUpControllerImp>(
        builder: (controller) {
          return controller.statusRequest == StatusRequest.loading  ? 
          const Center(child: CircularProgressIndicator()):
           Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: ListView(children: [
                const SizedBox(height: 20),                CustomTextTitleAuth(text: "welcome_back".tr),
                const SizedBox(height: 10),
                CustomTextBodyAuth(text: "create_account_desc".tr),
                const SizedBox(height: 15),
                CustonTextFormAuth(
                  isNumber: false,                  valid: (val) {
                    if (val!.isEmpty) {
                      return "invalid_username".tr;
                    }
                    return null;
                  },
                  mycontroller: controller.username,                  hinttext: "enter_username".tr,
                  iconData: Icons.person_outline,
                  labeltext: "username".tr,
                ),
                CustonTextFormAuth(
                  isNumber: false,
                  valid: (val) {                    if (val!.isEmpty) {
                      return "please_enter_email".tr;
                    }
                    return null;
                  },
                  mycontroller: controller.email,
                  hinttext: "email".tr,
                  iconData: Icons.email_outlined,
                  labeltext: "email".tr,
                ),
                CustonTextFormAuth(
                  isNumber: true,                  valid: (val) {
                    if (val!.isEmpty) {
                      return "enter_phone".tr;
                    } else if (!RegExp(r'^(2|3|4)\d{7}$').hasMatch(val)) {
                      return "invalid_phone".tr;
                    }
                    return null;
                  },
                  mycontroller: controller.phone,
                  hinttext: "enter_phone".tr,
                  iconData: Icons.phone_android_outlined,
                  labeltext: "phone".tr,
                ),
                GetBuilder<SignUpControllerImp>(
                  builder: (controller) => CustonTextFormAuth(
                    obscureText: controller.isPasswordVisible,
                    onTapIcon: () {
                      controller.togglePassword();
                    },
                    isNumber: false,
                    valid: (val) {                    if (val!.isEmpty) {
                      return "enter_password".tr;
                    } else if (val.length < 8) {
                      return "${"input_min_length".tr}8";
                    } else if (val.length > 20) {
                      return "${"input_max_length".tr}20";
                    }
                    return null;
                  },
                  mycontroller: controller.password,
                  hinttext: "enter_password".tr,
                  iconData: controller.isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  labeltext: "password".tr,
                  ),
                ),                CustomButtomAuth(
                  text: "sign_in".tr,
                  onPressed: () {
                    controller.signUp();
                  },
                ),
                const SizedBox(height: 40),
                CustomTextSignUpOrSignIn(
                  textone: "have_account".tr,
                  texttwo: "sign_in".tr,
                  onTap: () {
                    controller.goToSignIn();
                  },
                ),
              ]),
            ),
          );
        }
      ),
    );
  }
}