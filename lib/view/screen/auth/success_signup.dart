import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/routes.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 200,
                    color: AppColor.successColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "success".tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  "register_success".tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 100),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtomAuth(
                    text: "login_now".tr,
                    onPressed: () {
                      Get.offAllNamed(Routes.login);
                    },
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
