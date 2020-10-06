import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';

import '../CommonMenuClass.dart';

class ProductDetailActivity extends StatefulWidget {
  var data;

  ProductDetailActivity(this.data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailView();
  }
}

class DetailView extends State<ProductDetailActivity> {
  var data;

  @override
  Widget build(BuildContext context) {
    data=widget.data;
    // TODO: implement build
    return new Scaffold(
      body: data != null
          ? new Container(
              color: Colors.grey.shade200,
              height: MediaQuery.of(context).size.height,
              child: getFulldata(),
            )
          : GlobalWidget.getNoRecord(context),
    );
  }

  String TAG = "VendorDetail";



  @override
  void initState() {

  }

  getFulldata() {
    return new ListView(
      padding: EdgeInsets.all(10.0),
      shrinkWrap: true,
      children: [
        SizedBox(
          height:20,
        ),
        Container(
          alignment: Alignment.center,
          child: new Text(
            GlobalFile.getCaptialize(data['name']),
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),

        Container(
          alignment: Alignment.center,
          child: new Text(
            GlobalFile.getCaptialize(data['slug']),
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        SizedBox(height: 5.0,),

        Container(
          alignment: Alignment.center,
          child: new Text("\$"+data['price'].toString(),
            style: TextStyle(fontSize: 18.0, color: GlobalConstant.getTextColor()),
          ),
        ),


        SizedBox(height: 5.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 260.0,
          alignment: Alignment.center,
          child: FadeInImage(
              image: NetworkImage(data['images'][0]['src']),
              fit: BoxFit.fitWidth,
              placeholder: GlobalWidget.getPlaceHolder()),
        ),
        SizedBox(height: 5.0,),
        new Center(
          child: SingleChildScrollView(
            child: Html(
              data: data['price_html'],

              onLinkTap: (url) {
                print("Opening $url...");
              },

            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),


        new Center(
          child: SingleChildScrollView(
            child: Html(
              data: data['description'],

              onLinkTap: (url) {
                print("Opening $url...");
              },

            ),
          ),
        ),


        SizedBox(
          height: 10.0,
        ),


        new Center(
          child: SingleChildScrollView(
            child: Html(
              data: data['short_description'],

              onLinkTap: (url) {
                print("Opening $url...");
              },

            ),
          ),
        ),

        GetPurches(),
        SizedBox(
          height: 10.0,
        ),
        GetBackToShop()
      ],
    );
  }


  GetPurches() {
    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: () {

          Navigator.of(context).push(new MaterialPageRoute(
              builder: (_) => new CommonDashBord("vendor_avail",true)));
        },
        child: Text(AppLocalizations.of(context).translate("purches"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }
  GetBackToShop() {

    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(AppLocalizations.of(context).translate("back_shop"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }
}
