import 'package:ecommerce/controller/auth/login_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/auth/customtextbodyauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';

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
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFe0eafc), Color(0xFFcfdef3)],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: GetBuilder<LoginControllerImp>(
                    builder: (controller) {
                      return controller.statusRequest == StatusRequest.loading
                          ? const Center(child: CircularProgressIndicator())
                          : Form(
                            key: controller.formstate,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Animated logo
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: 1),
                                  duration: const Duration(milliseconds: 800),
                                  builder:
                                      (context, value, child) => Opacity(
                                        opacity: value,
                                        child: Transform.translate(
                                          offset: Offset(0, (1 - value) * 30),
                                          child: child,
                                        ),
                                      ),
                                  child: const LogoAuth(),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  "welcome_back".tr,
                                  style:
                                      Theme.of(
                                        context,
                                      ).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary,
                                      ) ??
                                      const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                CustomTextBodyAuth(text: "login_desc".tr),
                                const SizedBox(height: 24),
                                CustonTextFormAuth(
                                  isNumber: false,
                                  valid: (val) {
                                    if (val!.isEmpty) {
                                      return "enter_phone_or_email".tr;
                                    }
                                    return null;
                                  },
                                  mycontroller: controller.email,
                                  hinttext: "enter_phone_or_email".tr,
                                  iconData: Icons.person_2_outlined,
                                  labeltext: "phone_or_email".tr,
                                ),
                                const SizedBox(height: 16),
                                GetBuilder<LoginControllerImp>(
                                  builder:
                                      (controller) => CustonTextFormAuth(
                                        obscureText:
                                            controller.isPasswordVisible,
                                        onTapIcon: () {
                                          controller.togglePassword();
                                        },
                                        isNumber: false,
                                        valid: (val) {
                                          if (val!.isEmpty ||
                                              val.trim().isEmpty) {
                                            return "enter_password".tr;
                                          }
                                          return null;
                                        },
                                        mycontroller: controller.password,
                                        hinttext: "enter_password".tr,
                                        iconData:
                                            controller.isPasswordVisible
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                        labeltext: "password".tr,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      controller.goToForgetPassword();
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColor.primary,
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    child: Text("forget_password".tr),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primary,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      elevation: 4,
                                    ),
                                    onPressed: () {
                                      controller.login();
                                    },
                                    child: Text(
                                      "login".tr,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                CustomTextSignUpOrSignIn(
                                  textone: "no_account".tr,
                                  texttwo: "create_account".tr,
                                  onTap: () {
                                    controller.goToSignUp();
                                  },
                                ),
                              ],
                            ),
                          );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
