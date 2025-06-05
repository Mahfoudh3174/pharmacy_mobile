import 'package:ecommerce/controller/medication_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MedicationCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final VoidCallback onAddToCart;
  final MedicationsControllerImp controller;

  const MedicationCard({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.onAddToCart,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 220,  // Minimum height to ensure all content fits
          maxHeight: 250,  // Maximum height to prevent excessive size
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,  // Prevents column from expanding
            children: [
              // Image Section
              Center(
                child: SizedBox(
                  height: 80,  // Reduced from 100
                  width: 80,   // Reduced from 100
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint("Error loading image: $error");
                      return SvgPicture.asset(
                        "assets/images/medicine-bottle-svgrepo-com.svg",
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              
              // Name Text
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,  // Reduced from 16
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              
              // Price Text
              Text(
                "$price.00 MRU",
                style: TextStyle(
                  fontSize: 13,  // Reduced from 14
                  color: AppColor.primary,
                ),
              ),
              const Spacer(),
              
              // Add to Cart Button
              SizedBox(
                width: double.infinity,  // Full width button
                child: ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: const EdgeInsets.symmetric(vertical: 8),  // Reduced button height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,  // Reduced text size
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

