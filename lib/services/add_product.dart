import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:aqua_store/model/add_product_model.dart';
import 'package:aqua_store/services/product_service.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:provider/provider.dart';

// class AddProduct extends ChangeNotifier {
Future<dynamic> postproduct(
  String name,
  String category,
  String description,
  String availableVehicle,
  String price,
  File? image,
  context,
) async {
  String? token = await SharedServices.loginDetails();

  FormData data =
      FormData.fromMap({'image': await MultipartFile.fromFile(image!.path)});
  var response2 = await Dio().post(
    "http://192.168.10.168:3000/api/upload",
    options: Options(headers: {
      "Authorization": "Bearer $token",
      "Access-Control-Allow-Origin": "/"
    }),
    data: data,
  );
  var body = {
    "name": name,
    "category": category,
    "description": description,
    "countInStock": availableVehicle,
    "price": price,
    "image": response2.data,
  };
  var response = await Dio().post(
    Configs.product,
    options: Options(headers: {
      "Authorization": "Bearer $token",
      "Access-Control-Allow-Origin": "/",
      "Content-type": "application/json"
    }),
    data: jsonEncode(body),
  );
  print(response);
  if (response.statusCode == 200 || response.statusCode == 201) {
    var addProduct = addProductFromJson(response.data);
    await Provider.of<MyProduct>(context, listen: false).getproduct(context);
    return addProduct;
  } else {
    Fluttertoast.showToast(
      msg: "Error ! \nPlease try again later.",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20.0,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.red[800],
    );
  }
}
