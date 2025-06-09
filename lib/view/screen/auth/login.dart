import 'package:ecommerce/controller/auth/login_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:ecommerce/view/widget/auth/customtextbodyauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:ecommerce/view/widget/auth/customtexttitleauth.dart';
import 'package:ecommerce/view/widget/auth/cutomtextsign.dart';
import 'package:ecommerce/view/widget/auth/logoauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
     Get.put(LoginControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text(
          'login_now'.tr,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: AppColor.grey),
        ),
      ),
      body: GetBuilder<LoginControllerImp>(
        builder: (controller) {
          return controller.statusRequest == StatusRequest.loading ? const Center(child: CircularProgressIndicator()): Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: [
                  const LogoAuth(),
                  const SizedBox(height: 20),                  CustomTextTitleAuth(text: "welcome_back".tr),
                  const SizedBox(height: 10),
                  CustomTextBodyAuth(text: "login_desc".tr),
                  const SizedBox(height: 15),
                  CustonTextFormAuth(
          
                    isNumber: false,
                    valid: (val) {                      if (val!.isEmpty) {
                        return "enter_phone_or_email".tr;
                      }
                      return null;
                    },
                    mycontroller: controller.email,
                    hinttext: "enter_phone_or_email".tr,
                    iconData: Icons.person_2_outlined,
                    labeltext: "phone_or_email".tr,
                  ),
                  GetBuilder<LoginControllerImp>(
                      builder: (controller) => CustonTextFormAuth(
                        obscureText: controller.isPasswordVisible,
                        onTapIcon: () {
                          controller.togglePassword();
                        },
                        isNumber: false,
                        valid: (val) {                          if (val!.isEmpty || val.trim().isEmpty) {
                            return "enter_password".tr;
                          }
                          
                          return null;
                        },
                        mycontroller: controller.password,
                        hinttext: "enter_password".tr,
                        iconData: controller.isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        labeltext: "password".tr,
                        // mycontroller: ,
                      ),
                    ),
                    InkWell(
                    onTap: () {
                      controller.goToForgetPassword();
                    },                    child: Text("forget_password".tr, textAlign: TextAlign.end),
                  ),
                  CustomButtomAuth(
                    text: "login".tr,
                    onPressed: () {
                      controller.login();
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomTextSignUpOrSignIn(
                    textone: "no_account".tr,
                    texttwo: "create_account".tr,
                    onTap: () {
                      controller.goToSignUp();
                    },
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
