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
    LoginControllerImp controller = Get.put(LoginControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text(
          '9'.tr,
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
                  const SizedBox(height: 20),
                  CustomTextTitleAuth(text: "10".tr),
                  const SizedBox(height: 10),
                  CustomTextBodyAuth(text: "11".tr),
                  const SizedBox(height: 15),
                  CustonTextFormAuth(
          
                    isNumber: false,
                    valid: (val) {
                      if (val!.isEmpty) {
                        return "12".tr;
                      }

                      return null;
                    },
                    mycontroller: controller.email,
                    hinttext: "13".tr,
                    iconData: Icons.email_outlined,
                    labeltext: "14".tr,
                  ),
                  GetBuilder<LoginControllerImp>(
                      builder: (controller) => CustonTextFormAuth(
                        obscureText: controller.isPasswordVisible,
                        onTapIcon: () {
                          controller.togglePassword();
                        },
                        isNumber: false,
                        valid: (val) {
                          if (val!.isEmpty || val.trim().isEmpty) {
                            return "16".tr;
                          }
                          
                          return null;
                        },
                        mycontroller: controller.password,
                        hinttext: "16".tr,
                        iconData: controller.isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        labeltext: "16".tr,
                        // mycontroller: ,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.goToForgetPassword();
                      },
                      child: Text(
                        "14".tr,
                        textAlign: TextAlign.right,
                      ),
                    ),InkWell(
                    onTap: () {
                      controller.goToForgetPassword();
                    },
                    child: Text("17".tr, textAlign: TextAlign.end),
                  ),
                  CustomButtomAuth(
                    text: "9".tr,
                    onPressed: () {
                      controller.login();
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomTextSignUpOrSignIn(
                    textone: "19".tr,
                    texttwo: "18".tr,
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
