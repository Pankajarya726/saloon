import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class VendoeDetailActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailView();
  }
}

class DetailView extends State<VendoeDetailActivity> {
  var data;

  @override
  Widget build(BuildContext context) {
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

  void SubmitData() async {
    /* Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };

    print("body$body");
   */
    String Url = GlobalConstant.CommanUrl + "store-vendors/4";

    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.Get(Url).then((value) {
        try {
          Dialogs.hideProgressDialog(context);
          var data1 = json.decode(value.body);
          data = data1;
          Utility.log(TAG, data1);
          if (data1.length != 0) {
            setState(() {});
          } else {
            GlobalWidget.showMyDialog(context, "Error", data1.toString());
          }
        } catch (e) {
          GlobalWidget.showMyDialog(context, "Error", "" + e.toString());
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  @override
  void initState() {
    SubmitData();
  }

  getFulldata() {
    return new ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 9,
        ),
        Container(
          alignment: Alignment.center,
          child: new Text(
            GlobalFile.getCaptialize(data['vendor_display_name']),
            style: TextStyle(fontSize: 22.0, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          child: FadeInImage(
              image: NetworkImage(data['vendor_shop_logo']),
              fit: BoxFit.fitWidth,
              placeholder: GlobalWidget.getPlaceHolder()),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.center,
          child: new Text(GlobalFile.getCaptialize(data['vendor_address'])),
        ),
        Container(
          alignment: Alignment.center,
          child: new Text(
            "10:00 AM to 8:00 PM ",
            style: TextStyle(fontSize: 16.0, color: Colors.blue),
          ),
        ),
        SizedBox(
          height:30.0,
        ),
        new Row(
          children: [
            Expanded(
              child: FadeInImage(
                  image: NetworkImage(data['vendor_banner']),
                  fit: BoxFit.fitWidth,
                  placeholder: GlobalWidget.getPlaceHolder()),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: FadeInImage(
                  image: NetworkImage(data['mobile_banner']),
                  fit: BoxFit.fitWidth,
                  placeholder: GlobalWidget.getPlaceHolder()),
            ),
            SizedBox(
              width: 10.0,
            ),

            Expanded(
              child: FadeInImage(
                  image: NetworkImage(data['vendor_list_banner']),
                  fit: BoxFit.fitWidth,
                  placeholder: GlobalWidget.getPlaceHolder()),
            ),
          ],
        ),
      ],
    );
  }
}
