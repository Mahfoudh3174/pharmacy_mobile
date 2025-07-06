import 'package:ecommerce/controller/auth/verify_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
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
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: AppColor.grey),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CustomTextTitleAuth(text: "check_code".tr),
            const SizedBox(height: 10),
            CustomTextBodyAuth(text: "enter_code_sent_to_email".tr),
            const SizedBox(height: 10),
            Text(
              "enter_6_digit_code".tr,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.grey,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: OtpTextField(
                  numberOfFields: 6,
                  borderColor: AppColor.primary,
                  focusedBorderColor: AppColor.primary,
                  showFieldAsBox: true,
                  fieldWidth: 40,
                  fieldHeight: 50,
                  borderRadius: BorderRadius.circular(10),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.number,
                  onCodeChanged: (String code) {
                    controller.onOtpChanged(code);
                  },
                  onSubmit: (String verificationCode) {
                    controller.otpCode = verificationCode;
                    controller.checkCode();
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            GetBuilder<VerifyCodeControllerImp>(
              builder:
                  (controller) => HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Column(children: [const SizedBox(height: 10)]),
                  ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
