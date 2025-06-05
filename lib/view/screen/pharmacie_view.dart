import 'package:ecommerce/controller/pharmacy/pharmacy_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/medications/customappbar.dart';
import 'package:ecommerce/view/widget/pharmacy/pharmacy_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmacieView extends StatelessWidget {
  const PharmacieView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller (better to do this in bindings)
    Get.put(PharmacyControllerImp());

    return GetBuilder<PharmacyControllerImp>(
      builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.background,
                    Theme.of(context).colorScheme.surface,
                  ],
                ),
              ),
              child: Column(
                children: [
                  CustomAppBar(
                    title: "Find Pharmacies".tr,
                    onPressedIcon: () {
                      Get.snackbar(
                        "Notification",
                        "This feature is under development",
                      );
                    },
                    onPressedSearch: () {
                      Get.snackbar(
                        "Search",
                        "This feature is under development",
                      );
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.pharmacies.length,
                      itemBuilder: (context, index) {
                        final pharmacy = controller.pharmacies[index];
                        return PharmacyCard(
                          pharmacy: pharmacy,
                          pharmacyController: controller,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
