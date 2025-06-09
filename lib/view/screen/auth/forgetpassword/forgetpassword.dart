import 'package:ecommerce/controller/auth/forgetpassword_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/functions/validinput.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:ecommerce/view/widget/auth/customtextbodyauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:ecommerce/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordControllerImp controller =
        Get.put(ForgetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text('forget_password'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.grey)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(children: [
          const SizedBox(height: 20),
          CustomTextTitleAuth(text: "check_email".tr),
          const SizedBox(height: 10),
          CustomTextBodyAuth(text: "check_email_desc".tr),
          const SizedBox(height: 15),
          CustonTextFormAuth(
            isNumber: false,
            valid: (val) {
              return validInput(val!, 3, 30, "email");
            },
            mycontroller: controller.email,
            hinttext: "enter_email".tr,
            iconData: Icons.email_outlined,
            labeltext: "email".tr,
          ),
          CustomButtomAuth(
            text: "check".tr,
            onPressed: () {
              controller.goToVerfiyCode();
            },
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
