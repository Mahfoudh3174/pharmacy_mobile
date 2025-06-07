import 'package:ecommerce/data/model/medication_model.dart';
import 'package:ecommerce/data/model/pharmacy_model.dart';

class Cart {

  int quantity;
  int totalPrice;
  Medication medication;
  Pharmacy pharmacy;

  Cart({

    required this.quantity,
    required this.totalPrice,
    required this.medication,
    required this.pharmacy
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      quantity: json['quantity'],
      totalPrice: json['total_price'],
      medication: Medication.fromJson(json['medication']),
      pharmacy: Pharmacy.fromJson(json['pharmacy'])
    ); 
  }

  Map<String, dynamic> toJson() {
    return {

      'quantity': quantity,
      'total_price': totalPrice,
      'medication': medication.toJson(),
    }; 
  }
   

}
