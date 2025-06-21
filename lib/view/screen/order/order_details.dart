import 'package:ecommerce/controller/order/order_details_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersDetailsController());
    return Scaffold(
      appBar: AppBar(title: Text('PendOrDetails'.tr)),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GetBuilder<OrdersDetailsController>(
          builder:
              ((controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: ListView(
                  children: [
                    // Add rejection reason if exists
                    if (controller.order?.rejectReason != null)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rejection Reason".tr,
                                style: TextStyle(
                                  color: AppColor.errorColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                controller.order!.rejectReason!,
                                style: TextStyle(color: AppColor.darkGrey),
                              ),
                            ],
                          ),
                        ),
                      ),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Table(
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                      "Item".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "QTY".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Prix".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                ...List.generate(
                                  controller.order!.medications.length,
                                  (index) => TableRow(
                                    children: [
                                      Text(
                                        "${controller.order!.medications[index].name}",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "${controller.order!.medications[index].pivotQuantity}X${controller.order!.medications[index].price}",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "${controller.order!.medications[index].totalPrice}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "${'TotPrix'.tr}: ${controller.order!.totalAmount!} + ${controller.order!.shippingPrice!}=${controller.order!.shippingPrice! + controller.order!.totalAmount!}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // if (controller.order!.type == "LIVRAISON")    Card(
                    //     child: Container(
                    //         child: ListTile(
                    //       title: const Text("Addresse de Livraison",
                    //           style: TextStyle(
                    //               color: AppColor.primary,
                    //               fontWeight: FontWeight.bold)),
                    //       subtitle: Text(
                    //           "${controller.ordersModel.addressCity} ${controller.ordersModel.addressStreet}"),
                    //     )),
                    //   ),
                    // if (controller.ordersModel.ordersType == "0")    Card(
                    //       child: Container(
                    //         padding:
                    //             EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //         height: 300,
                    //         width: double.infinity,
                    //         child: GoogleMap(
                    //           mapType: MapType.normal,
                    //           markers: controller.markers.toSet(),
                    //           initialCameraPosition: controller.cameraPosition!,
                    //           onMapCreated: (GoogleMapController controllermap) {
                    //             controller.completercontroller!
                    //                 .complete(controllermap);
                    //           },
                    //         ),
                    //       ),
                    //     )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
