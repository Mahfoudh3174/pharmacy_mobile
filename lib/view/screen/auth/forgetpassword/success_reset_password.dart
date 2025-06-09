import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/routes.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessResetPassword extends StatelessWidget {
  const SuccessResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text('success'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.grey)),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Center(
              child: Icon(
            Icons.check_circle_outline,
            size: 200,
            color: AppColor.primary,
          )),
          Text("congratulations".tr,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 30)),
          Text("reset_password_success".tr),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: CustomButtomAuth(
                text: "go_to_login".tr,
                onPressed: () {
                  Get.offAllNamed(Routes.login);
                }),
          ),
          const SizedBox(height: 30)
        ]),
      ),
    );
  }
}
