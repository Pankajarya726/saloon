import 'package:flutter/material.dart';
import 'package:salon_app/VendorList/VendorClass.dart';

import '../CommonMenuClass.dart';

class GlobalConstant
{
  static var CommanUrl="http://salon.microband.site/wp-json/wcfmmp/v1/";

  static getTextColor() {
    return const Color(0xFFbfb397);
  }

  static getMainScreen() {
    return CommonDashBord("vendor_list");
  }

}