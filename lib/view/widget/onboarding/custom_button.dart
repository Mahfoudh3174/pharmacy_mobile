import 'package:ecommerce/controller/onboarder_controller.dart';
import 'package:ecommerce/data/datasource/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonOnBoarding extends StatelessWidget {
  const CustomButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: GetBuilder<OnboarderControllerImp>(
        builder: (controller) {
          return ElevatedButton(
            onPressed: () {
              controller.next();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: controller.currentPage == onBoardingData.length-1 ? Text('start_now'.tr,style: TextStyle(color: Colors.white, fontSize: 16),) : Text(
              'next'.tr,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }
      ),
    );
  }
}
