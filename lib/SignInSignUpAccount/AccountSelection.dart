import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/SignInSignUpAccount/RegularAccount.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class AccountSelection extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return AccountView();
  }

}

class AccountView extends State<AccountSelection>
{
  var _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return new Scaffold(
     body:new Container(
       height: MediaQuery.of(context).size.height,
       child: new Container(
         decoration:GlobalWidget.getbackground(),
         // color: Colors.white,

         child: new Column(
           children: [
             Expanded(
               flex: 4,
               child: GlobalWidget.getHeader(context),
             ),
             Expanded(
               flex: 6,
               child:  Form(
                   key: _formKey,
                   child:  ListView(
                       padding: GlobalWidget.getpadding(),
                       children: <Widget>[

                         NameFeild(),
                         GlobalWidget.sizeBox1(),
                         EmailFeild(),
                         GlobalWidget.sizeBox1(),
                         GlobalWidget.sizeBox1(),
                         GetBarberButton(),
                         GlobalWidget.sizeBox1(),
                         GetRegularButton(),
                         GlobalWidget.sizeBox1(),
                         GlobalWidget.sizeBox1(),
                         GlobalWidget.sizeBox1(),
                         FlatButton(
                           onPressed: ()
                           {
                           },
                           child:
                           Container(
                               alignment: Alignment.center,
                               child: new Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(AppLocalizations.of(context).translate("account"),style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
                                   Text(AppLocalizations.of(context).translate("signup"),style: TextStyle(color: Colors.black ,decoration: TextDecoration.underline,),textAlign: TextAlign.center,),
                                 ],
                               )
                           ),
                         ),


                       ])),
             )
           ],
         ),
       ),
     ),
   );
  }


  NameFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: nameController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("Name")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        if (value.length<5)
        {
          return AppLocalizations.of(context).translate("Invalid");
        }
        return null;
      },
    );
  }

  GetBarberButton() {
    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // getShareddata();
            print("success");
            setSeeionValue("barber");
          }
        },
        child: Text(AppLocalizations.of(context).translate("barber_account"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }
  GetRegularButton() {

    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // getShareddata();
            print("success");

            setSeeionValue("user");
          }
        },
        child: Text(AppLocalizations.of(context).translate("regular_account"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }
  EmailFeild() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: emailController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("Email")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        if (!GlobalFile.isEmail(value))
        {
          return AppLocalizations.of(context).translate("Invalid");
        }
        return null;
      },
    );
  }

  void setSeeionValue(String s) {
    Utility.setStringPreference(GlobalConstant.User_Name, nameController.text.toString());
    Utility.setStringPreference(GlobalConstant.User_Email, emailController.text.toString());
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (_) => new RegularAccount(s)));
  }
}