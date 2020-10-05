import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class RegularAccount extends StatefulWidget
{
  String from;

  RegularAccount(this.from);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return AccView();
  }
  
}

class AccView extends State<RegularAccount>
{
  final userIdController = TextEditingController();
  final userPinController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final shopController = TextEditingController();
  final varificationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText1 = true;
  // Toggles the password show status
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  void initState() {
    super.initState();
    getandSetData();
  }


  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    return new Scaffold(
      appBar: GlobalWidget.getAppBar( widget.from=="barber"?AppLocalizations.of(context).translate('barber_account'):AppLocalizations.of(context).translate('regular_account'),context,true),
      body: new Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Form(
            key: _formKey,
            child: ListView(
                shrinkWrap: true,
                padding: GlobalWidget.getpadding(),
                children: <Widget>[

                  NameFeild(),
                  GlobalWidget.sizeBox1(),
                  EmailFeild(),
                  GlobalWidget.sizeBox1(),
                  widget.from=="barber"?new Column(
                    children: [
                      BarberShopFeild(),
                      GlobalWidget.sizeBox1(),
                    ],
                  ):new Container(),
                  UserIdFeild(),
                  GlobalWidget.sizeBox1(),
                  UserPinFeild(),
                  GlobalWidget.sizeBox1(),
                  new Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: PhoneFeild(),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 4,
                        child: GetOTPButton(),
                      ),
                    ],
                  ),

                  GlobalWidget.sizeBox1(),
                  new Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: VerificationFeild(),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 4,
                        child: Text(AppLocalizations.of(context).translate("PressSend"),style: TextStyle(color: Colors.grey),),
                      ),
                    ],
                  ),


                  GlobalWidget.sizeBox1(),
                  GlobalWidget.sizeBox1(),
                  GetSubmitButton(),

                  GlobalWidget.sizeBox1(),
                  Container(
                    alignment: Alignment.center,
                    child: new Column(
                      children: [
                        Text(AppLocalizations.of(context).translate("tandc"),style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
                        Text(AppLocalizations.of(context).translate("tandct"),style: TextStyle(color: Colors.black,decoration: TextDecoration.underline,),textAlign: TextAlign.center,),
                      ],
                    )
                  ),
                ])),
      ),

    );
  }


  UserIdFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: userIdController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("UserName")),
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


  VerificationFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: varificationController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("Verification")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
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


  EmailFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
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



  BarberShopFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: shopController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("shop")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }


  PhoneFeild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: phoneController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("Phone")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        if (value.length<10)
        {
          return AppLocalizations.of(context).translate("Invalid");
        }
        return null;
      },
    );
  }

  UserPinFeild() {
    return TextFormField(
      controller: userPinController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      keyboardType: TextInputType.number,

      obscureText: _obscureText1,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        contentPadding:GlobalWidget.getContentPadding(),
        hintText: AppLocalizations.of(context).translate("Password"),
        suffixIcon: IconButton(
          onPressed: () => _toggle1(),
          icon: GlobalWidget.getIcon(_obscureText1),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        if (value.length<6) {
          return AppLocalizations.of(context).translate("Invalid");
        }
        return null;
      },
    );
  }

  GetSubmitButton() {

    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: () {
          // Validate returns true if the form is valid, otherwise false.
         /* if (_formKey.currentState.validate()) {
            // getShareddata();
            print("success");
          }*/
          SendData();
        },
        child: Text(AppLocalizations.of(context).translate("Submit"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }
  GetOTPButton() {

    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: () {
          // Validate returns true if the form is valid, otherwise false.
          if (phoneController.text.toString().length<10) {
            // getShareddata();
            GlobalWidget.GetToast(context, AppLocalizations.of(context).translate("Valid_phone"));
          }else{

          }
        },
        child: Text(AppLocalizations.of(context).translate("Send"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }

  Future<void> getandSetData() async {

    String User_Name = await Utility.getStringPreference(GlobalConstant.User_Name);
    String User_Email = await Utility.getStringPreference(GlobalConstant.User_Email);
    emailController.text=User_Email;
    nameController.text=User_Name;
    setState(() {

    });
  }
  Future<void> SendData() async {

    List a1=new List();

    a1.add('wcfm_vendor');

    Map<String, dynamic> map_submit() => {
      'username': userIdController.text.toString(),
      'email':emailController.text.toString(),
      'roles': a1,
      'password': userPinController.text.toString(),
    };
    print(json.encode(map_submit()));
  }
  
}