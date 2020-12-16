import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
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
  List AppointMent_List=new List();

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        shrinkWrap: true,
        children: [
          new Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [  Text(widget.data["line_items"][0]["name"].toString(),style: TextStyle(fontSize: 16.0),),
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


                    //  Divider(thickness: 2.0,),
                     ],
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 20,),

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
         // SizedBox(height: 10,),
          Divider(thickness: 2.0,)
        ],
      ),
    );
  }
}