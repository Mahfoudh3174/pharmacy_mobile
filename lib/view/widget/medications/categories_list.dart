

import 'package:ecommerce/controller/medication/medication_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesList extends StatelessWidget {
  final MedicationsControllerImp controller ;
  const CategoriesList({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                        height: 100,                        child: ListView.separated(
                          separatorBuilder:
                              (context, index) => const SizedBox(width: 10),
                          itemCount: controller.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final category = controller.categories[index];
                            final isSelected = controller.selectedCategoryId == category.id;
                            return InkWell(
                              onTap: () => controller.filterMedicationsByCategory(category.id!),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColor.primary.withValues(alpha: 0.1): const Color.fromARGB(0, 255, 251, 251),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected ? AppColor.primary : Colors.transparent,
                                      ),
                                    ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  height: 70,
                                  width: 70,
                                   child: SvgPicture.asset(
                                    "assets/images/medicine-bottle-svgrepo-com.svg",
                                    colorFilter: ColorFilter.mode(
                                      isSelected ? AppColor.primary : AppColor.grey,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                Text(
                                  controller.categories[index].name.toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isSelected ? AppColor.primary : AppColor.grey,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ));
                          },
                        ),
    )
                      ;
  }
}