import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegitredMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  Myservice storage = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if(storage.sharedPreferences.getString("token") != null)
    {return RouteSettings(name: Routes.home);}
    if (storage.sharedPreferences.getBool("onBoarding") == true) {
      return RouteSettings(name: Routes.login);
    }
    return null;
  }
}
