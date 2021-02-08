import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';
class EarningPoints extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return EarningView();
  }

}

class EarningView extends State<EarningPoints>
{

  @override
  void initState() {
    SubmitData();
  }


  String Total_earning="";

  void SubmitData() async
  {

    String Verder_Id = (await Utility.getStringPreference(GlobalConstant.Verder_Id));
    String Url = GlobalConstant.CommanUrl+"store-vendors/"+Verder_Id+"/total_earning/";
    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.Get(context,Url).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = json.decode(value.body);
          Total_earning=data["total_earning"].toString();
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
  Widget build(BuildContext context) {
       return new Scaffold(
         backgroundColor: Colors.white,
         body: new ListView(
           
           shrinkWrap: true,
           children: [
             Container(
               height: MediaQuery.of(context).size.height/2.5,
            //   width: 120.0,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage(
                       'images/earning.jpg'),
                   fit: BoxFit.fill,
                 ),
               ),

             ),

             Container(
               margin: EdgeInsets.all(20.0),
               child: new Card(
                 color: Colors.blue,
                 child: Column(
                   children: [
                     new Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.topLeft,
                     height: 50,
                      child: new Row(
                        children: [
                          Expanded(
                            child: Text("CUTCQ "+AppLocalizations.of(context).translate("TEarning"),style: TextStyle(color: Colors.white,fontSize: 20),),
                          ),
                          /*Expanded(
                            child: Text("\$7846",style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.right,),
                          ),*/
                        ],
                      ),
                     ),
                     new Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.bottomLeft,
                       height: 150,
                      child: new Row(
                        children: [

                          Expanded(
                            child: Text(AppLocalizations.of(context).translate("TEarning"),style: TextStyle(color: Colors.white,fontSize: 20),),
                          ),
                          Expanded(
                            child: Text("\SAR "+Total_earning,style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                     ),
                   ],
                 ),
               ),
             ),
           ],
         ),
       );
  }

}