import 'package:ecommerce/data/model/category_model.dart';

class PaginationMeta {
  final int currentPage;
  final int lastPage;

  PaginationMeta({
    required this.currentPage,
    required this.lastPage,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
    );
  }

  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;
}

class MedicationResponse {
  final List<Medication> medications;
  final PaginationMeta meta;

  MedicationResponse({
    required this.medications,
    required this.meta,
  });

  factory MedicationResponse.fromJson(Map<String, dynamic> json) {
    return MedicationResponse(
      medications: (json['medications'] as List)
          .map((e) => Medication.fromJson(e))
          .toList(),
      meta: PaginationMeta.fromJson(json['meta'] ?? {}),
    );
  }
}

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

  factory Medication.fromJson(Map<String, dynamic> json) {
    try {
      return Medication(
        id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
        name: json['name']?.toString(),
        category: json['category'] != null
            ? Category.fromJson(json['category'] as Map<String, dynamic>)
            : null,
        imageUrl: json['image_url']?.toString() ?? json['imageUrl']?.toString(),
        dosageForm: json['dosage_form']?.toString() ?? json['dosageForm']?.toString(),
        strength: json['strength']?.toString(),
        price: json['price'] is int 
            ? json['price'] 
            : int.tryParse(json['price']?.toString() ?? '0') ?? 0,
        pivotQuantity: json['pivot_quantity'] is int 
            ? json['pivot_quantity'] 
            : int.tryParse(json['pivot_quantity']?.toString() ?? '0') ?? 0,
        totalPrice: json['total_price'] is int 
            ? json['total_price'] 
            : int.tryParse(json['total_price']?.toString() ?? '0') ?? 0,
        quantity: json['quantity'] is int 
            ? json['quantity'] 
            : int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      );
    } catch (e) {
      // Return a default medication if parsing fails
      return Medication(
        id: 0,
        name: 'Unknown Medication',
        category: null,
        imageUrl: null,
        dosageForm: null,
        strength: null,
        price: 0,
        quantity: 0,
      );
    }
  }

  factory Medication.fromJsonBasic(Map<String, dynamic> json) {
    try {
      return Medication(
        id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
        name: json['name']?.toString(),
        category: null,
        imageUrl: null,
        dosageForm: json['dosage_form']?.toString(),
        strength: null,
        price: json['price'] is int 
            ? json['price'] 
            : int.tryParse(json['price']?.toString() ?? '0') ?? 0,
        pivotQuantity: json['pivot_quantity'] is int 
            ? json['pivot_quantity'] 
            : int.tryParse(json['pivot_quantity']?.toString() ?? '0') ?? 0,
        totalPrice: json['total_price'] is int 
            ? json['total_price'] 
            : int.tryParse(json['total_price']?.toString() ?? '0') ?? 0,
        quantity: 0,
      );
    } catch (e) {
      return Medication(
        id: 0,
        name: 'Unknown Medication',
        category: null,
        imageUrl: null,
        dosageForm: null,
        strength: null,
        price: 0,
        quantity: 0,
      );
    }
  }
}
