
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoggedInMiddleware extends GetMiddleware{
  
  @override
  int? get priority => 2;
  Myservice storage = Get.find();

  @override
  RouteSettings? redirect(String? route) {
     if(storage.sharedPreferences.getString("token") != null){
       return RouteSettings(name: Routes.home);
     }else{
      return RouteSettings(name: Routes.login); 
     }
  }
}