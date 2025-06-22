import 'package:ecommerce/data/model/medication_model.dart';

class Pharmacy {
  final int id;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final List<Medication?>? medications;

  Pharmacy({
    required this.id,
    required this.name,
    required this.address,
    this.latitude,
    this.longitude,

    this.medications,
  });

  Pharmacy.fromJson(Map<String, dynamic> json)
    : id = json['id'] ?? 0,
      name = json['name'],
      medications =
          (json['medications'] as List)
              .map((med) => Medication.fromJson(med))
              .toList(),
      address = json['address'],
      latitude = double.tryParse(json['latitude']?.toString() ?? '') ?? 0.0,
      longitude = double.tryParse(json['longitude']?.toString() ?? '') ?? 0.0;

  Pharmacy.fromJsonBasic(Map<String, dynamic> json)
    : id = json['id'] ?? 0,
      name = json['name'],
      latitude = double.tryParse(json['latitude']?.toString() ?? '') ?? 0.0,
      longitude = double.tryParse(json['longitude']?.toString() ?? '') ?? 0.0,
      address = json['address'],
      medications = null;
}
