import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  getData(String credential,String password)async{

    var response=await crud.postData(AppLinks.login, {
      "credential": credential,
      "password": password,
    });
    debugPrint("Response status:====Logindata================ ${response.toString()}");
    return response.fold((l) => l, (r) => r);

  }
}
