import 'package:ecommerce/data/model/category_model.dart';

class Medication {
  final int id;
  final String? name;
  final Category? category;
  final String? dosageForm;
  final String? strength;
  final String? imageUrl;
  final int? price;
  final int? quantity;
  final int? pivotQuantity;
  final int? totalPrice;

  Medication({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.dosageForm,
    required this.strength,
    required this.price,
    required this.quantity,
    this.pivotQuantity,
    this.totalPrice,
  });

  Medication copyWith({int? id, String? name, int? price, int? quantity}) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category,
      dosageForm: dosageForm,
      strength: strength,
      imageUrl: imageUrl ?? 'https://via.placeholder.com/150',
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category?.toJson(),
    'dosageForm': dosageForm,
    'strength': strength,
    'imageUrl': imageUrl,
    'price': price,
    'quantity': quantity,
    'pivot_quantity': pivotQuantity,
    'total_price': totalPrice,
  };

  Medication.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int,
      name = json['name'] as String?,
      category =
          json['category'] != null
              ? Category.fromJson(json['category'] as Map<String, dynamic>)
              : null,
      imageUrl = json['imageUrl'] as String?,
      dosageForm = json['dosageForm'] as String?,
      strength = json['strength'] as String?,
      price = int.tryParse(json['price']?.toString() ?? '') ?? 0,
      pivotQuantity =
          int.tryParse(json['pivot_quantity']?.toString() ?? '') ?? 0,
      totalPrice = int.tryParse(json['total_price']?.toString() ?? '') ?? 0,
      quantity = int.tryParse(json['quantity']?.toString() ?? '') ?? 0;

  Medication.fromJsonBasic(Map<String, dynamic> json)
    : id = json['id'] as int,
      name = json['name'] as String?,
      category = null,
      imageUrl = null,
      dosageForm = json['dosage_form'] as String?,
      strength = null,
      price = int.tryParse(json['price']?.toString() ?? '') ?? 0,
      pivotQuantity = json['pivot_quantity'] as int? ?? 0,
      totalPrice = json['total_price'] as int? ?? 0,
      quantity = 0;
}
