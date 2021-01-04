import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:salon_app/Availabilty/ConfirmationClass.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import '../CommonMenuClass.dart';

class CartActivity extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
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
                 }),
                 billingInfo(AppLocalizations.of(context).translate("book_date"),listdata[0]["appointment"]["date"]),
                 billingInfo(AppLocalizations.of(context).translate("duration"),listdata[0]["appointment"]["duration"]),
                 billingInfo(AppLocalizations.of(context).translate("time"),listdata[0]["appointment"]["time"]),
                 billingInfo(AppLocalizations.of(context).translate("total"), data["total"]),
                 PaymentInfo(AppLocalizations.of(context).translate("payment"), data["total"]),
                 SizedBox(height: 20,),
                 GetBarberButton()
           ],
         ):new Container(
           height: MediaQuery.of(context).size.height,
           child: new Center(
             child: Text(AppLocalizations.of(context).translate("empty_cart")),
           ),
         ),
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

  List <String> payment_typeItems = GlobalConstant.GetPaymentMethod();
  String payment_type = GlobalConstant.GetPaymentMethod()[0].toString();

  getpayment_type() {
    return
      new Theme(
          data: GlobalConstant.getSpinnerTheme(context),
          child: DropdownButton<String>(
            value: payment_type,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: GlobalConstant.getTextStyle(),
            underline:GlobalConstant.getUnderline(),
            onChanged: (String data) {
              setState(() {
                payment_type = data;
              });
            },
            items: payment_typeItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ));
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

  PaymentInfo(String title, String description) {
    return new Container(
      padding: EdgeInsets.only(left: 8.0,right: 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Row(
            children:
            [
              Expanded(child: Text(title),),
              Expanded(child: getpayment_type(),),
            ],
          ),

          Divider(thickness: 2.0,)
        ],
      ),
    );
  }


  void removeCartData() async
  {
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrlLogin + "wcfmmp/v1/cart/remove-item?id="+id;
    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));
    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.DelWithMyToken(Url,token).then((value)
      //apiController.Delt(Url).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
         // var data1 = json.decode(value.body);
         // Navigator.of(context).pop();
          listdata=null;
          data=null;
          getCartData();

        } catch (e)
        {
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }
  String id="";
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
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(flex: 9,
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
                    ),),
                    Expanded(flex: 1,
                    child: InkWell(
                      onTap: (){
                        id=listdata[index]["data"]["id"].toString();
                        //ads
                        showMyDialog(context);
                      },
                      child: new Icon(Icons.close,color: Colors.black,size: 30.0,),
                    ),)
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

  String TAG="TAG";
  var profile;

  void getExistData(var appointmentarray) async
  {
    String store_id = (await Utility.getStringPreference(GlobalConstant.store_id));
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrlLogin + "wp/v2/users/"+store_id;
    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(Url,token).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data1 = json.decode(value.body);
          // data = data1;
          Utility.log(TAG, data1['meta']);
          if (data1.length != 0)
          {
            profile=data1;
            setState(()
            {
              try
              {
                if(GlobalFile.getStringValue(profile['meta']['city'][0])==""|| GlobalFile.getStringValue(profile['meta']['state'][0])==""|| GlobalFile.getStringValue(profile['meta']['address_1'][0])==""|| GlobalFile.getStringValue(profile['meta']['postcode'][0])=="")
                {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (_)=> new  CommonDashBord("edit_bill", true)),).then((val)
                  {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if(val!=null)
                    {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new Confirmation(val,appointmentarray,payment_type)));
                    }
                  });
                }else{
                  Map<String, dynamic> mapBilling() => {
                    "first_name" : profile['meta']['first_name'][0],
                    "last_name" :  profile['meta']['last_name'][0],
                    "company" : "",
                    "address_1" :  profile['meta']['address_1'][0],
                    "address_2" :  profile['meta']['address_1'][0],
                    "city" :  profile['meta']['city'][0],
                    "state" :  profile['meta']['state'][0],
                    "postcode" :  profile['meta']['postcode'][0],
                    "email" :  profile['meta']['email'][0],
                    "phone" :  profile['meta']['phone'][0]
                  };
                  Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new Confirmation(mapBilling(),appointmentarray,payment_type)));
                }
              }catch(e)
              {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_)=> new  CommonDashBord("edit_bill", true)),).then((val)
                {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if(val!=null)
                  {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new Confirmation(val,appointmentarray,payment_type)));
                  }
                });
              }
            });
          } else {
          }
        } catch (e)
        {

        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  GetBarberButton()
  {
    return new Container(
      height: 50.0,
      margin: EdgeInsets.all(20.0),
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolorDark(),
        textColor: GlobalWidget.getBtnTextColorDark(),
        onPressed: ()
        {
          print(json.encode(listdata[0]));
          Map<String, dynamic> appointment() =>
              {
                "timezone" : "Asia/Karachi",
                //"time" : listdata[0]["appointment"]["_time"],
                "time" : listdata[0]["appointment"]["time"],
                "qty" : "1",
                "start_date" : listdata[0]["appointment"]["_start_date"],
                "end_date" : listdata[0]["appointment"]["_end_date"],
                "all_day" : "0",
                "duration" : listdata[0]["appointment"]["_duration"],
                "cost" :  listdata[0]["appointment"]["_cost"]
              };
          Utility.log(TAG, listdata[0]["data"]["store"]["vendor_display_name"]);
          Utility.log(TAG, listdata[0]["appointment"]["date"]);
          Utility.log(TAG, listdata[0]["appointment"]["time"]);
          Utility.setStringPreference(GlobalConstant.Order_Name, GlobalFile.getCaptialize(listdata[0]["data"]["store"]["vendor_display_name"]));
          Utility.setStringPreference(GlobalConstant.Order_Date,  listdata[0]["appointment"]["date"]);
          Utility.setStringPreference(GlobalConstant.Order_Time,  listdata[0]["appointment"]["time"]);
          Utility.setStringPreference(GlobalConstant.Order_Product_Id, listdata[0]["data"]["id"].toString());

          if(payment_type.toLowerCase()=="select")
          {
                  GlobalWidget.showMyDialog(context, "", AppLocalizations.of(context).translate("payment_msg"));
          }else
            {
                  getExistData(appointment());
            }
        },
        child: Text(AppLocalizations.of(context).translate("check_out"),style: GlobalWidget.textbtnstyleDark(),),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate("sure")),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(""+AppLocalizations.of(context).translate("remov_msg")),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).translate("YES")),
              onPressed: ()
              {
                Navigator.of(context).pop();

                removeCartData();
              },
            ), FlatButton(
              child: Text('NO'),
              onPressed: ()
              {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState()
  {
    getCartData();
  }
}