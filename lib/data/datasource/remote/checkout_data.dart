
import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CheckoutData {

  Crud crud;

  CheckoutData(this.crud);
  Myservice storage = Get.find();

  postData(int totalPrice,String deliveryType  ,List<Cart> cardItems,Position? position) async {
    String? token = storage.sharedPreferences.getString("token");
        int? pharmacyId = storage.sharedPreferences.getInt(
      "current_pharmacy_id",
    );
    final response= await crud.postJsonData(
      AppLinks.orders,
      {
        "pharmacy_id": pharmacyId,
        'cardItems': cardItems.map((e) => e.toJson()).toList(),
        'totalPrice': totalPrice,
        'deliveryType': deliveryType,
        'latitude': position?.latitude,
        'longitude': position?.longitude
      },
        {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        }
        );
        return response.fold((l) => l, (r) => r);
  }
  
}