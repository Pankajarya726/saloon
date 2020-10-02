
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class SideDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,//20.0,
      height: MediaQuery.of(context).size.height,//20.0,
      child: Drawer(

          child: new Container(
            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.65)),
            width: MediaQuery.of(context).size.width,//20.0,
            height: MediaQuery.of(context).size.height,
            child: new ListView(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height/7.0,
                ),

                new Container(
                  padding: EdgeInsets.only(left: 30.0,right: 30.0),
                  child:  new Row(
                    children: [
                      Expanded(flex: 8,
                        child: Text(AppLocalizations.of(context).translate('Tapered'),style: TextStyle(color: GlobalConstant.getTextColor(),fontSize: 30.0),),),
                      Expanded(flex: 2,
                        child: InkWell(
                          child: Icon(Icons.clear,color: Colors.white,size: 30.0,),
                          onTap: (){
                              Navigator.of(context).pop();
                          },
                        ),),



                    ],
                  ),
                ),
                SizedBox(height: 60.0,),
                InkWell(
                  onTap: ()
                  {
                      Navigator.of(context).pop();
                  },
                  child: getRow(AppLocalizations.of(context).translate('Barber_near')),
                ),InkWell(
                  onTap: ()
                  {
                      Navigator.of(context).pop();
                  },
                  child: getRow(AppLocalizations.of(context).translate('my_acc')),
                ),InkWell(
                  onTap: ()
                  {
                      Navigator.of(context).pop();
                  },
                  child: getRow(AppLocalizations.of(context).translate('my_app')),
                ),InkWell(
                  onTap: ()
                  {
                      Navigator.of(context).pop();
                  },
                  child: getRow(AppLocalizations.of(context).translate('my_pref')),
                ),InkWell(
                  onTap: ()
                  {
                      Navigator.of(context).pop();
                  },
                  child: getRow(AppLocalizations.of(context).translate('terms')),
                ),InkWell(
                  onTap: ()
                  {
                      Navigator.of(context).pop();
                  },
                  child: getRow(AppLocalizations.of(context).translate('feqs')),
                ),InkWell(
                  onTap: ()
                  {
                      Navigator.of(context).pop();
                  },
                  child: getRow(AppLocalizations.of(context).translate('logout')),
                ),
              ],
            ),
          )),
    );
  }

  getRow(String s) {
    return new Container(
      padding: EdgeInsets.only(right: 100.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        new Container(
          padding: EdgeInsets.only(left: 30.0,top: 10.0,bottom: 20.0),
          child:   Text(s,style: TextStyle(color: Colors.grey,fontSize: 20.0),),
        ),
          Divider(thickness: 1.0,color: Colors.grey,)
        ],
      ),
    );
  }
}