import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/checkconnection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Crud {

  Future<Either<StatusRequest,Map>> postData(String url, Map data)async{
    try{
    if(await checkConnection()){
      var response = await http.post(Uri.parse(url), body: data);
      debugPrint("Response status:=========//=========== ${response.statusCode}");
      if(response.statusCode == 200 || response.statusCode == 201){
        Map reponseBody=json.decode(response.body);
        return Right(reponseBody);
      }else{
        return Left(StatusRequest.serverFailure);
      }
    }else{
      return const Left(StatusRequest.offlineFailure);
    }
    }catch(e){
      return Left(StatusRequest.serverFailure);
    }

  }
}