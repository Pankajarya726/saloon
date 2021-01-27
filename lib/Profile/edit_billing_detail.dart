import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salon_app/Availabilty/ConfirmationClass.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/language/AppLocalizations.dart';
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

class EditBillingDetail extends StatefulWidget {
  @override
  _EditBillingDetailState createState() => _EditBillingDetailState();
}

class _EditBillingDetailState extends State<EditBillingDetail> with SingleTickerProviderStateMixin
{
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    getExistData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final zipcodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  var _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {

    return new Scaffold(
      body: new Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Form(
            key: _formKey,
            child: ListView(

                shrinkWrap: true,
                padding: GlobalWidget.getpadding(),
                children: <Widget>[
                  firstNameFeild(),
                  GlobalWidget.sizeBox1(),
                  lastNameFeild(),
                  GlobalWidget.sizeBox1(),
                  emailFeild(),
                  GlobalWidget.sizeBox1(),
                  phoneFeild(),
                  GlobalWidget.sizeBox1(),
                  countryFeild(),
                  GlobalWidget.sizeBox1(),
                  stateFeild(),
                  GlobalWidget.sizeBox1(),
                  cityFeild(),
                  GlobalWidget.sizeBox1(),
                  zipcodeFeild(),
                  GlobalWidget.sizeBox1(),
                  addressFeild(),
                  GlobalWidget.sizeBox1(),
                  GetSubmitButton(),
                ])),
      ),
    );
  }


  GetSubmitButton()
  {
    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: () {

          // Validate returns true if the form is valid, otherwise false.
           /*if (_formKey.currentState.validate())
           {

             Map<String, dynamic> mapBilling() =>
            {
              "first_name" : firstNameController.text.toString(),
              "last_name" : lastNameController.text.toString(),
              "company" : "ABC",
              "address_1" : addressController.text.toString(),
              "address_2" : addressController.text.toString(),
              "city" : cityController.text.toString(),
              "state" : stateController.text.toString(),
              "postcode" : zipcodeController.text.toString(),
              "email" : emailController.text.toString(),
              "phone" : phoneController.text.toString()
            };
             SubmitData(mapBilling());
          }*/
          Map<String, dynamic> mapBilling() =>
              {
                "first_name" : firstNameController.text.toString(),
                "last_name" : lastNameController.text.toString(),
                "company" : "ABC",
                "address_1" : addressController.text.toString(),
                "address_2" : addressController.text.toString(),
                "city" : cityController.text.toString(),
                "state" : stateController.text.toString(),
                "postcode" : zipcodeController.text.toString(),
                "email" : emailController.text.toString(),
                "phone" : phoneController.text.toString()
              };
          SubmitData(mapBilling());
        },
        child: Text(AppLocalizations.of(context).translate("Submit"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }


  countryFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: countryController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("country")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }


  stateFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: stateController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("state")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }


  cityFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: cityController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("city")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  zipcodeFeild()
  {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: zipcodeController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("zipcode")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  final addressController = TextEditingController();

  addressFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: addressController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("address")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  phoneFeild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: phoneController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("phone")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  emailFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: emailController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("email")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  firstNameFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: firstNameController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("firstName")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  lastNameFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: lastNameController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("lastName")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }
  String TAG = "VendorDetail";
  void SubmitData(var mapBilling) async
  {
    String store_id = (await Utility.getStringPreference(GlobalConstant.store_id));
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrlLogin + "wp/v2/users/"+store_id;
    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));

    Map<String, dynamic> mapBilling() =>
    {
      "first_name" : firstNameController.text.toString(),
      "last_name" : lastNameController.text.toString(),
      "company" : "ABC",
      "address_1" : addressController.text.toString(),
      "address_2" : addressController.text.toString(),
      "city" : cityController.text.toString(),
      "state" : stateController.text.toString(),
      "postcode" : zipcodeController.text.toString(),
      "email" : emailController.text.toString(),
      "country" : countryController.text.toString(),
      "phone" : phoneController.text.toString()
    };

    Map<String, dynamic> body() =>
    {
      'id': "${USER_ID}",
      'meta': mapBilling(),
    };
    print("body$body");
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.PostsNewWithToken(context,Url,json.encode(body()),token).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data1 = json.decode(value.body);
          Utility.log(TAG, data1);
          if (data1.length != 0) {

            Navigator.pop(context, mapBilling());
            setState(() {});
          } else
          {
            GlobalWidget.showMyDialog(context, "Error", data1.toString());
          }
        }catch (e)
        {
          GlobalWidget.showMyDialog(context, "Error", "" + e.toString());
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }
  void getExistData() async
  {
    String store_id = (await Utility.getStringPreference(GlobalConstant.store_id));
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrlLogin + "wp/v2/users/"+store_id;
    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(context,Url,token).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data1 = json.decode(value.body);
          // data = data1;
          Utility.log(TAG, data1['meta']);
          if (data1.length != 0)
          {
            firstNameController.text=data1['meta']['first_name'][0];
            lastNameController.text=data1['meta']['last_name'][0];
            addressController.text=data1['meta']['address_1'][0];
            cityController.text=data1['meta']['city'][0];
            stateController.text=data1['meta']['state'][0];
            zipcodeController.text=data1['meta']['postcode'][0];
            emailController.text=data1['meta']['email'][0];
            phoneController.text=data1['meta']['phone'][0];
            countryController.text=data1['meta']['country'][0];
            setState(()
            {

            });
          } else {
          }
        } catch (e)
        {

        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }
}
