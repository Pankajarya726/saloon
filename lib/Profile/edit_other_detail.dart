import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class EditOtherDetail extends StatefulWidget {
  @override
  _EditOtherDetailState createState() => _EditOtherDetailState();
}


class _EditOtherDetailState extends State<EditOtherDetail> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  final GlobalKey<HtmlEditorState> keyEditor1 = GlobalKey();
  var data1;
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
           data1 = json.decode(value.body);
          // data = data1;
          Utility.log(TAG, data1['meta']);
          if (data1.length != 0)
          {
            keyEditor.currentState.setText(data1['meta']['_store_description'][0].toString());
            keyEditor1.currentState.setText(data1['meta']['wcfm_policy_vendor_options'][0].toString());
            descriptionController.text=data1['meta']['_store_description'][0];
            storePolicyController.text=data1['meta']['wcfm_policy_vendor_options'][0];
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
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    getExistData();
    super.initState();
  }
  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }


  var _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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

                  new Container(
                    height: 300,
                    child:  HtmlEditor(
                      hint: AppLocalizations.of(context).translate("Description"),
                      value:  "${data1 == null ? "" :data1['meta']['_store_description'] == null ? "" : data1['meta']['_store_description'][0]}",
                      key: keyEditor,
                      showBottomToolbar: false,
                      height: 300,
                    ),
                  ),
                  GlobalWidget.sizeBox1(),
                  GlobalWidget.sizeBox1(),
                  GlobalWidget.sizeBox1(),
                  new Container(
                    height: 300,
                    child:  HtmlEditor(
                      hint: AppLocalizations.of(context).translate("store_poliecies"),
                      value:  "${data1 == null ? "" :data1['meta']['wcfm_policy_vendor_options'] == null ? "" : data1['meta']['wcfm_policy_vendor_options'][0]}",
                      key: keyEditor1,
                      showBottomToolbar: false,
                      height: 300,
                    ),
                  ),

                  //firstNameFeild(),

                 // lastNameFeild(),
                  GlobalWidget.sizeBox1(),
                  GetSubmitButton(),
                ])),
      ),

    );
  }


  String TAG="OTHERINFO";
  void SubmitData() async
  {
    String store_id = (await Utility.getStringPreference(GlobalConstant.store_id));
    String token = (await Utility.getStringPreference(GlobalConstant.token));

    String Url = GlobalConstant.CommanUrlLogin + "wp/v2/users/"+store_id;
    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));
    await keyEditor.currentState.getText();
    await keyEditor1.currentState.getText();
    final description_text_data = await keyEditor.currentState.getText();
    final  policy_text_data = await keyEditor1.currentState.getText();


    Map<String, dynamic> mapBilling() =>
        {
          "_store_description" : description_text_data,
          "wcfm_policy_vendor_options" : policy_text_data
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


  GetSubmitButton()
  {
    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: () {

          SubmitData();
        },
        child: Text(AppLocalizations.of(context).translate("Submit"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }

  final countryController = TextEditingController();

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


  final stateController = TextEditingController();

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


  final cityController = TextEditingController();

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


  final zipcodeController = TextEditingController();

  zipcodeFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
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

  final phoneController = TextEditingController();
  phoneFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: phoneController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("phone")),
      validator: (value) {
        if (value.isEmpty) {return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }


  final emailController = TextEditingController();

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


  final descriptionController = TextEditingController();

  firstNameFeild() {

    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: descriptionController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("Description")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }


  final storePolicyController = TextEditingController();

  lastNameFeild() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: storePolicyController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("store_poliecies")),
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

}
