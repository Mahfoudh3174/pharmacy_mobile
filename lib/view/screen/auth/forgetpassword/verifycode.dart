import 'package:ecommerce/controller/auth/verify_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/auth/customtextbodyauth.dart';
import 'package:ecommerce/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerfiyCode extends StatelessWidget {
  const VerfiyCode({super.key});

  @override
  Widget build(BuildContext context) {
    VerifyCodeControllerImp controller = Get.put(VerifyCodeControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text(
          'verification_code'.tr,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColor.grey),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CustomTextTitleAuth(text: "check_code".tr),
            const SizedBox(height: 10),
            CustomTextBodyAuth(
              text: "enter_code_sent_to_email".tr,
            ),
            const SizedBox(height: 15),
            OtpTextField(
              numberOfFields: 5,
              borderColor: const Color(0xFF512DA8),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                controller.goToResetPassword();
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
