import 'package:ecommerce/controller/pharmacy/pharmacy_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/pharmacy/pharmacy_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmacieView extends StatefulWidget {
  const PharmacieView({super.key});

  @override
  State<PharmacieView> createState() => _PharmacieViewState();
}

class _PharmacieViewState extends State<PharmacieView> {
  final ScrollController _scrollController = ScrollController();
  final PharmacyControllerImp controller = Get.put(PharmacyControllerImp());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.loadMorePharmacies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PharmacyControllerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColor.primary,
            title: Text(
              "pharmacies".tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  color: Colors.white,
                  onPressed: () {
                    controller.searchController.clear();
                    controller.getPharmacies();
                  },
                ),
              ),
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => controller.getPharmacies(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.primary.withOpacity(0.05),
                    Colors.grey.shade50,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Modern Search Section
                  Container(
                    margin: const EdgeInsets.all(16),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColor.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.search_rounded,
                                color: AppColor.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "search_pharmacies".tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: controller.searchController,
                          onSubmitted: (val) {
                            controller.searchPharmacies(val);
                          },
                          decoration: InputDecoration(
                            hintText: "search_pharmacies".tr,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                            fillColor: Colors.grey.shade50,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.grey.shade600,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: AppColor.primary,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Pharmacies List
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: HandlingDataView(
                        statusRequest: controller.statusRequest,
                        widget: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: controller.pharmacies.length + (controller.isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == controller.pharmacies.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final pharmacy = controller.pharmacies[index];
                            return PharmacyCard(
                              pharmacy: pharmacy,
                              pharmacyController: controller,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
