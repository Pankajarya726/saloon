import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class CartActivity extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CartViewDetail();
  }
}

class CartViewDetail extends State<CartActivity>
{
  @override
  Widget build(BuildContext context)
  {
     return new Scaffold(

       backgroundColor: Colors.white,
         body:  listdata!=null?new ListView(
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
                         //Text("sdjfkdklsh")
                       ],
                     ),
                   ),
                 ],
               ),
             ),

             SizedBox(height: 20,),
             billingInfo(AppLocalizations.of(context).translate("book_date"),listdata[0]["appointment"]["duration"]),
             billingInfo(AppLocalizations.of(context).translate("duration"),listdata[0]["appointment"]["date"]),
             billingInfo(AppLocalizations.of(context).translate("time"),listdata[0]["appointment"]["time"]),
             billingInfo(AppLocalizations.of(context).translate("total"), data["total"]),
             listdata!=null?
             ListView.builder(
                 itemCount: listdata.length,
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
         ):new Container(),
     );
  }

  var listdata;
  var data;
  void getCartData() async
  {
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrlLogin + "wcfmmp/v1/cart/get-items";
    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));

    ApiController apiController = new ApiController.internal();

    if(await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(Url,token).then((value)
     // apiController.Get(Url).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data1 = json.decode(value.body);

          Utility.log("TAG", data1);
          data=data1;
          listdata=data1["items"];
          setState(() {
          });
          Utility.log("TAG", listdata);
          /*
          if(data1!="{}")
            {

            }else
              {

              }*/
          // data = data1;
        } catch (e)
        {
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
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

  getData(int index)
  {
    return new Container(
      padding: EdgeInsets.all(5.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Row(
            children: [
              Expanded(
                flex: 3,
                child: new Container(
                  margin: EdgeInsets.all(10.0),
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                         // colorFilter: new ColorFilter.mode(Colors.grey.withOpacity(0.66), BlendMode.dstATop),
                          image: new NetworkImage(
                              listdata[index]["data"]["images"][0]["src"]
                          ),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(listdata[index]["data"]["name"],style: TextStyle(color: Colors.black,fontSize: 20),),
                    new Text(listdata[index]["data"]["price"],style: TextStyle(color: Colors.black,fontSize: 20),),
                    Html(
                      data:listdata[index]["data"]["price_html"],
                      onLinkTap: (url) {
                        print("Opening $url...");
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(thickness: 2.0,),
        ],
      ),
    );
  }


  @override
  void initState()
  {
    getCartData();
  }
}