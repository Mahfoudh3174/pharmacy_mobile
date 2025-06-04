import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';


class TestData {
  Crud crud;

  TestData(this.crud);

  getData() async {
    var response = await crud.postData(AppLinks.test, {
      "name": "test",
      "age": "20",
      "email": "email",}
      
      );
    return  response.fold((l)=>l, (r)=>r);

  }
  
}
