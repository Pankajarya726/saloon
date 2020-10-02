import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'NetworkCheck.dart';
import 'Utility.dart';
import 'package:http/http.dart' as http;

class ApiController {
  var tag = 'ApiController';
  static ApiController _instance = new ApiController.internal();

  ApiController.internal();

  factory ApiController() {
    return _instance;
  }

  static ApiController getInstance() {
    if (_instance == null) {
      _instance = new ApiController.internal();
    }
    return _instance;
  }
  Future<http.Response> getsNew(String url) async {
    Utility.log(tag,"Api Call :\n $url ");



    Map data = {
      'apikey': '12345678901234567890'
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.get(url,
        headers: {
          'request_type':'application'},
    );
    print("${response.statusCode}");
    Utility.log("Api Response","${response.body}");
    return response;

  }


Future<http.Response> PostsNew(String url,var body) async {

    Utility.log(tag, "Api Call :\n $url ");
    Utility.log(tag, "Responsevaljson: " + body.toString());
    var response = await http.post(url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 ( compatible )',
        'Accept': '*/*',
      },
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;

  }

Future<http.Response> Get(String url) async {

    Utility.log(tag, "Api Call :\n $url ");
    var response = await http.get(url,
      headers: {
        'Content-type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;

  }
}
