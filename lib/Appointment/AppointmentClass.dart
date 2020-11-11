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
import 'package:intl/intl.dart';

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

       child:new Scaffold(
       body: _list.length==0?GlobalWidget.getNoRecord(context):
        new Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 9,
                child: new ListView.builder
                  (padding: EdgeInsets.only(top: 20.0),
                    itemCount: _list.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        onTap: (){
                          /*
                          Navigator.of(context).push(new MaterialPageRoute(
                          builder: (_) => new Confirmation( GlobalFile.getCaptialize(data['vendor_display_name']),_targetDateTime)));
                         */
                          },
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
   /*
     Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };
    print("body$body");
   */

    String Url = GlobalConstant.CommanUrlLogin+"wc-appointments/v1/appointments";
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      String token = (await Utility.getStringPreference(GlobalConstant.token));
      apiController.GetWithMyToken(Url,token).then((value)
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
              Utility.log(TAG, data1[i].toString());
              _list.add(new DataModel(data1[i]));
            }
            setState(()
            {
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

  getData(int index)
  {
    return new Container(
      padding: EdgeInsets.all(5.0),
      child: new Column(
        children: [
          new Row(
            children: [
              SizedBox(width: 10.0,),
              Expanded(flex: 2,
                child: new Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  child: Text(_list[index].data["order_id"].toString()),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: GlobalConstant.getTextColor(),
                      shape: BoxShape.circle
                  ),
                ),),
              Expanded(
                flex: 8,
                child: new Container(
                  child: Row(
                    children: [
                      SizedBox(width: 20.0,),
                      Expanded(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_list[index].data["status"],style: TextStyle(color: Colors.black,fontSize: 16.0),),
                            Text("Customer Status : "+_list[index].data["customer_status"],style: TextStyle(color: GlobalConstant.getTextColor(),fontSize: 14.0),),
                            // Text(_list[index].data["customer_status"]),
                          ],
                        ),
                      ),
                      SizedBox(width: 30.0,),
                      Expanded(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:
                          [
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(flex: 2,
                                    child:  Icon(Icons.watch_later,color: Colors.grey,)),
                                SizedBox(width: 4.0,),
                                Expanded(flex: 8,
                                  child:  Text(formatTimestamp(_list[index].data["start"]),style: TextStyle(fontSize: 12.0),),),
                              ],
                            ), new Row(
                            children: [
                              Expanded(flex: 2,
                                  child:  Icon(Icons.date_range,color: Colors.grey)),
                              SizedBox(width: 4.0,),
                              Expanded(flex: 8,
                                child:  Text(get_Dateval(_list[index].data["start"]),style: TextStyle(fontSize: 12.0),),),
                            ],
                          ),

                            /*
                              Text(get_Dateval(_list[index].data["start"])),*/
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1.0,
          )
        ],
      ),
    );
  }

  String get_Dateval(int string)
  {
    int timeInMillis = string;
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate = DateFormat.yMMMd().format(date); // Apr 8, 2020
   // var formattedDate1 = DateFormat.HOUR24().format(date); // Apr 8, 2020
    return formattedDate;
  }
}
String formatTimestamp(int timestamp) {
  var format = new DateFormat('hh:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return format.format(date);
}
class DataModel
{
  var data;
  DataModel(this.data);
}