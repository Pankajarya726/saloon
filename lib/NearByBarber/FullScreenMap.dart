import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:location/location.dart';

class FullScreenMapActivity extends StatefulWidget {

  @override
  State createState() => FullScreenMap("1");
}

class FullScreenMap extends State<FullScreenMapActivity> {
  String  categoryKey = "";
  FullScreenMap(this.categoryKey);
  GlobalKey<GoogleMapStateBase> _key = GlobalKey<GoogleMapStateBase>();

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:GoogleMap(
        key: _key,
      ),
    );
  }

}
