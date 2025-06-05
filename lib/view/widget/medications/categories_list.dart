

import 'package:ecommerce/controller/medication_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesList extends StatelessWidget {
  final MedicationsControllerImp controller ;
  const CategoriesList({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                        height: 100,
                        child: ListView.separated(
                          separatorBuilder:
                              (context, index) => const SizedBox(width: 10),
                          itemCount: controller.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(0, 255, 251, 251),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  height: 70,
                                  width: 70,
                                  child: SvgPicture.asset(
                                    "assets/images/medicine-bottle-svgrepo-com.svg",
                                  
                                  ),
                                ),
                                Text(
                                  controller.categories[index].name.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColor.grey,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
    )
                      ;
  }
}