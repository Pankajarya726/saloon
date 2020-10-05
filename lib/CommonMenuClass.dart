import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Availabilty/AvailabiltyClass.dart';

import 'DrawerPackage/SideDrawer.dart';
import 'Global/GlobalWidget.dart';
import 'VendorList/VendorClass.dart';
import 'VendorList/VendorDetailClass.dart';
import 'language/AppLocalizations.dart';

class CommonDashBord extends StatefulWidget{
  String From;
  bool back_icon;

  CommonDashBord(this.From,this.back_icon);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return CommonView();
  }

}

class CommonView extends State<CommonDashBord>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(

      appBar: GlobalWidget.getAppBar( AppLocalizations.of(context).translate('barber_account'),context,widget.back_icon),
      drawer: SideDrawer(),
      key: _scaffoldKey,
      body: getBody(),
      bottomNavigationBar: getBottomView(),
    );
  }

  getBottomView() {
    return new Container(
      padding: EdgeInsets.only(top: 10.0,left: 20.0,bottom: 10.0),
      child: new Row(
        children: [
          Expanded(flex: 8,
          child: Text(AppLocalizations.of(context).translate('Tapered'),style: TextStyle(color: Colors.white,fontSize: 20.0),),),
          Expanded(flex: 2,
          child: InkWell(
            child: Icon(Icons.menu,color: Colors.white,size: 30.0,),
            onTap: (){
              _scaffoldKey.currentState.openDrawer();
            },
          ),),
        ],
      ),
    );
  }

  getBody() {
    switch(widget.From)
    {
      case "vendor_list":
       return VendorActivity();
        break;
      case "vendor_dtl":
       return VendoeDetailActivity();
        break;
      case "vendor_avail":
       return AvailabiltyActivity();
        break;
    }
  }

}