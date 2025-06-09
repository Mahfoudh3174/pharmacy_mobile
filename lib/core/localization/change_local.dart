import 'package:ecommerce/core/constant/apptheme.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class Localcontroller extends GetxController {
  Locale? lang;
  Myservice storage = Get.find();
  ThemeData appTheme = themeEnglish;

  @override
  void onInit() {
    String? currentLang = storage.sharedPreferences.getString("lang");

    if (currentLang == "ar") {
      lang = const Locale('ar');
    } else if (currentLang == "fr") {
      lang = const Locale('fr');
    } else {
      lang = Locale(Get.deviceLocale!.languageCode);
    }

    Jiffy.setLocale(lang!.languageCode);

    super.onInit();
  }

  changeLang(String langCode) {
    Locale? locale = Locale(langCode);
    storage.sharedPreferences.setString("lang", langCode);
    appTheme = langCode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);

    Jiffy.setLocale(langCode);
  }
}
