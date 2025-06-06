import 'package:ecommerce/controller/medication/medication_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MedicationCard extends GetView<MedicationsControllerImp> {

  

  const MedicationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.7,
      ),
      itemCount:
          controller.medications.length, // Replace with your actual item count
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              controller.goToDetails(controller.medications[index]);
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 220, // Minimum height to ensure all content fits
                maxHeight: 250, // Maximum height to prevent excessive size
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      MainAxisSize.min, // Prevents column from expanding
                  children: [
                    // Image Section
                    Center(
                      child: SizedBox(
                        height: 80, // Reduced from 100
                        width: 80, // Reduced from 100
                        child: Hero(
                           tag: "${controller.medications[index].id}",
                          child: CachedNetworkImage(
                            imageUrl:
                                "${AppLinks.imagesLink}/${controller.medications[index].imageUrl}",
                            errorWidget:
                                (context, url, error) => SvgPicture.asset(
                                  "assets/images/medicine-bottle-svgrepo-com.svg",
                                  fit: BoxFit.cover,
                                ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Name Text
                    Text(
                      "${controller.medications[index].name}",
                      style: const TextStyle(
                        fontSize: 14, // Reduced from 16
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Price Text
                    Text(
                      "${controller.medications[index].price}.00 MRU",
                      style: TextStyle(
                        fontSize: 13, // Reduced from 14
                        color: AppColor.primary,
                      ),
                    ),
                    const Spacer(),

                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity, // Full width button
                      child: ElevatedButton(
                        onPressed: () {
                          // controller.addToCart(controller.medications[index]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ), // Reduced button height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "56".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13, // Reduced text size
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
