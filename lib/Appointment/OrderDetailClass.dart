import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class OrderDetailActivity extends StatefulWidget
{
  var data;
  OrderDetailActivity(this.data);

  @override
  State<StatefulWidget> createState() {
    return OrderDetailView();
  }
}

class OrderDetailView extends State<OrderDetailActivity>
{
  List AppointMent_List = new List();

  var Sereverdata;

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
    print(widget.data);
    String Url = GlobalConstant.CommanUrlLogin+"wc-appointments/v1/appointments?parent[]="+widget.data["id"].toString();
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
          Sereverdata = json.decode(data.body);
          Utility.log(TAG, Sereverdata);
          setState(() {
          });
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
  Widget build(BuildContext context)
  {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        shrinkWrap: true,
        children:
        [
          new Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text(widget.data["line_items"][0]["name"].toString(),style: TextStyle(fontSize: 16.0),),

                      SizedBox(height: 10,),

                      new Row(
                        children: [
                          Expanded(child:  Text(AppLocalizations.of(context).translate("total"),style: TextStyle(color: Colors.black,fontSize: 16.0),),),
                          Expanded(child:  Text(widget.data["currency"]+" "+widget.data["total"],style: TextStyle(color: GlobalConstant.getTextColorDark(),fontSize: 14.0),textAlign: TextAlign.end,),),

                        ],
                      ),

                      SizedBox(height: 10,),

                      new Row(
                       children: [
                         Expanded(child: Text(widget.data["status"],style: TextStyle(color: Colors.black,fontSize: 16.0),),),
                         Expanded(child: Text( GlobalWidget.ConvertDate(widget.data["date_created"]),style: TextStyle(color: GlobalConstant.getTextColorDark(),fontSize: 14.0),textAlign: TextAlign.end,),)
                       ],
                     ),

                     ],
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 20,),
          Sereverdata!=null?billingInfo(AppLocalizations.of(context).translate("st_date"),GlobalConstant.get_Dateval(Sereverdata[0]["start"])):new Container(),
          Sereverdata!=null?billingInfo(AppLocalizations.of(context).translate("st_time"),GlobalConstant.readTimestamp(Sereverdata[0]["start"])):new Container(),
          billingInfo(AppLocalizations.of(context).translate("firstName"),widget.data["billing"]["first_name"]),
          billingInfo(AppLocalizations.of(context).translate("lastName"),widget.data["billing"]["last_name"]),
          billingInfo(AppLocalizations.of(context).translate("company"),widget.data["billing"]["company"]),
          billingInfo(AppLocalizations.of(context).translate("address"),widget.data["billing"]["address_1"]),
          billingInfo(AppLocalizations.of(context).translate("address")+" other ",widget.data["billing"]["address_2"]),
          billingInfo(AppLocalizations.of(context).translate("city"),widget.data["billing"]["city"]),
          billingInfo(AppLocalizations.of(context).translate("state"),widget.data["billing"]["state"]),
          billingInfo(AppLocalizations.of(context).translate("zipcode"),widget.data["billing"]["postcode"]),
          billingInfo(AppLocalizations.of(context).translate("country"),widget.data["billing"]["country"]),
          billingInfo(AppLocalizations.of(context).translate("email"),widget.data["billing"]["email"]),
          billingInfo(AppLocalizations.of(context).translate("phone"),widget.data["billing"]["phone"]),

          ListView.builder(
              itemCount: widget.data['line_items'].length,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: ()
                  {
                  },
                  child: getData(index),
                );
              }),
        ],
      ),
    );
  }

  getData(int index)
  {
    return new Column(
      children: [
        new Row(
          children: [

             Expanded(flex: 2,
              child: new Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: Text("S",style: TextStyle(color: Colors.white),),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: GlobalConstant.getTextColor(),
                    shape: BoxShape.circle
                ),
              ),),

              Expanded(
                flex: 8,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text(widget.data['line_items'][index]["name"],style: TextStyle(color: Colors.black),),
                  ],
                ),
              )
          ],
        ),
        Divider()
      ],
    );
  }

  @override
  void initState() {
    SubmitData();
  }

  billingInfo(String title, String description) {
    return new Container(
      padding: EdgeInsets.all(8),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Row(
            children:
            [
              Expanded(child: Text(title),),
              Expanded(child: Text(description,textAlign: TextAlign.end,),),
            ],
          ),

          Divider(thickness: 2.0,)
        ],
      ),
    );
  }
}