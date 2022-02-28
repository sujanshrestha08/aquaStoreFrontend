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
Future<dynamic> postproduct(String name, String category, String description,
    String availableVehicle, String price, dynamic image, context,
    {dynamic check}) async {
  dynamic imageFile;
  if (image != null) {
    imageFile = MultipartFile.fromFileSync(
      //part of dio package to post image
      image.path,
      filename: "${image.path.split("/")[image.path.split("/").length - 1]}",
    );
  }

  // var imageResult = MultipartFile.fromFileSync(image.path,
  //     filename: "${image.path.split("/")[image.path.split("/").length - 1]}");
  // print(imageResult);
  // .fromFileSync(tyoimagefile.path, filename: "${tyoimagefile.path.split("/")[tyoimagefile.path.split("/").length -1]}")

  var body = {
    "name": name,
    "category": category,
    "description": description,
    "countInStock": availableVehicle,
    "price": price,
    "image": image != null ? "/${imageFile.filename}" : null,
  };

  // var body = {

  // };
  String? token = await SharedServices.loginDetails();
  var response = await http.post(
    Uri.parse(Configs.product),
    headers: {
      "Authorization": "Bearer $token",
      "Access-Control-Allow-Origin": "/",
      "Content-Type": "application/json",
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 201) {
    // File fileBody = image;
    try {
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Access-Control-Allow-Origin": "/",
        "Content-Type": "application/json",
      };
      var request = http.MultipartRequest(
          'Post', Uri.parse("http://192.168.1.69:5000/api/upload"));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('image', check));
      var res = await request.send();
      return res.reasonPhrase;
      // open a bytestream
      // var stream = new http.ByteStream(image.openRead());
      // // get file length
      // var length = await image.length();

      // // string to uri
      // var uri = Uri.parse(Configs.mainURL + "/api/upload");

      // // create multipart request
      // var request = http.MultipartRequest("POST", uri);

      // // multipart that takes file
      // var multipartFile =
      //     http.MultipartFile('image', stream, length, filename: image.path);

      // // add file to multipart
      // request.files.add(multipartFile);

      // // send
      // var response = await request.send();
      // // listen for response
      // response.stream.transform(utf8.decoder).listen((value) {
      //   var a = json.decode(value);
      //   print(a);
      //   // userimagesignup = a['data'];
      //   // imagearray.add(a['data']);
      // });
    } on DioError catch (e) {
      throw e.response!;
    }
    // var imgBody = {
    //   'image': imageFile.filename,
    // };

    // var responseee = await http
    //     .post(Uri.parse(Configs.mainURL + " /api/upload"), body: imgBody);

    // FormData imageBody = FormData.fromMap({
    //   "image": imageFile.filename,
    // });

    // Dio dio = Dio();
    // Response imageResponse =
    //     await dio.post(Configs.mainURL + "/api/upload", data: imageBody);
    // var response2 =
    //     await http.post(Uri.parse("http://localhost:5000/api/upload"),
    //         // headers: {
    //         //   "Authorization": "Bearer $token",
    //         //   "Access-Control-Allow-Origin": "/",
    //         //   "Content-Type": "application/json",
    //         // },
    //         body: jsonEncode(imageBody));

    // if (responseee.statusCode == 201) {
    //   print("oh uyes");
    // }

    var addProduct = addProductFromJson(response.body);
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
