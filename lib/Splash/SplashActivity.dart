import 'dart:async';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/VendorList/VendorClass.dart';
import 'package:salon_app/language/SelectlanguageActivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CommonMenuClass.dart';

class SplashActivity extends StatefulWidget {
  @override
  State createState() => SplashScreen();
}

class SplashScreen extends State<SplashActivity> {
  @override
  Future<void> initState() {
    super.initState();
    checkStatus();
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

    if (login.isEmpty) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SelectLanguageActivity())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder:
                  (context) => /*HomeActivity*/ CommonDashBord("vendor_list",false))));
    }
  }
}
