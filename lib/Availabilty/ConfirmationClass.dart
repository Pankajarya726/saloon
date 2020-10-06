import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/VendorList/VendorClass.dart';
import 'package:salon_app/language/AppLocalizations.dart';

import '../CommonMenuClass.dart';

class Confirmation extends StatefulWidget
{
  String Barber_name,target_date;
  Confirmation(this.Barber_name, this.target_date);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return ConfirmView();
  }

}

class ConfirmView extends State<Confirmation>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: _onBackPressed,
        child:new Scaffold(
      body: new Container(
        alignment: Alignment.center,
        decoration:GlobalWidget.getbackground1(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: new ListView(
            shrinkWrap: true,
            children: [
              new Container(
                  alignment: Alignment.center,
                  width: 100.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/white_logo.png'),),)
              ),
              SizedBox(height: 30.0,),
              new Container(
                alignment:Alignment.center,
                child: Text(AppLocalizations.of(context).translate('Thanks_choose'),style: TextStyle(color: Colors.white,fontSize: 30.0),),
              ),
             new Container(
                alignment:Alignment.center,
                child: Text(widget.Barber_name,style: TextStyle(color: Colors.white,fontSize: 30.0),),
              ),
              SizedBox(height: 30.0,),
              new Container(
                alignment:Alignment.center,
                child: Text(AppLocalizations.of(context).translate('See_you')+" "+widget.target_date,style: TextStyle(color: Colors.blueGrey,fontSize: 20.0),),
              ),
              SizedBox(height: 30.0,),
              new Container(
                alignment:Alignment.center,
                child: InkWell(
                  onTap: (){
                    _onBackPressed();
                  },
                  child: Icon(Icons.clear ,size: 30.0,color: Colors.white,  ),
                ),

              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<bool> _onBackPressed() {
    return Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) => CommonDashBord("vendor_list",false)),
        ModalRoute.withName('/'));
  }
}