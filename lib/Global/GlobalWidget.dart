import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import 'package:toast/toast.dart';
import 'AppColor.dart';
class GlobalWidget
{
  static GetToast(BuildContext context,String msg)
  {
    return Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  static Future<void> showMyDialog(BuildContext context,String title ,String msg) async
  {
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

  static getAppBar(String Title,BuildContext context,bool val)
  {
    return PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            leading: val==true?IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ):new Container(),

            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),

            backgroundColor: Colors.white,

            automaticallyImplyLeading: true, // hides leading widget

            flexibleSpace: new Container(
              alignment: Alignment.center,
              child: new ListView(
                shrinkWrap: true,
              //  mainAxisAlignment: MainAxisAlignment.center,
               // crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(

                    alignment: Alignment.center,
                    height: 30.0,
                    child: getImage("logo_header.png"),
                  ),

                  Text(Title.toUpperCase(),style: TextStyle(color: GlobalConstant.getTextColor()),textAlign: TextAlign.center,),

                ],
              ),
            ),
          )
      ) ;
  }

  static TextFeildDecoration(String s, [IconData perm_identity]) {
    return new InputDecoration(
      hintText: s,
      prefixIcon:    perm_identity!=null ?Icon(perm_identity):null,
      //fillColor: Colors.black,
      focusedBorder:UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      //filled: true,
      /* enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red)),
      filled: true,
     */
      contentPadding:GlobalWidget.getContentPadding(),

    );
  }


  static textbtnstyle() {
    return TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 22.0);
  }

  static textbtnstyleDark() {
    return TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22.0);
  }

  static getIcon(bool _obscureText) {
    return Icon(_obscureText ? Icons.visibility_off : Icons.visibility,);
  }


  static getContentPadding() {
    return null;
  }

  static TextFeildDecoration1(String s) {
    return new InputDecoration(
      hintText: s,
      fillColor: Colors.white,

      /* enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red)),
      filled: true,
     */
    );
  }


  static getButtonTheme() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(color: Colors.black)
    );
  }


  static getBtnTextColor() {
    return  Colors.black;
  }
  static getBtnTextColorDark() {
    return  Colors.white;
  }

  static getBtncolor() {
    return Colors.transparent;
  }



  static getBtncolorDark() {
    return Colors.black;
  }


  static getNoRecord(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }

  static getpadding() {
    return EdgeInsets.all(10.0);
  }

  static sizeBox1() {
    return SizedBox(height: 20.0,);
  }

  static getbackground() {
    return  BoxDecoration(
        color: Colors.white,
    image: new DecorationImage(
    fit: BoxFit.cover,
    colorFilter:
    ColorFilter.mode(Colors.white.withOpacity(0.44),
    BlendMode.dstATop),
    image: AssetImage('images/bg_1.png'),
      /*  image: DecorationImage(
            image: AssetImage('images/bg_1.png'),fit: BoxFit.fill)*/));
  }

  static getbackground1() {
    return  BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            colorFilter:
            ColorFilter.mode(Colors.grey.withOpacity(0.2),
                BlendMode.dstATop),
            image: AssetImage('images/confirm.png'),fit: BoxFit.fill));
  }

  static getHeader(BuildContext context) {
    return
      /*new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       // SizedBox(height: 10.0,),
        new Container(
            alignment: Alignment.topLeft,
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/top_icon.png')),)
        ),
        new Container(
          margin: EdgeInsets.only(left: 20.0),
          alignment: Alignment.topLeft,
          child: Text(AppLocalizations.of(context).translate('Tapered'),style: TextStyle(color: Colors.black,fontSize: 40.0),),
        ),
      ],
    )*/

      Stack(
        children: <Widget>[
          new Container(
              alignment: Alignment.topLeft,
              width: 180.0,
              height: 180.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/top_icon.png')),)
          ),

          new Container(
            margin: EdgeInsets.only(left:130.0,top: 25.0),
            alignment: Alignment.topLeft,
            child: Text(AppLocalizations.of(context).translate('Tapered'),style: TextStyle(color:  const Color(0xFF757575),fontSize: 30.0),),
          ),
        ],
      )
    ;
  }
}