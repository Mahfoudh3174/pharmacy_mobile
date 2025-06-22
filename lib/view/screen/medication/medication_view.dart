import 'package:ecommerce/controller/medication/medication_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/medications/categories_list.dart';
import 'package:ecommerce/view/widget/medications/custom_info_card.dart';
import 'package:ecommerce/view/widget/medications/medication_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicationsView extends StatelessWidget {
  const MedicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MedicationsControllerImp());

    return GetBuilder<MedicationsControllerImp>(
      builder:
          (controller) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColor.primary,
              title: Text(
                "search_medications".tr,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: AppColor.background),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  color: AppColor.background,
                  onPressed: controller.goToCarte,
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    onSubmitted: (val) => controller.searchMedications(val),
                    decoration: InputDecoration(
                      hintText: "search_medication_placeholder".tr,
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
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    CustomCardHome(
                      title: controller.pharmacy?.name ?? "",
                      body: controller.pharmacy?.address ?? "",
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "medications".tr,
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: MedicationCard(),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
