
import 'package:ecommerce/controller/medication/medications_details_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/medications/price_count.dart';
import 'package:ecommerce/view/widget/medications/subitems_list.dart';
import 'package:ecommerce/view/widget/medications/top_medication_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicationDatailsView extends StatelessWidget {
  const MedicationDatailsView({super.key});

  @override
  Widget build(BuildContext context) {
  final MedicationsDetailsControllerImp controller=    Get.put(MedicationsDetailsControllerImp());
    return Scaffold(
        bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 40,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppColor.secondary,
                onPressed: () {},
                child:  Text(
                  "56".tr,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),
        body: ListView(children: [
          const TopMedicationDetails(),
          const SizedBox(
            height: 100,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
              Text("${controller.medication.name}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColor.textPrimary,
                      )),
              const SizedBox(height: 10),
              PriceAndCountItems(
                  onAdd: () {
                    controller.cartController.addMedicationToCart(controller.medication.id!);
                  },
                   onRemove: () {},
                    price: controller.medication.price.toString(),
                     count: "2"),
              const SizedBox(height: 10),
              Text(
                  "${controller.medication.dosageForm}",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              
              const SubitemsList()
            ]),
          )
        ]));
  }
}