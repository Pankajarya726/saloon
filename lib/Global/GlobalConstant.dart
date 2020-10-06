import 'package:flutter/material.dart';
import 'package:salon_app/SignInSignUpAccount/SignInClass.dart';
import 'package:salon_app/VendorList/VendorClass.dart';

import '../CommonMenuClass.dart';

class GlobalConstant
{
  static var CommanUrl="http://salon.microband.site/wp-json/wcfmmp/v1/";
  static var CommanUrlLogin="http://salon.microband.site/wp-json/";
  static String Verder_Id="Vendor_id";
  static String User_Name="user_name";
  static String User_Email="user_email";
  static String Selected_Date="selected_date";
  static String token="token";
  static String user_email="user_email";
  static String store_id="store_id";
  static String roles="roles";
  static String login="login";

  /*
  https://wordpress.org/plugins/wcfm-marketplace-rest-api*/

  static getTextColor() {
    return const Color(0xFFbfb397);
  }

  static getMainScreen() {
   // return CommonDashBord("vendor_list",false);
    return SignInActivity();
  }

}