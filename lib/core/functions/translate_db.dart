
import 'package:ecommerce/core/services/services.dart';
import 'package:get/get.dart';

translateDb({columnar,columnfr,columnen}) {

  Myservice storage =Get.find();

  if(storage.sharedPreferences.getString("lang") == 'ar'){
    return columnar;
  }else if(storage.sharedPreferences.getString("lang") == 'en'){
    return columnen;
  }else{
    return columnfr;
  }

}