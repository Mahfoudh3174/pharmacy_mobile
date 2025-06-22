import 'package:ecommerce/controller/medication/medication_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MedicationCard extends GetView<MedicationsControllerImp> {
  const MedicationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.7,
          ),
          itemCount: controller.medications.length,
          itemBuilder: (context, index) {
            final med = controller.medications[index];

            return Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  controller.goToDetails(med);
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 220,
                    maxHeight: 250,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Center(
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Hero(
                              tag: "${med.id}",
                              child:
                                  med.imageUrl != null &&
                                          med.imageUrl!.isNotEmpty
                                      ? CachedNetworkImage(
                                        imageUrl:
                                            "${AppLinks.imagesLink}/${med.imageUrl}",
                                        errorWidget:
                                            (
                                              context,
                                              url,
                                              error,
                                            ) => SvgPicture.asset(
                                              "assets/images/medicine-bottle-svgrepo-com.svg",
                                              fit: BoxFit.cover,
                                            ),
                                        fit: BoxFit.cover,
                                      )
                                      : SvgPicture.asset(
                                        "assets/images/medicine-bottle-svgrepo-com.svg",
                                        fit: BoxFit.cover,
                                      ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Name
                        Text(
                          med.name ?? "unknown_medication".tr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Price
                        Text(
                          "${med.price ?? 0} MRU",
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Category
                        const SizedBox(height: 4),
                        Text(
                          med.category?.name ?? "no_category".tr,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Pharmacy
                        const SizedBox(height: 4),
                        Text(
                          "${"pharmacy_label".tr} ${controller.pharmacy?.name ?? "unknown_pharmacy".tr}",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Load More Button
        if (controller.hasMoreData && controller.medications.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GetBuilder<MedicationsControllerImp>(
              builder:
                  (controller) => ElevatedButton(
                    onPressed:
                        controller.isLoadingMore
                            ? null
                            : controller.loadMoreMedications,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child:
                        controller.isLoadingMore
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                            : Text(
                              "${"load_more".tr} (${controller.currentPage}/${controller.lastPage})",
                              style: const TextStyle(fontSize: 16),
                            ),
                  ),
            ),
          ),
      ],
    );
  }
}
