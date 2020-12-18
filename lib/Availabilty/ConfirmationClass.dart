import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Payment/payemnt_activity.dart';
import 'package:salon_app/VendorList/VendorClass.dart';
import 'package:salon_app/language/AppLocalizations.dart';
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

class Confirmation extends StatefulWidget
{
  String Barber_name = "";
  String target_date = "";
  var mapbilling;
  var appointment;
  Confirmation(this.mapbilling, this.appointment);

  @override
  State<StatefulWidget> createState() {
    return ConfirmView();
  }
}

class ConfirmView extends State<Confirmation>
{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: new Scaffold(
          body: new Container(
            alignment: Alignment.center,
            decoration: GlobalWidget.getbackground1(),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: new ListView(
                shrinkWrap: true,
                children: [

                    new Container(
                      alignment: Alignment.center,
                      width: 100.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/white_logo.png'),
                        ),
                      )
                    ),

                    SizedBox(
                      height: 30.0,
                    ),

                     new Container(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context).translate('Thanks_choose'),
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                      ),

                    new Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.Barber_name,
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                    ),

                    SizedBox(
                      height: 30.0,
                    ),

                    new Container(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).translate('See_you') +
                          " " +
                          widget.target_date +
                          " " +
                          Order_Time,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        // UpdateData1();
                        _onBackPressed();
                      },
                      child: Icon(
                        Icons.clear,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool> _onBackPressed() {

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                CommonDashBord("vendor_list", false)),
        ModalRoute.withName('/'));

    /*return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CommonDashBord("my_appoint", true)));*/

    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CommonDashBord("my_order", true)));

  }

  Future<void> UpdateData1() async
  {
    List a1 = new List();
    List a2 = new List();

    Map<String, dynamic> mapobj_meta() => {'key': "خيارات (100ر.س)", 'value': "قصير"};

    Map<String, dynamic> mapobj_meta1() => {'key': "Location", 'value': "home"};

    Map<String, dynamic> mapobj_meta2() => {'key': "_vendor_id", 'value': "2"};

    a2.add(mapobj_meta());
    a2.add(mapobj_meta1());
    a2.add(mapobj_meta2());

    Map<String, dynamic> mapobj_items() => {
          'product_id': data['id'].toString(),
          'quantity': 1,
          'subtotal': data['price'].toString(),
          'total': data['price'].toString(),
          'meta_data': a2,
        };
    a1.add(mapobj_items());
    /* Map<String, dynamic> map1() => {
      'line_items': a1,
    };*/

    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));

    Map<String, dynamic> map2() => {
          'set_paid': true,
          "status": "processing",
          'billing': widget.mapbilling,
          'customer_id': USER_ID,
          "_customer_user": USER_ID,
          'line_items': a1,
          'appointment': widget.appointment,
        };

    print("datatval2 ${json.encode(map2())}");
    String url=GlobalConstant.CommanUrlLogin + "wc/v3/orders/";
  //  url="http://salon.microband.site/wp-json/wc/v2/orders?";

    ApiController apiController = new ApiController.internal();
    GlobalFile globalFile = new GlobalFile();
    if (await NetworkCheck.check())
    {
      String token = (await Utility.getStringPreference(GlobalConstant.admin_token));
      Dialogs.showProgressDialog(context);
      apiController.PostsNewWithToken(
              url,
              json.encode(map2()),
              token).then((value) async {
        try
        {
          Dialogs.hideProgressDialog(context);
          try
          {
            var data1 = json.decode(value.body);

            removeCartData();
          }catch(e)
          {

          }
         // Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new PayemntActivity()));
         /*
             if (data1['status'] == 0)
              {
               // products=data1['ds']['tables'][0]['rowsList'];
              } else
              {
                GlobalWidget.showMyDialog(context, "Error", data1['msg'].toString());
              }
          */
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
    getLocalData();
    SubmitData();

  }

  var data;
  void SubmitData() async
  {

    String token = (await Utility.getStringPreference(GlobalConstant.admin_token));
    String Product_ID = (await Utility.getStringPreference(GlobalConstant.Order_Product_Id));
    String Url = GlobalConstant.CommanUrl + "products/" + Product_ID;
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(Url, token).then((value) {
        try {
          Dialogs.hideProgressDialog(context);
          data = json.decode(value.body);
          setState(() {
            UpdateData1();
          });
        } catch (e) {
          // GlobalWidget.showMyDialog(context, "Error", ""+e.toString());
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }


  void removeCartData() async
  {

    String Product_ID = (await Utility.getStringPreference(GlobalConstant.Order_Product_Id));
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrlLogin + "wcfmmp/v1/cart/remove-item?id="+Product_ID;
    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check())
    {
     // Dialogs.showProgressDialog(context);
      apiController.DelWithMyToken(Url,token).then((value)
      //apiController.Delt(Url).then((value)
      {
        try
        {
         // Dialogs.hideProgressDialog(context);

        } catch (e)
        {
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  String Order_Time = "";
  String TAG = "Confirmation Class";
  Future<void> getLocalData() async {
    widget.Barber_name = (await Utility.getStringPreference(GlobalConstant.Order_Name));
    widget.target_date = (await Utility.getStringPreference(GlobalConstant.Order_Date));
    Order_Time = (await Utility.getStringPreference(GlobalConstant.Order_Time));
    Utility.log(TAG, widget.Barber_name);
    Utility.log(TAG, widget.target_date);
    Utility.log(TAG, Order_Time);
    setState(() {});
  }
}
