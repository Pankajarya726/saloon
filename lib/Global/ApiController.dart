import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/SignInSignUpAccount/SignInClass.dart';
import 'package:salon_app/Splash/SplashActivity.dart';
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
    if (_instance == null)
    {
      _instance = new ApiController.internal();
    }
    return _instance;
  }

  Future<http.Response> getsNew(String url,context) async {
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

    getTokenExpiremsg(response.body,context);
    return response;
  }

  Future<http.Response> getsNewData(String url,context) async {
    Utility.log(tag,"Api Call :\n $url ");
    var headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
     'apiKey': '5ad97dec969a5d8c6f87d647601828bafebf1208f13d78e5c060ad4c3595a293',
    };
   /* Map<String, String> headers = new Map();
    headers["content-type"] =  "application/x-www-form-urlencoded";
    headers["X-Target-Environment"] =  "sandbox";
    headers["apiKey"] =  "5ad97dec969a5d8c6f87d647601828bafebf1208f13d78e5c060ad4c3595a293";
*/
    Utility.log(tag,"Api Call :\n $headers ");


    var response = await http.get('http://api.smartdatasystem.es/v1/sensors?',
     headers: headers);
    print("${response.statusCode}");
    Utility.log("Api Response","${response.body}");
    Utility.log("Api Response","${response.headers.containsKey('apiKey').toString()}");
  /*  var request = http.Request('GET', uri);

    request.headers.addAll(headers);


    *//*http.StreamedResponse response = await request.send();
*//*
    final response = await request.send();
    Utility.log(tag,response);
    final respStr = await response.stream.bytesToString();

    Utility.log(tag,response.headers);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      Utility.log(tag,response.reasonPhrase);
    }
    print(response);*/

    /*Utility.log("Api Response","${response.body}");
    return response;*/
  }

Future<http.Response> PostsNew(context,String url,var body) async {

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

    getTokenExpiremsg(response.body,context);
    return response;
  }

Future<http.Response> PostsNewWithToken(context,String url,var body,String token) async {

    Utility.log(tag, "Api Call :\n $url ");
    Utility.log(tag, "Responsevaljson: " + body.toString());
    Utility.log(tag, "Responsevaljson: " +token);
    var response = await http.post(url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 ( compatible )',
        'Accept': '*/*',
        'Authorization': 'Bearer $token'
      },
    );


    getTokenExpiremsg(response.body,context);
    return response;
  }

Future<http.Response> Get(context,String url) async {
    Utility.log(tag, "Api Call :\n $url ");
    var response = await http.get(url,
      headers: {
        'Content-type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
    );
    print("${response.statusCode}");
    print("${response.body}");

    getTokenExpiremsg(response.body,context);
    return response;
  }

Future<http.Response> GetWithToken(context,String url) async
{
  String token = (await Utility.getStringPreference(GlobalConstant.token));
  Utility.log(tag, "Api Call :\n $url ");
  Utility.log(tag, "Api Call :\n $token ");

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 ( compatible )',
        'Accept': '*/*',
        'Authorization': 'Bearer $token'
      },
    );

  getTokenExpiremsg(response.body,context);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
}

  Future<http.Response> GetWithMyToken(context,String url,String token) async {

  Utility.log(tag, "Api Call :\n $url ");
  Utility.log(tag, "Api Call :\n $token ");

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 ( compatible )',
        'Accept': '*/*',
        'Authorization': 'Bearer $token'
      },
    );

    Utility.log(tag,"${response.body}");
    getTokenExpiremsg(response.body,context);
    return response;

  }

Future<http.Response> DelWithMyToken(context,String url,String token) async {

    Utility.log(tag, "Api Call :\n $url ");
    Utility.log(tag, "Api Call :\n $token ");

    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 ( compatible )',
        'Accept': '*/*',
        'Authorization': 'Bearer $token'
      },
    );

    Utility.log(tag,"${response.body}");

    getTokenExpiremsg(response.body,context);
    return response;

  }

Future<http.Response> Delt(String url) async {

  Utility.log(tag, "Api Call :\n $url ");
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 ( compatible )',
        'Accept': '*/*',
      },
    );
    print("${response.statusCode}");
    Utility.log(tag,"${response.body}");
    return response;
  }

Future<http.Response> DeleteWithMyToken(String url,String token) async
{

  Utility.log(tag, "Api Call :\n $url ");
  Utility.log(tag, "Api Call :\n $token ");
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 ( compatible )',
        'Accept': '*/*',
        'Authorization': 'Bearer $token'
      },
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;

  }

  Future<http.Response> GetLogin(var body) async {
    String url=GlobalConstant.CommanUrlLogin+"jwt-auth/v1/token";
    print(json.encode(body));
    Utility.log(tag, "Api Call :\n $url ");
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body)
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

Future<http.Response> SetSignUp(var body) async {

  String username = 'admin';
  String password = 'admin123';
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  print(basicAuth);

    Utility.log(tag, "Api Call :\n ${GlobalConstant.CommanUrlLogin+"wp/v2/users"}");
    var response = await http.post(GlobalConstant.CommanUrlLogin+"wp/v2/users",
      headers: {'authorization': basicAuth},
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;

  }


  void getTokenExpiremsg(var value,context) {
    bool val=false;
    try
    {
     // var data1=value;
     var data1 = json.decode(value);


     Utility.log(tag, "ApiCallmsg  :${value}");

      if(data1["message"].toString().toLowerCase().contains("token"))
        {
          Utility.log(tag, "ApiCallmsg  :\n ${data1["code"]}");
          val=true;
        }
      else if(data1["code"].toString().trim().contains("jwt_auth_bad_auth_header"))
        {
          val=true;
          Utility.log(tag, "ApiCallmsg  :\n ${data1["code"]}");
          //;
        }
      else if(data1["data"]["status"].toString().contains("403"))
        {
          val=true;
          Utility.log(tag, "ApiCallmsg  :\n ${data1["code"]}");
          //;
        }
        }catch(e)
    {

      Utility.log(tag, "ApiCallmsg  :${e}");

    }
    if(val==true)
      {
        GlobalWidget.GetToast(context, "Token Expire");
       // Navigator.of(context).pop();
        Utility.setStringPreference(GlobalConstant.login, "");


      }
  }
}
