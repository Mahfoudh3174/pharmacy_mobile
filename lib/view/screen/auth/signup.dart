import 'package:ecommerce/controller/auth/signup_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/auth/customtextbodyauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:ecommerce/view/widget/auth/cutomtextsign.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap:
            () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap
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
                  child: GetBuilder<SignUpControllerImp>(
                    builder: (controller) {
                      return controller.statusRequest == StatusRequest.loading
                          ? const Center(child: CircularProgressIndicator())
                          : Form(
                            key: controller.formstate,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 8),
                                // Animated title
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
                                  child: Text(
                                    "create_account".tr,
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
                                ),
                                const SizedBox(height: 8),
                                CustomTextBodyAuth(
                                  text: "create_account_desc".tr,
                                ),
                                const SizedBox(height: 24),
                                CustonTextFormAuth(
                                  isNumber: false,
                                  valid: (val) {
                                    if (val!.isEmpty)
                                      return "invalid_username".tr;
                                    return null;
                                  },
                                  mycontroller: controller.username,
                                  hinttext: "enter_username".tr,
                                  iconData: Icons.person_outline,
                                  labeltext: "username".tr,
                                ),
                                const SizedBox(height: 16),
                                CustonTextFormAuth(
                                  isNumber: false,
                                  valid: (val) {
                                    if (val!.isEmpty)
                                      return "please_enter_email".tr;
                                    return null;
                                  },
                                  mycontroller: controller.email,
                                  hinttext: "email".tr,
                                  iconData: Icons.email_outlined,
                                  labeltext: "email".tr,
                                ),
                                const SizedBox(height: 16),
                                CustonTextFormAuth(
                                  isNumber: true,
                                  valid: (val) {
                                    if (val!.isEmpty) {
                                      return "enter_phone".tr;
                                    } else if (!RegExp(
                                      r'^(2|3|4)\d{7}$',
                                    ).hasMatch(val)) {
                                      return "invalid_phone".tr;
                                    }
                                    return null;
                                  },
                                  mycontroller: controller.phone,
                                  hinttext: "enter_phone".tr,
                                  iconData: Icons.phone_android_outlined,
                                  labeltext: "phone".tr,
                                ),
                                const SizedBox(height: 16),
                                GetBuilder<SignUpControllerImp>(
                                  builder:
                                      (controller) => CustonTextFormAuth(
                                        obscureText:
                                            controller.isPasswordVisible,
                                        onTapIcon: () {
                                          controller.togglePassword();
                                        },
                                        isNumber: false,
                                        valid: (val) {
                                          if (val!.isEmpty)
                                            return "enter_password".tr;
                                          if (val.length < 8) {
                                            return "${"input_min_length".tr}8";
                                          } else if (val.length > 20) {
                                            return "${"input_max_length".tr}20";
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
                                const SizedBox(height: 24),
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
                                      controller.signUp();
                                    },
                                    child: Text(
                                      "sign_in".tr,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                CustomTextSignUpOrSignIn(
                                  textone: "have_account".tr,
                                  texttwo: "sign_in".tr,
                                  onTap: () {
                                    controller.goToSignIn();
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
