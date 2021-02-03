import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                            child: Text("\$7846",style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.right,),
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