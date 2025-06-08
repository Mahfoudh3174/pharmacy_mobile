import 'package:ecommerce/controller/checout_controller.dart';
import 'package:ecommerce/core/class/handeling_data_view.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/imageasset.dart';
import 'package:ecommerce/view/widget/ckeckout/cart_delivery_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutControllerImp());
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      bottomNavigationBar: GetBuilder<CheckoutControllerImp>(
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              color: AppColor.primary,
              textColor: Colors.white,
              onPressed: () async {
                await controller.passeOrder();
              },
              child: const Text(
                "Checkout",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          );
        },
      ),
      body: GetBuilder<CheckoutControllerImp>(
        builder:
            (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    // const Text(
                    //   "Choose Payment Method",
                    //   style: TextStyle(
                    //       color: AppColor.secondary,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 16),
                    // ),
                    // const SizedBox(height: 10),
                    // InkWell(
                    //   onTap: () {
                    //     // controller.choosePaymentMethod("cash");
                    //   },
                    //   child: CardPaymentMethodCheckout(
                    //       title: "Cash On Delivery",
                    //       isActive: true
                    //       //  controller.paymentMethod == "cash"
                    //       //     ? true
                    //       //     : false
                    //       ),
                    // ),
                    // const SizedBox(height: 10),
                    // InkWell(
                    //   onTap: () {
                    //     // controller.choosePaymentMethod("card");
                    //   },
                    //   child: CardPaymentMethodCheckout(
                    //       title: "Payment Cards",
                    //       isActive:false
                    //       //  controller.paymentMethod == "card"
                    //       //     ? true
                    //       //     : false
                    //           ),
                    // ),
                    // const SizedBox(height: 20),
                    const Text(
                      "Choisir la méthode de reception",
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.chooseDeliveryType("LIVRAISON");
                          },
                          child: CardDeliveryTypeCheckout(
                            imagename: Imageasset.deliveryImage2,
                            title: "66".tr,
                            active:
                                controller.deliveryType == "LIVRAISON"
                                    ? true
                                    : false,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            controller.chooseDeliveryType("SURE PLACE");
                          },
                          child: CardDeliveryTypeCheckout(
                            imagename: Imageasset.drivethruImage,
                            title: "65".tr,
                            active:
                                controller.deliveryType == "SURE PLACE"
                                    ? true
                                    : false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //   if (controller.deliveryType == "delivery")
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text(
                    //           "Shipping Address",
                    //           style: TextStyle(
                    //               color: AppColor.secondColor,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 16),
                    //         ),
                    //         const SizedBox(height: 10),
                    //         ...List.generate(
                    //           controller.dataaddress.length,
                    //           (index) => InkWell(
                    //             onTap: () {
                    //               controller.chooseShippingAddress(
                    //                   controller.dataaddress[index].addressId!);
                    //             },
                    //             child: CardShppingAddressCheckout(
                    //                 title:
                    //                     "${controller.dataaddress[index].addressName}",
                    //                 body:
                    //                     "${controller.dataaddress[index].addressCity} ${controller.dataaddress[index].addressStreet}",
                    //                 isactive: controller.addressid ==
                    //                         controller
                    //                             .dataaddress[index].addressId
                    //                     ? true
                    //                     : false),
                    //           ),
                    //         )
                    //       ],
                    //     )
                    //
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
