import 'package:ecommerce/core/localization/change_local.dart';
import 'package:ecommerce/core/localization/translations.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/routes.dart';

import 'package:ecommerce/view/screen/language.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
  

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Localcontroller localController = Get.put(Localcontroller());
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      translations: AllTranslations(),
      locale: localController.lang,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 133, 190, 236),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          headlineLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          buttonColor: const Color.fromARGB(255, 133, 190, 236),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
        home: const Language(),
      getPages: Routes.routes
    );
  }
}
