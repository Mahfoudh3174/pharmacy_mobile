import 'package:ecommerce/controller/medication/medication_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesList extends StatelessWidget {
  final MedicationsControllerImp controller;
  const CategoriesList({super.key, required this.controller});

  // Map API SVG names to actual asset file names
  String _getSvgAssetPath(String? svgName) {
    if (svgName == null) return "assets/images/medicine-bottle-svgrepo-com.svg";
    
    // Direct mapping for exact matches
    final exactMatches = [
      'analgesics.svg', 'antibiotics.svg', 'anti-inflammatory.svg',
      'antihistamines.svg', 'antihypertensives.svg', 'antidiabetics.svg',
      'cardiovascular.svg', 'respiratory.svg', 'gastrointestinal.svg',
      'psychiatric.svg', 'contraceptives.svg', 'dental-care.svg',
      'eye-care.svg', 'first-aid.svg', 'vitamins.svg', 'skincare.svg',
      'anti-infectious.svg', 'hormonal.svg', 'immunosuppressants.svg',
      'oncology.svg', 'medicine-bottle-svgrepo-com.svg', 'capsule-svgrepo-com.svg',
      'medicine-chest-svgrepo-com.svg', 'inject-svgrepo-com.svg',
      'ointment-svgrepo-com.svg', 'medicine-icon-svgrepo-com.svg',
      'infusion-svgrepo-com.svg', 'microscope-svgrepo-com.svg',
      'stethoscope-svgrepo-com.svg'
    ];
    
    if (exactMatches.contains(svgName)) {
      return "assets/svgs/$svgName";
    }
    
    // Fallback mappings for common variations
    final fallbackMap = {
      'pain-relief.svg': 'analgesics.svg',
      'diabetes.svg': 'antidiabetics.svg',
      'digestive.svg': 'gastrointestinal.svg',
      'mental-health.svg': 'psychiatric.svg',
      'womens-health.svg': 'contraceptives.svg',
      'mens-health.svg': 'hormonal.svg',
      'childrens-health.svg': 'first-aid.svg',
      'elderly-care.svg': 'cardiovascular.svg',
      'skin-care.svg': 'skincare.svg',
      'hair-care.svg': 'skincare.svg',
      'baby-care.svg': 'first-aid.svg',
      'medical-devices.svg': 'stethoscope-svgrepo-com.svg',
      'health-wellness.svg': 'vitamins.svg',
    };
    
    final fallback = fallbackMap[svgName];
    if (fallback != null) {
      return "assets/svgs/$fallback";
    }
    
    // Default fallback
    return "assets/images/medicine-bottle-svgrepo-com.svg";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: controller.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          final isSelected = controller.selectedCategoryId == category.id;
          final svgPath = _getSvgAssetPath(category.svgLogo);
          
          return InkWell(
            onTap: () => controller.filterMedicationsByCategory(category.id),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? AppColor.primary.withValues(alpha: 0.1)
                            : const Color.fromARGB(0, 255, 251, 251),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColor.primary : Colors.transparent,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  width: 70,
                  child: SvgPicture.asset(
                    svgPath,
                    colorFilter: ColorFilter.mode(
                      isSelected ? AppColor.primary : AppColor.grey,
                      BlendMode.srcIn,
                    ),
                    errorBuilder: (context, error, stackTrace) {
                      return SvgPicture.asset(
                        "assets/images/medicine-bottle-svgrepo-com.svg",
                        colorFilter: ColorFilter.mode(
                          isSelected ? AppColor.primary : AppColor.grey,
                          BlendMode.srcIn,
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  controller.categories[index].name.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected ? AppColor.primary : AppColor.grey,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
