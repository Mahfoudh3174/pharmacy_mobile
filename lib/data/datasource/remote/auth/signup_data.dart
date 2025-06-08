import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';

class SignupData {
  Crud crud;

  SignupData(this.crud);

  getData(String username,String email,String phone,String password) async {
    var response = await crud.postData(AppLinks.register, {
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
    },{
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    });
    return response.fold((l) => l, (r) => r);
  }
}
