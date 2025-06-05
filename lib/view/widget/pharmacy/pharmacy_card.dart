
import 'package:ecommerce/controller/pharmacy/pharmacy_controller.dart';
import 'package:ecommerce/data/model/pharmacy_model.dart';
import 'package:flutter/material.dart';

class PharmacyCard extends StatelessWidget {
  final Pharmacy pharmacy;
  final PharmacyControllerImp pharmacyController ;
  static const _icon = Icon(Icons.local_pharmacy, size: 40, color: Colors.blue);

  const PharmacyCard({super.key, required this.pharmacy, required this.pharmacyController});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: _icon,
        title: Text(
          pharmacy.name ?? 'Unknown Pharmacy',
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          pharmacy.address ?? 'No address provided',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          pharmacyController.goToMedications(pharmacy );
        },
      ),
    );
  }
}
