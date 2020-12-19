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
  static String Order_Product_Id="order_product_id";
  static String User_Email="user_email";
  static String Selected_Date="selected_date";
  static String token="token";
  static String admin_token="admin_token";
  static String user_email="user_email";
  static String store_id="store_id";
  static String roles="roles";
  static String login="login";
  static String language_select="language_select";

  static var myFattorhUrl="https://apitest.myfatoorah.com";

  static var MyFatoorhToken="rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

  /*
  payemnt
  https://myfatoorah.readme.io/docs/demo-information
  mastercardinfo
  5123450000000008
  05 / 21
  100
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
    return SignInActivity();
  }

  static List<String> GetIntItems() {
    List <String> durationIntItems =
     [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
    ];
    return durationIntItems;
  }
  static List<String> GetStringItems() {
    List <String> durationIntItems =
     [
      'Minute',
      'Hour',
      'Day',
      'Month',
    ];
    return durationIntItems;
  }


  static getTextStyle() {
    return TextStyle(color: Colors.black54, fontSize: 18);
  }

  static getSpinnerTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      canvasColor: Colors.grey,
    );
  }

  static getUnderline() {
    return  Container(
      height: 2,
      color: Colors.grey,
    );
  }

  static getDurationString(String s) {
    return  Text(s,style: TextStyle(fontSize: 20),);
  }

  static getDurationStringText(String s) {
    return  Text(s,style: TextStyle(fontSize: 12),);
  }

}