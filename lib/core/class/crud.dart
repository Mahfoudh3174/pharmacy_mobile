import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/checkconnection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(
    String url,
    Map data,
    Map<String, String> header,
  ) async {
    try {
      if (await checkConnection()) {
        var response = await http.post(
          Uri.parse(url),
          headers: header,
          body: data,
        );
        Map reponseBody1 = json.decode(response.body);
          print("response==== $reponseBody1");
        
         
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map reponseBody = json.decode(response.body);
          print("response==== $reponseBody");
          return Right(reponseBody);
        } else {
          return Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      return Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> getData(
    String url,
    Map<String, String> header,
  ) async {
    try {
      print("url==== $url");
      if (await checkConnection()) {
        var response = await http.get(Uri.parse(url), headers: header);
        print("response==== ${response.statusCode}");
        print("response==== ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map reponseBody = json.decode(response.body);
          return Right(reponseBody);
        } else {
          return Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      return Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> deleteData(
    String url,
    Map<String, String> header,
  ) async {
    try {
      if (await checkConnection()) {
        var response = await http.delete(Uri.parse(url), headers: header);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map reponseBody = json.decode(response.body);
          return Right(reponseBody);
        } else {
          return Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      return Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postJsonData(
    String url,
    Map data,
    Map<String, String> header,
  ) async {
    try {
      if (await checkConnection()) {
        var response = await http.post(
          Uri.parse(url),
          headers: header,
          body: json.encode(data),
        );
        debugPrint("response==== ${response.statusCode}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map reponseBody = json.decode(response.body);
          return Right(reponseBody);
        } else {
          return Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      return Left(StatusRequest.serverException);
    }
  }
}
