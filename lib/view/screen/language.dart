
import 'package:ecommerce/core/localization/change_local.dart';
import 'package:ecommerce/view/widget/lang/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends GetView<Localcontroller> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
            children: [              Text(
                "46".tr,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),              CustomLangButton(
                title: "47".tr,
                onTap: () {
                  controller.changeLang('en');
                },
              ),
              SizedBox(height: 10),
              CustomLangButton(
                title: "48".tr,
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