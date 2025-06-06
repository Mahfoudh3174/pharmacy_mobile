import 'package:ecommerce/binding/initial_binding.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/localization/change_local.dart';
import 'package:ecommerce/core/localization/translations.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/routes.dart';

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
      locale: localController.lang,      theme: ThemeData(
        // Color Scheme
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: AppColor.background,
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
          surface: AppColor.surface,
          error: AppColor.errorColor,
          onPrimary: AppColor.textLight,
          onSecondary: AppColor.textLight,
          onSurface: AppColor.textPrimary,
          onError: AppColor.textLight,
          brightness: Brightness.light,
        ),

        // AppBar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          titleTextStyle: TextStyle(
            color: AppColor.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Card Theme
        cardTheme: CardTheme(
          color: AppColor.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        // Text Theme
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
          headlineMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: AppColor.textPrimary,
          ),
          headlineLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: AppColor.textSecondary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: AppColor.textSecondary,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: AppColor.textSecondary,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            color: AppColor.textLight,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            color: AppColor.textLight,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            color: AppColor.textLight,
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColor.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.lightGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.lightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.primary),
          ),
          labelStyle: TextStyle(color: AppColor.textSecondary),
          hintStyle: TextStyle(color: AppColor.grey),
        ),

        // Button Themes
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          buttonColor: AppColor.primary,
          textTheme: ButtonTextTheme.primary,
        ),
        
        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: AppColor.textLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
      initialBinding: InitialBinding(),
      getPages: Routes.routes
    );
  }
}
