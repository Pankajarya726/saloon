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

class AppointmentActivity extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return AppointmentView();
  }
}

class AppointmentView extends State<AppointmentActivity>
{
  List<DataModel> _list=new List();
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
       onWillPop: _onBackPressed,
       child:new Scaffold(
       body: _list.length==0?GlobalWidget.getNoRecord(context):
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

              Expanded(flex: 9,
                child:
                new ListView.builder
                  (padding: EdgeInsets.only(top: 20.0),
                    itemCount: _list.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        onTap: (){
                          /*Navigator.of(context).push(new MaterialPageRoute(
                              builder: (_) => new Confirmation( GlobalFile.getCaptialize(data['vendor_display_name']),_targetDateTime)));
                        */},
                        child: getData(index),
                      );
                    }
                ),)
            ],
          ),
        ),
    ));
  }


  String TAG="AppointmentView";

  void SubmitData() async
  {
   /* Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };
    print("body$body");
   */
    String Url = GlobalConstant.CommanUrl+"orders";


    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.GetWithToken(Url).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = value;
          var data1 = json.decode(data.body);
          Utility.log(TAG, data1[0]);
          if (data1.length != 0)
          {
            for(int i=0;i<data1.length;i++)
            {
              Utility.log(TAG,data1[i].toString() );
              _list.add(new DataModel(data1[i]));
            }
            setState(() {
              Utility.log(TAG, _list.length.toString());
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

  getData(int index)
  {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_list[index].data["status"]),
        Text(_list[index].data["date_created"]),
        Text(_list[index].data["currency"]+"  "+_list[index].data["total"]),
        Divider(
          thickness: 1.0,
        )
      ],
    );
  }

}

class DataModel
{
  var data;

  DataModel(this.data);
}