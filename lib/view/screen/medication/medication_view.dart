
import 'package:ecommerce/controller/medication/medication_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';


import 'package:ecommerce/view/widget/medications/categories_list.dart';
import 'package:ecommerce/view/widget/medications/customappbar.dart';
import 'package:ecommerce/view/widget/medications/medication_card.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';

class MedicationsView extends StatelessWidget {
  const MedicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MedicationsControllerImp());
    return Scaffold(
      body: GetBuilder<MedicationsControllerImp>(
        builder: (controller) => SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(                    children: [
                      CustomMedicationBar(
                        title: "53".tr,
                        onPressedIcon: () {
                          Get.snackbar("50".tr, "51".tr);
                        },
                        searchController: controller.searchController,
                        onPressedSearch: () {
                          controller.searchMedications(controller.searchController.text);
                        }
                      ),
                       SizedBox(height: 20),
                      Text(
                        "54".tr,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CategoriesList(
                        controller: controller,
                      ),
                      const SizedBox(height: 10),                      Text(
                        "55".tr,
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                       HandlingDataView(
              statusRequest: controller.statusRequest,
              widget:MedicationCard()
                       )
                    ],
                  ),
                ),
              ),
            ),
      
    );
  }
}


