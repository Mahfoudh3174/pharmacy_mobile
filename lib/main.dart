import 'package:ecommerce/binding/initial_binding.dart';
import 'package:ecommerce/core/localization/change_local.dart';
import 'package:ecommerce/core/localization/translations.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
  );
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
      theme: localController.appTheme,
      initialBinding: InitialBinding(),
      getPages: Routes.routes
    );
  }
}
