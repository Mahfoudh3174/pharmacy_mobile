// Generated Categories for Flutter
// This file contains all categories from the database
// Copy this to your Flutter project

import 'package:get/get.dart';

class Category {
  final int id;
  final String name;
  final String arName;
  final String svgLogo;

  const Category({
    required this.id,
    required this.name,
    required this.arName,
    required this.svgLogo,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'ar_name': arName, 'svg_logo': svgLogo};
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id:
          json['id'] is int
              ? json['id']
              : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      arName: json['ar_name']?.toString() ?? '',
      svgLogo:
          json['svg_logo']?.toString() ?? 'medicine-bottle-svgrepo-com.svg',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'ar_name': arName, 'svg_logo': svgLogo};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      arName: map['ar_name'] ?? '',
      svgLogo: map['svg_logo'] ?? 'medicine-bottle-svgrepo-com.svg',
    );
  }

  // Get translated name based on current language
  String getTranslatedName() {
    final currentLang = Get.locale?.languageCode ?? 'en';
    if (currentLang == 'ar') {
      return getArabicName();
    }
    return name;
  }

  // Get Arabic name with fallback for API categories
  String getArabicName() {
    if (arName.isNotEmpty) {
      return arName;
    }

    // Fallback translations for common API categories
    final fallbackTranslations = {
      'Analgésiques': 'مسكنات الألم',
      'Antibiotiques': 'المضادات الحيوية',
      'Anti-inflammatoires': 'مضادات الالتهاب',
      'Antihistaminiques': 'مضادات الهيستامين',
      'Antihypertenseurs': 'مضادات ارتفاع ضغط الدم',
      'Antidiabétiques': 'مرض السكري',
      'Médicaments Psychiatriques': 'الصحة النفسية',
      'Médicaments Oncologiques': 'الأورام',
      'Contraceptifs': 'موانع الحمل',
      'Vitamines': 'الفيتامينات',
      'Soins dentaires': 'العناية بالأسنان',
      'Soins oculaires': 'العناية بالعين',
      'Soins cutanés': 'العناية بالبشرة',
      'Premiers soins': 'الإسعافات الأولية',
    };

    return fallbackTranslations[name] ?? name;
  }
}

// Static categories as fallback
class CategoriesData {
  static const List<Category> categories = [
    Category(
      id: 1,
      name: 'Antibiotics',
      arName: 'المضادات الحيوية',
      svgLogo: 'antibiotics.svg',
    ),
    Category(
      id: 2,
      name: 'Pain Relief',
      arName: 'مسكنات الألم',
      svgLogo: 'analgesics.svg',
    ),
    Category(
      id: 3,
      name: 'Vitamins & Supplements',
      arName: 'الفيتامينات والمكملات',
      svgLogo: 'vitamins.svg',
    ),
    Category(
      id: 4,
      name: 'Cardiovascular',
      arName: 'أمراض القلب والأوعية الدموية',
      svgLogo: 'cardiovascular.svg',
    ),
    Category(
      id: 5,
      name: 'Diabetes',
      arName: 'مرض السكري',
      svgLogo: 'antidiabetics.svg',
    ),
    Category(
      id: 6,
      name: 'Respiratory',
      arName: 'أمراض الجهاز التنفسي',
      svgLogo: 'respiratory.svg',
    ),
    Category(
      id: 7,
      name: 'Digestive Health',
      arName: 'صحة الجهاز الهضمي',
      svgLogo: 'gastrointestinal.svg',
    ),
    Category(
      id: 8,
      name: 'Mental Health',
      arName: 'الصحة النفسية',
      svgLogo: 'psychiatric.svg',
    ),
    Category(
      id: 9,
      name: 'Women\'s Health',
      arName: 'صحة المرأة',
      svgLogo: 'contraceptives.svg',
    ),
    Category(
      id: 10,
      name: 'Men\'s Health',
      arName: 'صحة الرجل',
      svgLogo: 'hormonal.svg',
    ),
    Category(
      id: 11,
      name: 'Children\'s Health',
      arName: 'صحة الأطفال',
      svgLogo: 'first-aid.svg',
    ),
    Category(
      id: 12,
      name: 'Elderly Care',
      arName: 'رعاية المسنين',
      svgLogo: 'cardiovascular.svg',
    ),
    Category(
      id: 13,
      name: 'First Aid',
      arName: 'الإسعافات الأولية',
      svgLogo: 'first-aid.svg',
    ),
    Category(
      id: 14,
      name: 'Dental Care',
      arName: 'العناية بالأسنان',
      svgLogo: 'dental-care.svg',
    ),
    Category(
      id: 15,
      name: 'Eye Care',
      arName: 'العناية بالعين',
      svgLogo: 'eye-care.svg',
    ),
    Category(
      id: 16,
      name: 'Skin Care',
      arName: 'العناية بالبشرة',
      svgLogo: 'skincare.svg',
    ),
    Category(
      id: 17,
      name: 'Hair Care',
      arName: 'العناية بالشعر',
      svgLogo: 'skincare.svg',
    ),
    Category(
      id: 18,
      name: 'Baby Care',
      arName: 'العناية بالرضع',
      svgLogo: 'first-aid.svg',
    ),
    Category(
      id: 19,
      name: 'Medical Devices',
      arName: 'الأجهزة الطبية',
      svgLogo: 'stethoscope-svgrepo-com.svg',
    ),
    Category(
      id: 20,
      name: 'Health & Wellness',
      arName: 'الصحة والعافية',
      svgLogo: 'vitamins.svg',
    ),
  ];

  static Category? getById(int id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  static Category? getByName(String name) {
    try {
      return categories.firstWhere(
        (category) => category.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  static List<Category> search(String query) {
    return categories
        .where(
          (category) =>
              category.name.toLowerCase().contains(query.toLowerCase()) ||
              category.arName.contains(query),
        )
        .toList();
  }
}

// Usage examples:
// final allCategories = CategoriesData.categories;
// final category = CategoriesData.getById(1);
// final searchResults = CategoriesData.search('antibiotic');
// 
// In your Flutter widget:
// Image.asset('assets/svgs/' + category.svgLogo) 