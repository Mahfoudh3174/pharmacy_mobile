import 'package:ecommerce/controller/pharmacy/pharmacy_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/pharmacy/pharmacy_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmacieView extends StatelessWidget {
  const PharmacieView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PharmacyControllerImp());

    return GetBuilder<PharmacyControllerImp>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.primary,
            title: Text(
              "Pharmacies",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColor.background),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_active_outlined),
                color: AppColor.background,
                onPressed: () {
                  controller.searchController.clear();
                  controller.getPharmacies();
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.searchController,
                  onSubmitted: (val) {
                    controller.searchPharmacies(val);
                  },
                  decoration: InputDecoration(
                    hintText: "Search pharmacies...",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ),
          ),
          body: Container(
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
            child: HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
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
          ),
        );
      },
    );
  }
}
