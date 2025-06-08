import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  getData(String credential,String password)async{

    var response=await crud.postData(AppLinks.login, {
      "credential": credential,
      "password": password,
    },
    {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    });
    return response.fold((l) => l, (r) => r);

  }
}
