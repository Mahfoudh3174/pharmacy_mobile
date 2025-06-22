import 'package:ecommerce/controller/order/order_valid_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/order/orders_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderValidated extends StatelessWidget {
  const OrderValidated({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ValidOrdersController());
    return Container(
      padding: const EdgeInsets.all(10),
      child: GetBuilder<ValidOrdersController>(
        builder:
            ((controller) => RefreshIndicator(
              onRefresh: () => controller.getValidatedOrdersData(),
              child: HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.ordersList.length,
                        itemBuilder:
                            ((context, index) => CardOrdersList(
                              listdata: controller.ordersList[index],
                            )),
                      ),
                    ),

                    // Load More Button
                    if (controller.hasMoreData &&
                        controller.ordersList.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: GetBuilder<ValidOrdersController>(
                          builder:
                              (controller) => ElevatedButton(
                                onPressed:
                                    controller.isLoadingMore
                                        ? null
                                        : controller.loadMoreOrders,
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                        : Text(
                                          "Load More (${controller.currentPage}/${controller.lastPage})",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                              ),
                        ),
                      ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
