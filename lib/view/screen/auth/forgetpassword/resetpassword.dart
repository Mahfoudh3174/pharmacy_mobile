import 'package:ecommerce/controller/auth/reset_password_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/functions/validinput.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:ecommerce/view/widget/auth/customtextbodyauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:ecommerce/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordControllerImp controller =
        Get.put(ResetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text('reset_password'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.grey)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(children: [
          const SizedBox(height: 20),
          CustomTextTitleAuth(text: "new_password".tr),
          const SizedBox(height: 10),
          CustomTextBodyAuth(text: "please_enter_new_password".tr),
          const SizedBox(height: 15),
          CustonTextFormAuth(
            isNumber: false,
            valid: (val) => validInput(val!, 3, 30, "password"),
            mycontroller: controller.password,
            hinttext: "enter_your_password".tr,
            iconData: Icons.lock_outline,
            labeltext: "password".tr,
          ),
          CustonTextFormAuth(
            isNumber: false,
            valid: (val) => validInput(val!, 3, 30, "password"),
            mycontroller: controller.password,
            hinttext: "re_enter_your_password".tr,
            iconData: Icons.lock_outline,
            labeltext: "password".tr,
          ),
          CustomButtomAuth(
            text: "save".tr,
            onPressed: () {
              controller.goToSuccessResetPassword();
            },
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
