import 'package:ecommerce/controller/medication_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/linkapi.dart';

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
        builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    children: [
                      CustomAppBar(title: "Find Medications",onPressedIcon: () {
                        
                        Get.snackbar("Notification", "This feature is under development");
                      },
                      onPressedSearch: () {
                        Get.snackbar("Search", "This feature is under development");
                      }
                      ),
                       SizedBox(height: 20),
                      const Text(
                        "Categories",
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
                      const SizedBox(height: 10),
                      const Text(
                        "Medications",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: controller.medications.length, // Replace with your actual item count
                        itemBuilder: (context, index) {
                          return MedicationCard(
                            controller: controller,
                            imagePath: "${AppLinks.imagesLink}/${controller.medications[index].imageUrl}", 
                            name: "${controller.medications[index].name}",
                            price: controller.medications[index].price.toString(),
                            onAddToCart: () {
                              debugPrint("Add to cart pressed for medication: ${controller.medications[index].category?.name}");
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}


