import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/SignInSignUpAccount/RegularAccount.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import '../CommonMenuClass.dart';
import 'AccountSelection.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class SignInActivity extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return SignInView();
  }
}

class SignInView extends State<SignInActivity>
{
  var _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userPinController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText1 = true;

  // Toggles the password show status
  void _toggle1()
  {
    setState(()
    {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return new Scaffold(
      body: new Container(
        height: MediaQuery.of(context).size.height,
        child: new Container(
          decoration: GlobalWidget.getbackground(),
          child: new Column(
            children: [
              Expanded(
                flex: 4,
                child: GlobalWidget.getHeader(context),
              ),

              Expanded(
                flex: 6,
                child: Form(
                    key: _formKey,
                    child: ListView(
                        padding: GlobalWidget.getpadding(),
                        children: <Widget>[
                          EmailFeild(),
                          GlobalWidget.sizeBox1(),
                          UserPinFeild(),
                          GlobalWidget.sizeBox1(),
                          GlobalWidget.sizeBox1(),
                          GlobalWidget.sizeBox1(),
                          GlobalWidget.sizeBox1(),
                          GetSubmitButton(),
                          GlobalWidget.sizeBox1(),
                          GlobalWidget.sizeBox1(),
                          GlobalWidget.sizeBox1(),
                          FlatButton(
                              onPressed: () {
                                //  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                                Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new AccountSelection()));
                               },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("account"),
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),

                                      Text(AppLocalizations.of(context).translate("signup"),
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )))
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  UserPinFeild() {

    return TextFormField(
      style: TextStyle(fontSize: 20.0),
      controller: userPinController,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      obscureText: _obscureText1,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        contentPadding: GlobalWidget.getContentPadding(),
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
        if (value.length < 6) {
          return AppLocalizations.of(context).translate("Invalid");
        }
        return null;
      },
    );
  }

  GetSubmitButton() {
    return new Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolorDark(),
        textColor: GlobalWidget.getBtnTextColorDark(),
        onPressed: () {
          // Validate returns true if the form is valid, otherwise false.
          if (_formKey.currentState.validate()) {
            // getShareddata();
            SubmitData();
            //
          }
        },
        child: Text(
          AppLocalizations.of(context).translate("Submit").toUpperCase(),
          style: GlobalWidget.textbtnstyleDark(),
        ),
      ),
    );
  }

  EmailFeild()
  {
    return TextFormField(
      style: TextStyle(fontSize: 22.0, color: Colors.black),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: emailController,
      decoration: GlobalWidget.TextFeildDecoration(
          AppLocalizations.of(context).translate("Email") + "/" +
          AppLocalizations.of(context).translate("UserName"),
          Icons.email),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  String TAG = "VenderAvailabiltyActivity";

  void SubmitData() async {
    Map<String, String> body = {
      'username': emailController.text.toString(),
      'password': userPinController.text.toString(),
    };
    print("body$body");
    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.GetLogin(body).then((value) {
        var data1 = json.decode(value.body);
        print(data1);
        try {
          Dialogs.hideProgressDialog(context);
          String token = data1['token'];
          Utility.setStringPreference(GlobalConstant.token, token);
          String user_email = data1['user_email'];
          Utility.setStringPreference(GlobalConstant.user_email, user_email);
          String store_id = data1['store_id'].toString();
          Utility.setStringPreference(GlobalConstant.store_id, store_id);
          String roles = data1['roles'][0];
          Utility.setStringPreference(GlobalConstant.roles, roles);
          Utility.setStringPreference(GlobalConstant.login, "1");
          // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CommonDashBord("vendor_list", false)),
              ModalRoute.withName('/'));
          //Navigator.of(context).push(new MaterialPageRoute(builder: (_) => CommonDashBord("vendor_list",false)));
          /*  data = data1;
          Utility.log(TAG, data1);
          if (data1.length != 0) {
            setState(() {});
          } else {
            GlobalWidget.showMyDialog(context, "Error", data1.toString());
          }*/
        } catch (e) {
          // GlobalWidget.showMyDialog(context, "", data1['message']);
          GlobalWidget.showMyDialog(context, "",
              AppLocalizations.of(context).translate("incorrect_credential"));
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }
}
