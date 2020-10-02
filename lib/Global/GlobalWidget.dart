import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:toast/toast.dart';

import 'AppColor.dart';

class GlobalWidget
{

  static GetToast(BuildContext context,String msg)
  {
    return     Toast.show(msg, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  static Future<void> showMyDialog(BuildContext context,String title ,String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(""+msg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
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

  static Widget getImage(imagename) {
    return Image(image: AssetImage('images/'+imagename));
  }
  static getPlaceHolder() {
    return  AssetImage("images/ic5.png");
  }

  static getAppBar(String Title) {
    return PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: new Container(
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.65)
                )
              ],
              color: colorPrimary
          ),
            width: double.infinity,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.0,),
                Container(
                  height: 30.0,
                  child: getImage("logo_header.png"),
                ),
                Text(Title.toUpperCase(),style: TextStyle(color: GlobalConstant.getTextColor()),),

              ],
            ),
          ),

    );
  }

  static getNoRecord(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

    );
  }
}