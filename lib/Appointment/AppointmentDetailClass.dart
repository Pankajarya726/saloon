import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
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

class AppointDetailActivity extends StatefulWidget
{
  var data;
  AppointDetailActivity(this.data);

  @override
  State<StatefulWidget> createState() {
    return AppointDetailView();
  }
}

class AppointDetailView extends State<AppointDetailActivity>
{
  List AppointMent_List = new List();

  var Sereverdata;

  String TAG="AppointmentView";
  void SubmitData() async
  {
    Utility.log(TAG, widget.data);
    /*
    Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };
    print("body$body");
   */

    String token = (await Utility.getStringPreference(GlobalConstant.admin_token));
    Utility.setStringPreference(GlobalConstant.Product_ID, widget.data.toString());
    String Url = GlobalConstant.CommanUrl+"products/"+widget.data["product_id"].toString();
    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(context,Url,token).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          Sereverdata = json.decode(value.body);
          Utility.log(TAG, Sereverdata["name"]);
          /*for(int i=0;i<data['images'].length;i++)
          {
            _list.add(data['images'][i]['src']);
          }*/
          // _list=data['images'];
          setState(() {
          });
        }catch(e)
        {
          // GlobalWidget.showMyDialog(context, "Error", ""+e.toString());
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
        [/*
          new Container(
            padding: EdgeInsets.all             (10.0),
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
                          Expanded(child:  Text(widget.data["currency"]+" "+widget.data["total"],style: TextStyle(color: GlobalConstant.getTextColor(),fontSize: 14.0),textAlign: TextAlign.end,),),
                        ],
                      ),

                      SizedBox(height: 10,),

                      new Row(
                       children: [
                         Expanded(child: Text(widget.data["status"],style: TextStyle(color: Colors.black,fontSize: 16.0),),),
                         Expanded(child: Text(widget.data["date_created"],style: TextStyle(color: GlobalConstant.getTextColor(),fontSize: 14.0),textAlign: TextAlign.end,),)
                       ],
                     ),

                     ],
                  ),
                ),

              ],
            ),
          ),*/
          SizedBox(height: 20,),

          /*

          Sereverdata!=null?billingInfo(AppLocalizations.of(context).translate("Start Date"),GlobalConstant.get_Dateval(Sereverdata[0]["start"])):new Container(),
          Sereverdata!=null?:new Container(),
      */
          billingInfo(AppLocalizations.of(context).translate("st_date"),GlobalConstant.get_Dateval(widget.data["start"])+"  "+GlobalConstant.readTimestamp(widget.data["start"])),
          billingInfo(AppLocalizations.of(context).translate("o_date"),GlobalConstant.get_Dateval(widget.data["date_created"])+"  "+GlobalConstant.readTimestamp(widget.data["date_created"])),
          billingInfo(AppLocalizations.of(context).translate("o_id"),widget.data["order_id"].toString()),
          billingInfo(AppLocalizations.of(context).translate("status"),widget.data["status"]),
          billingInfo(AppLocalizations.of(context).translate("cu_status"),widget.data["customer_status"]),
         // billingInfo(AppLocalizations.of(context).translate("company"),widget.data["qty"].toString()),
          billingInfo(AppLocalizations.of(context).translate("cu_name"),widget.data["customer_name"]),

          Sereverdata!=null?ListView.builder(
              itemCount: 1,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: ()
                  {

                  },
                  child: getData(index),
                );
              }):new Container(),
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
            Expanded(flex: 4,
              child: new Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Text("S",style: TextStyle(color: Colors.white),),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: GlobalConstant.getTextColor(),
                  //  shape: BoxShape.circle,
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.99), BlendMode.dstIn),

                        image: new NetworkImage(Sereverdata['images'][0]['src']
                        ),
                        fit: BoxFit.fill
                    )
                ),
              ),),
              SizedBox(width: 40,),
              Expanded(
                flex: 6,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 10,),
                    Text(Sereverdata["name"],style: TextStyle(color: Colors.black),),
                    SizedBox(height: 10,),
                    Text(Sereverdata["categories"][0]["name"],style: TextStyle(color: Colors.black),),
                    //Text("Price "+Sereverdata["price"]+"/-",style: TextStyle(color: Colors.black),),
                    Html(
                      data: Sereverdata["price_html"],

                      onLinkTap: (url) {
                        print("Opening $url...");
                      },
                    ),
                   // SizedBox(height: 10,),
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