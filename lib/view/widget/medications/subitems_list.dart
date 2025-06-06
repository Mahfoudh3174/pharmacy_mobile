
import 'package:ecommerce/controller/medication/medications_details_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubitemsList extends GetView<MedicationsDetailsControllerImp> {
  const SubitemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          controller.subitems.length,
          (index) => Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 5),
            height: 60,
            width: 90,
            decoration: BoxDecoration(
                color: controller.subitems[index]['active'] == "1"
                    ? AppColor.successColor
                    : Colors.white,
                border: Border.all(color: AppColor.successColor),
                borderRadius: BorderRadius.circular(10)),
            child: Text(controller.subitems[index]['name'],
                style: TextStyle(
                    color: controller.subitems[index]['active'] == "1"
                        ? Colors.white
                        : AppColor.successColor,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}