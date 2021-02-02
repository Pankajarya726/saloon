import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:salon_app/DrawerPackage/SideDrawer.dart';
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

class VendorActivity extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return VendorView();
  }
}

class VendorView extends State<VendorActivity>
{
  List<DataModel> _list=new List();

  @override
  Widget build(BuildContext context) {
   return WillPopScope(
       onWillPop: _onBackPressed,
       child:new Scaffold(
       body: _list.length==0?GlobalWidget.getLoading(context):
        new Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child:  new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text( AppLocalizations.of(context).translate('barber_list'),style: TextStyle(fontSize: 20.0),),
                ),),

              Expanded(
                flex: 9,
                child:
                new GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: new List.generate(_list.length, (index)
                  {
                    return InkWell(
                      onTap:()
                        {
                          Utility.setStringPreference(GlobalConstant.Verder_Id, _list[index].data['vendor_id'].toString());
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (_) => new CommonDashBord("Product_list",true,_list[index].data)));
                        },
                      child: Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 6,
                            child:Container(
                              padding: EdgeInsets.all(5.0),
                              child:  new Text(GlobalFile.getCaptialize(_list[index].data['vendor_shop_name']),style: TextStyle(color: GlobalConstant.getTextColor(),fontSize: 18.0),),
                            )),
                            Expanded(flex: 4,
                            child:  Stack(
                              children: <Widget>[
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors:
                                    [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                                child:    new Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    new Container(
                                      height: 20.0,
                                      child: Container(
                                          padding: EdgeInsets.only(left: 5.0),
                                          decoration: new BoxDecoration(
                                              borderRadius: new BorderRadius.only(
                                                  topLeft:  const  Radius.circular(20.0),
                                                  bottomLeft: const  Radius.circular(20.0)),
                                              gradient: new LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.topRight,
                                                colors: [
                                                  Colors.blueGrey.withOpacity(0.99),
                                                  Colors.blueGrey.withOpacity(0.12)
                                                ],
                                              )),
                                          child: new Row(
                                            children: [

                                              new Text(
                                                GlobalFile.getCaptialize(_list[index].data['vendor_email']),style: TextStyle(color: Colors.white,fontSize: 12.0),)
                                            ],
                                          )),
                                    ),
                                    SizedBox(height: 10.0,),
                                    GlobalFile.getStringValue(_list[index].data['vendor_phone'])==""?new Container():new Container(
                                      height: 20.0,
                                      child: Container(
                                          padding: EdgeInsets.only(left: 5.0),
                                          decoration: new BoxDecoration(
                                              borderRadius: new BorderRadius.only(
                                                  topLeft:  const  Radius.circular(20.0),
                                                  bottomLeft: const  Radius.circular(20.0)),
                                              gradient: new LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.topRight,
                                                colors: [
                                                  Colors.blueGrey.withOpacity(0.99),
                                                  Colors.blueGrey.withOpacity(0.12)
                                                ],
                                              )),
                                            child: new Row(
                                            children:
                                            [
                                              new Text(
                                                GlobalFile.getCaptialize(_list[index].data['vendor_phone']),style: TextStyle(color: Colors.white,fontSize: 12.0),)
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            )]),
                         )
                          ],
                        ),

                        margin: EdgeInsets.all(8.0),
                       // padding: EdgeInsets.only(top: 5.0,right: 5.0,left: 10.0),

                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black,
                            image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                                image: new NetworkImage(
                                    _list[index].data['vendor_banner']),
                                fit: BoxFit.fill),/*
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black,
                            image: DecorationImage(
                                colorFilter: new ColorFilter.mode(Colors.grey.withOpacity(0.66), BlendMode.dstATop),
                                image: new NetworkImage(
                                    _list[index].data['vendor_banner']
                                ),
                                fit: BoxFit.fill
                            )*/
                        ),
                      ),


                    );
                  }),
                ),)
            ],
          ),
        ),
    ));
  }

  String TAG="VendorView";

  void SubmitData() async
  {
   /*
   Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };
    print("body$body");
   */
    String Url = GlobalConstant.CommanUrl+"store-vendors";


    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.Get(context,Url).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = value;
          var data1 = json.decode(data.body);
          Utility.log(TAG, data1);
          if (data1.length != 0)
          {
            for(int i=0;i<data1.length;i++)
              {
                _list.add(new DataModel(data1[i]));
              }
            setState(() {

            });
          } else {
            GlobalWidget.showMyDialog(context, "Error", data1.toString());
          }
        }catch(e)
        {
          GlobalWidget.showMyDialog(context, "Error", ""+e.toString());
        }
      });
    }else
    {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  @override
  void initState() {
    SubmitData();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(AppLocalizations.of(context).translate("sure")),
        content: new Text(AppLocalizations.of(context).translate("exit_msg")),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context).translate("NO")),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).translate("YES")),
          ),
        ],
      ),
    ) ??
        false;
  }
}

class DataModel
{
  var data;

  DataModel(this.data);
}