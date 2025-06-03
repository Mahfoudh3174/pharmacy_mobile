
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLangButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const CustomLangButton({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return   ListTile(
                leading: const Icon(Icons.language),
                title:  Text(title), 
                onTap: () {
                  onTap?.call();
                  Get.offAllNamed(Routes.onBoarding);
                }, 
              )
            ;
  }
}