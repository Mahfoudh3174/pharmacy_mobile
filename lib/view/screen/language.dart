import 'package:ecommerce/core/localization/change_local.dart';
import 'package:ecommerce/view/widget/lang/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends GetView<Localcontroller> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "choose_language".tr,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),
            CustomLangButton(
              title: "Français",
              onTap: () {
                controller.changeLang('fr');
              },
            ),
            SizedBox(height: 10),
            CustomLangButton(
              title: "العربية",
              onTap: () {
                controller.changeLang('ar');
              },
            ),
          ],
        ),
      ),
    );
  }
}
