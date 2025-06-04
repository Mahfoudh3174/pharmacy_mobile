import 'package:ecommerce/controller/pharmacy/pharmacy_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';

import 'package:ecommerce/view/widget/pharmacy/pharmacy_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmacieView extends StatelessWidget {
  const PharmacieView({super.key});

  

  @override
  Widget build(BuildContext context) {
    Get.put(PharmacyControllerImp());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text("45".tr),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {},
            ),
          ],
        ),
        body: GetBuilder<PharmacyControllerImp>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.3),
                      Theme.of(context).colorScheme.background,
                    ],
                  ),
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getPharmacies();
                  },
                  color: Colors.blue,
                  child: ListView.builder(
                    itemCount: controller.pharmacies.length,
                    itemBuilder: (context, index) {
                      final pharmacy = controller.pharmacies[index];
                      return PharmacyCard(pharmacy: pharmacy,
                        pharmacyController: controller,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

