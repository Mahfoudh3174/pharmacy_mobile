
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/medication/medications_details_controller.dart';
import 'package:ecommerce/core/constant/color.dart';

import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TopMedicationDetails extends GetView<MedicationsDetailsControllerImp> {
  const TopMedicationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(color: AppColor.secondary),
        ),
        Positioned(
            top: 30.0,
            right: Get.width / 8,
            left: Get.width / 8,
            child: Hero(
              tag: "${controller.medication.id}",
              child: CachedNetworkImage(
                imageUrl:
                    "${AppLinks.imagesLink}/${controller.medication.imageUrl}",
                height: 250,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) =>  SvgPicture.asset(
                  "assets/images/medicine-bottle-svgrepo-com.svg",
                ),
              ),
            ))
      ],
    );
  }
}