import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:salon_app/Availabilty/ConfirmationClass.dart';
import 'package:salon_app/Global/AppColor.dart';
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
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


class SchduledClassActivity extends StatefulWidget {
 
    var data;

    SchduledClassActivity(this.data);

  @override
  _SchduledClassActivityState createState() => new _SchduledClassActivityState();
}

class _SchduledClassActivityState extends State<SchduledClassActivity> {

 //  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.red,
        //borderRadius: BorderRadius.all(Radius.circular(2)),
        border: Border.all(color: Colors.blue, width: 1.0)),

  );

  String returnMonth(DateTime date) {
    return new DateFormat.MMMM().format(date).toUpperCase()+"  "+new DateFormat.y().format(date).toUpperCase();
  }

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    ///
    ///


     SubmitData();

    super.initState();
  }  var data;
String _targetDateTime="";
  List<String> litems = ["1","2","Third","4"];
  @override
  Widget build(BuildContext context) {
    data=widget.data;


    return new Scaffold(

        body:  new Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 7,
              child: data!=null?new ListView(
                children: [

                  new Container(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: new Text(
                      GlobalFile.getCaptialize(data['vendor_display_name']),
                      style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  data['vendor_shop_logo']!=null?CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xffFDCF09),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage:  NetworkImage(data['vendor_shop_logo']),
                    ),
                  ):new Container(),
                  SizedBox(height: 20.0,),

                  Container(
                    alignment: Alignment.center,
                    child: new Text(
                      GlobalFile.getCaptialize(data['vendor_shop_name']),
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: new Text(GlobalFile.getCaptialize(data['vendor_address']),  style: TextStyle(fontSize: 14.0, color: Colors.black),),
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                    alignment: Alignment.center,
                    child: new Text(
                      "10:00 AM to 8:00 PM ",
                      style: TextStyle(fontSize: 14.0, color: Colors.blue),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: new Text(
                      "Select Available Date ".toUpperCase(),
                      style: TextStyle(fontSize: 24.0, color: GlobalConstant.getTextColor()),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                      child: Text(
                        GlobalFile.getStringValue(_targetDateTime),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                      )),
                ],
              ):new Container(),),

              Expanded(
                flex: 3,
                child:   new ListView.builder
                  (
                    itemCount: litems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (_) => new Confirmation( GlobalFile.getCaptialize(data['vendor_display_name']),_targetDateTime)));
                        },
                        child: getData(index),
                      );
                    }
                ),),
              //

            ],
          ),
        ));
  }

  List products=new List();
  String TAG = "VenderSchduledClassActivity";

  void SubmitData() async {
    _targetDateTime = (await Utility.getStringPreference(GlobalConstant.Selected_Date));


    /* Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };

    print("body$body");
   */

    String Verder_Id = (await Utility.getStringPreference(GlobalConstant.Verder_Id));
    String Url = GlobalConstant.CommanUrl + "store-vendors/"+Verder_Id;

    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check())
    {
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

  getData(int index) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Row(
          children: [
            Expanded(flex: 1,
              child: Icon(Icons.add,size: 30.0,color: Colors.grey,),),
            SizedBox(width: 10.0,),
            Expanded(flex: 4,
            child: Text("Time : 11:00 AM "),),
            Expanded(flex: 5,
            child:
              new Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(AppLocalizations.of(context).translate('make_appoint'),style: TextStyle(color: GlobalConstant.getTextColor()),textAlign: TextAlign.right,),
              ),)
          ],
        ),
        new Divider(thickness: 1.0,)
      ],
    );
  }


}