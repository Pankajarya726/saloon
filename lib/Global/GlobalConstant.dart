import 'package:flutter/material.dart';
import 'package:salon_app/SignInSignUpAccount/SignInClass.dart';
import 'package:salon_app/VendorList/VendorClass.dart';
import '../CommonMenuClass.dart';

class GlobalConstant
{
  static var CommanUrl="http://salon.microband.site/wp-json/wcfmmp/v1/";
  static var CommanUrlLogin="http://salon.microband.site/wp-json/";
  static var CommanUrlWeb="http://salon.microband.site";
  static String Verder_Id="Vendor_id";
  static String User_Name="user_name";
  static String Product_ID="product_id";
  static String Order_Name="order_name";
  static String Order_Date="order_date";
  static String Order_Time="order_time";
  static String User_Email="user_email";
  static String Selected_Date="selected_date";
  static String token="token";
  static String admin_token="admin_token";
  static String user_email="user_email";
  static String store_id="store_id";
  static String roles="roles";
  static String login="login";
  static String language_select="language_select";

  /*
  https://wclovers.github.io/wcfm-rest-api/#create-a-product
  design by nistha
  https://marvelapp.com/prototype/5eeh4id/screen/73234207
  design
  https://projects.invisionapp.com/share/TH6LVD2BK#/screens/144900325
  api
  https://wordpress.org/plugins/wcfm-marketplace-rest-api
  login
  http://salon.microband.site/my-account/
  card detail
  https://myfatoorah.readme.io/docs/test-cards
  http://salon.microband.site/?store-setup=yes&step=store
  */

  static getTextColor() {
    return const Color(0xFFbfb397);
  }

  static getMainScreen() {
   // return CommonDashBord("vendor_list",false);
    return SignInActivity();
  }
}