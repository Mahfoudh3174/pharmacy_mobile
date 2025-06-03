
import 'package:ecommerce/controller/onboarder_controller.dart';
import 'package:get/get.dart';
import 'package:ecommerce/view/widget/onboarding/custom_button.dart';
import 'package:ecommerce/view/widget/onboarding/dotscontroller.dart';
import 'package:ecommerce/view/widget/onboarding/page_builder.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  

  @override
  Widget build(BuildContext context) {
    Get.put(OnboarderControllerImp());
    return Scaffold(
      body:
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: PageBuilder()),
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                    CustomDots(),
                    CustomButtonOnBoarding(),
                     SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        
    );
  }

}