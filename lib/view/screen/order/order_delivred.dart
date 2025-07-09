import 'package:ecommerce/controller/order/order_delivred_controller.dart';
import 'package:ecommerce/controller/order/order_pending_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/order/orders_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersDelivred extends StatelessWidget {
  const OrdersDelivred({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersDelivredController());

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: GetBuilder<OrdersDelivredController>(
        builder:
            (controller) => RefreshIndicator(
              onRefresh: () => controller.getDelivredOrdersData(),
              child: CustomScrollView(
                slivers: [
                  // Modern App Bar
                  SliverAppBar(
                    expandedHeight: 120,
                    floating: false,
                    pinned: true,
                    elevation: 0,
                    backgroundColor: AppColor.primary,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColor.primary,
                              AppColor.primary.withOpacity(0.8),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Background Pattern
                            Positioned(
                              top: -30,
                              right: -30,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            // Header Content
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.delivery_dining_rounded,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "delivered_orders".tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "orders_delivred_text".tr,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Orders List
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                      child: HandlingDataView(
                        statusRequest: controller.statusRequest,
                        widget: Column(
                          children: [
                            // Orders Count Card
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColor.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.inventory_2_rounded,
                                      color: AppColor.primary,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "total_pending_orders".tr,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${controller.ordersList.length} ${"orders".tr}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Orders List
                            ...List.generate(
                              controller.ordersList.length,
                              (index) => Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: CardOrdersList(
                                  listdata: controller.ordersList[index],
                                ),
                              ),
                            ),

                            // Load More Button
                            if (controller.hasMoreData &&
                                controller.ordersList.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: GetBuilder<OrdersPendingController>(
                                  builder:
                                      (controller) => Container(
                                        width: double.infinity,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.primary,
                                              AppColor.primary.withOpacity(0.8),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColor.primary
                                                  .withOpacity(0.3),
                                              blurRadius: 15,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            onTap:
                                                controller.isLoadingMore
                                                    ? null
                                                    : controller.loadMoreOrders,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                  ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  if (controller.isLoadingMore)
                                                    const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                              Color
                                                            >(Colors.white),
                                                      ),
                                                    )
                                                  else
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                  const SizedBox(width: 12),
                                                  Text(
                                                    controller.isLoadingMore
                                                        ? "loading".tr
                                                        : "${"load_more".tr} (${controller.currentPage}/${controller.lastPage})",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                          ],
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
