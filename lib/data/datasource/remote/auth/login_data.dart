import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  getData(String credential, String password) async {
    String? token = await FirebaseMessaging.instance.getToken();

    var response = await crud.postData(
      AppLinks.login,
      {"credential": credential, "password": password, "token": token},
      {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
