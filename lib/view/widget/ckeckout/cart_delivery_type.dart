import 'package:ecommerce/controller/checout_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDeliveryTypeCheckout extends GetView<CheckoutControllerImp> {
  final String imagename;
  final String title;
  final bool active;
  final void Function()? onTap;

  const CardDeliveryTypeCheckout({
    super.key,
    required this.imagename,
    required this.title,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: active ? AppColor.secondary : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: active ? AppColor.secondary : Colors.grey.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color:
                active
                    ? AppColor.secondary.withOpacity(0.3)
                    : Colors.black.withOpacity(0.06),
            blurRadius: active ? 15 : 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:
                        active
                            ? Colors.white.withOpacity(0.2)
                            : AppColor.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    imagename,
                    width: 24,
                    height: 24,
                    color: active ? Colors.white : AppColor.secondary,
                  ),
                ),

                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: active ? Colors.white : AppColor.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),

                // Active Indicator
                if (active)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "selected".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
