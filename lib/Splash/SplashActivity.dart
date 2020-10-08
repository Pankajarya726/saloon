import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/SignInSignUpAccount/SignInClass.dart';
import 'package:salon_app/VendorList/VendorClass.dart';
import 'package:salon_app/language/SelectlanguageActivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CommonMenuClass.dart';

import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';


class SplashActivity extends StatefulWidget {
  @override
  State createState() => SplashScreen();
}

class SplashScreen extends State<SplashActivity> {
  @override
  Future<void> initState() {
    super.initState();
    checkStatus();
    getAdminToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: Colors.black,
        child:  Container(child: GlobalWidget.getImage("white_logo.png"),height: 100.0,),

      ),
    );
  }
  Future<void> checkStatus() async {
    String login = await Utility.getStringPreference(GlobalConstant.login);
    String language_select = await Utility.getStringPreference(GlobalConstant.language_select);

    if (language_select.isEmpty) {
      Timer( Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SelectLanguageActivity())));
    } else
    {
      if(login.isEmpty)
        {

          Timer(
              Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => /*HomeActivity*/ SignInActivity())));

        }else
          {

            Timer(
                Duration(seconds: 3),
                    () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => /*HomeActivity*/ CommonDashBord("vendor_list",false))));

          }

    }
  }


  Future<void> getAdminToken() async {
    Map<String, String> body =
    {
      'username': "admin",
      'password':"admin123",
    };

    print("body$body");



    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      apiController.GetLogin(body).then((value) {

        var data1 = json.decode(value.body);
        try {
          String token=data1['token'];
          Utility.setStringPreference(GlobalConstant.admin_token, token);


        } catch (e) {

      }
      });
    } else {
    }
  }

}
