import 'package:ecommerce/data/model/medication_model.dart';
import 'package:ecommerce/data/model/pharmacy_model.dart';

class OrderPaginationMeta {
  final int currentPage;
  final int lastPage;

  OrderPaginationMeta({
    required this.currentPage,
    required this.lastPage,
  });

  factory OrderPaginationMeta.fromJson(Map<String, dynamic> json) {
    return OrderPaginationMeta(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
    );
  }

  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;
}

class OrderResponse {
  final List<Order> orders;
  final OrderPaginationMeta meta;

  OrderResponse({
    required this.orders,
    required this.meta,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      orders: (json['orders'] as List)
          .map((e) => Order.fromJson(e))
          .toList(),
      meta: OrderPaginationMeta.fromJson(json['meta'] ?? {}),
    );
  }
}

class Order {
  final int id;
  final String status;
  final String arSatus;
  final String enStatus;
  final String? reference;
  final int? shippingPrice;
  final String? rejectReason;
  final int? totalAmount;
  final String? type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pharmacy? pharmacy;
  final List<Medication> medications;

  Order({
    required this.id,
    required this.status,
    required this.arSatus,
    required this.enStatus,
    required this.reference,
    this.shippingPrice,
    this.rejectReason,
    this.totalAmount,
    this.type,
    required this.createdAt,
    required this.updatedAt,
    this.pharmacy,
    required this.medications,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      status: json['status'],
      arSatus: json['ar_status'] ?? '',
      enStatus: json['en_status'] ?? '',
      reference: json['reference'] ?? '',
      shippingPrice: int.tryParse(json['shipping_price'].toString()) ?? 0,
      rejectReason: json['reject_reason'],
      totalAmount: int.tryParse(json['total_amount'].toString()) ?? 0,
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pharmacy:
          json['pharmacy'] != null
              ? Pharmacy.fromJsonBasic(json['pharmacy'])
              : null,
      medications:
          (json['medications'] as List<dynamic>?)
              ?.map((e) => Medication.fromJson(e))
              .toList() ??
          [],
    );
  }
}
