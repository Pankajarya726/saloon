import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'AppLanguage.dart';
import 'AppLocalizations.dart';

class SelectLanguageActivity extends StatefulWidget {
  @override
  State createState() => SelectLanguageScreen();
}

class SelectLanguageScreen extends State<SelectLanguageActivity> {
  int _radioValue1 = -1;

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(

            decoration:GlobalWidget.getbackground(),
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child:
                    GlobalWidget.getHeader(context),
                  ),
                 Expanded(
                   flex: 6,
                   child: new Column(
                     children: [
                       new Text(
                         AppLocalizations.of(context).translate('select_language'),
                         style: TextStyle(
                             fontSize: 20.0,
                             fontWeight: FontWeight.bold,
                             color: Colors.black),
                       ),
                       SizedBox(height: 40.0,),
                       new Padding(
                         padding: EdgeInsets.all(2),
                       ),
                       new Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: <Widget>[

                           new Row(
                             children: <Widget>[
                               new InkWell(
                                 onTap: ()
                                 {
                                   setState(() {
                                     _radioValue1=0;
                                   });
                                 },
                                 child: Icon(_radioValue1==0?Icons.radio_button_checked:Icons.radio_button_unchecked,
                                   color: _radioValue1==0?Colors.black:Colors.grey,
                                 ),
                               ),
                               SizedBox(width: 10.0,),
                               new Text(
                                   AppLocalizations.of(context).translate('Arabic'),
                                   style: TextStyle(
                                       color: Colors.black, fontSize: 16.0)),
                             ],
                           ),
                           new Row(
                             children: <Widget>[
                               new InkWell(
                                 onTap: ()
                                 {
                                   setState(() {
                                     _radioValue1=1;
                                   });
                                 },
                                 child: Icon(_radioValue1==1?Icons.radio_button_checked:Icons.radio_button_unchecked,
                                   color: _radioValue1==1?Colors.black:Colors.grey,
                                 ),
                               ),
                               SizedBox(width: 10.0,),
                               new Text(
                                   AppLocalizations.of(context).translate('english'),
                                   style: TextStyle(
                                       color: Colors.black, fontSize: 16.0)),
                             ],
                           )
                         ],
                       ),
                       new Padding(padding: EdgeInsets.only(top: 50)),
                       new MaterialButton(
                         onPressed: () =>
                             languageSelected(context, _radioValue1, appLanguage),
                         elevation: 8.0,
                         padding: EdgeInsets.all(20),
                         child: Container(
                           height: 50,
                           width: MediaQuery.of(context).size.width,
                           color: Colors.black,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             mainAxisSize: MainAxisSize.max,
                             children: <Widget>[
                               new Padding(
                                   padding: EdgeInsets.only(
                                       left: 5.0,
                                       top: 0.0,
                                       right: 5.0,
                                       bottom: 0.0)),
                               new Text(
                                 AppLocalizations.of(context).translate('continue'),
                                 style:
                                 TextStyle(fontSize: 25.0, color: Colors.white),
                               ),
                               new Padding(
                                   padding: EdgeInsets.only(
                                       left: 5.0,
                                       top: 0.0,
                                       right: 5.0,
                                       bottom: 0.0)),
                               new Icon(
                                 Icons.arrow_forward_ios,
                                 color: Colors.white,
                               )
                             ],
                           ),
                         ),
                       ),
                     ],
                   ),
                 )
                ],
              ),
            )),
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue1 = value;
    });
    print(_radioValue1);
    print("$value _radioValue1");
  }

  languageSelected(
      BuildContext context, int value, AppLanguage appLanguage) {
    print(_radioValue1);
    print("_radioValue1");
    switch (_radioValue1) {
      case -1:
        Toast.show(
            AppLocalizations.of(context).translate('select_language'), context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        break;
      case 0:
        appLanguage.changeLanguage(Locale('ar'));
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => GlobalConstant.getMainScreen()));
        break;
      case 1:
        appLanguage.changeLanguage(Locale('en'));
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => GlobalConstant.getMainScreen()));
        break;
    }
  }
}
