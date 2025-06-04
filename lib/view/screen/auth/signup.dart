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
        title: Text('17'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.grey)),
      ),
      body: GetBuilder<SignUpControllerImp>(
        builder: (controller) {
          return controller.statusRequest == StatusRequest.loading  ? const Center(child: CircularProgressIndicator()):
           Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: ListView(children: [
                const SizedBox(height: 20),
                CustomTextTitleAuth(text: "10".tr),
                const SizedBox(height: 10),
                CustomTextBodyAuth(text: "24".tr),
                const SizedBox(height: 15),
                CustonTextFormAuth(
                  isNumber: false,
                  valid: (val) {
                    if (val!.isEmpty) {
                      return "30".tr;
                    }
                    return null;
                  },
                  mycontroller: controller.username,
                  hinttext: "23".tr,
                  iconData: Icons.person_outline,
                  labeltext: "20".tr,
                ),
                CustonTextFormAuth(
                  isNumber: false,
                  valid: (val) {
                    if (val!.isEmpty) {
                      return "27".tr;
                    }
                    return null;
                  },
                  mycontroller: controller.email,
                  hinttext: "14".tr,
                  iconData: Icons.email_outlined,
                  labeltext: "14".tr,
                ),
                CustonTextFormAuth(
                  isNumber: true,
                  valid: (val) {
                    if (val!.isEmpty) {
                      return "22".tr;
                    } else if (!RegExp(r'^(2|3|4)\d{7}$').hasMatch(val)) {
                      return "33".tr;
                    }
                    return null;
                  },
                  mycontroller: controller.phone,
                  hinttext: "22".tr,
                  iconData: Icons.phone_android_outlined,
                  labeltext: "21".tr,
                ),
                GetBuilder<SignUpControllerImp>(
                  builder: (controller) => CustonTextFormAuth(
                    obscureText: controller.isPasswordVisible,
                    onTapIcon: () {
                      controller.togglePassword();
                    },
                    isNumber: false,
                    valid: (val) {
                      if (val!.isEmpty) {
                        return "16".tr;
                      } else if (val.length < 8) {
                        return "${"28".tr}8";
                      } else if (val.length > 20) {
                        return "${"29".tr}20";
                      }
                      return null;
                    },
                    mycontroller: controller.password,
                    hinttext: "16".tr,
                    iconData: controller.isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    labeltext: "16".tr,
                  ),
                ),
                CustomButtomAuth(
                  text: "26".tr,
                  onPressed: () {
                    controller.signUp();
                  },
                ),
                const SizedBox(height: 40),
                CustomTextSignUpOrSignIn(
                  textone: "25".tr,
                  texttwo: "26".tr,
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