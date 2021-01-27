import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import '../CommonMenuClass.dart';
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
import 'package:salon_app/Profile/edit_billing_detail.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> with SingleTickerProviderStateMixin
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: profile!=null?new Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: new ListView(
          children: [
            new Column(
              children: [

                Divider(thickness: 15.0,),
                Center(
                  child: SingleChildScrollView(
                    child: getData(),
                  ),
                ),
                Divider(thickness: 15.0,),
                getBillview(),
                Divider(thickness: 15.0,),
                getStoreview(),
                Divider(thickness: 15.0,),
                getPolicyview(),
                Divider(thickness: 15.0,),
              ],
            ),
          ],
        ),
      ):GlobalWidget.getLoading(context),
    );
  }

  getBillview() {
    return  ExpansionTile(

      tilePadding: EdgeInsets.only(left: 5.0),
      leading: new InkWell(
        onTap: (){

          /*Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CommonDashBord("edit_bill", true)));

*/
          openEditProfile();

          },

        child: Icon(Icons.edit),),
        childrenPadding: EdgeInsets.all(0.0),
        title: Text(
          AppLocalizations.of(context).translate("bill_add"),
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.black54
        ),
      ),

      children: <Widget>[
        getRow("firstName",profile['meta']['first_name'][0]),
        getRow("lastName",profile['meta']['last_name'][0]),
        profile['meta']['email']==null?new Container():getRow("email",profile['meta']['email'][0]),
        profile['meta']['phone']==null?new Container():getRow("phone",profile['meta']['phone'][0]),
        profile['meta']['country']==null?new Container():getRow("country",profile['meta']['country'][0]),
        profile['meta']['state']==null?new Container():getRow("state",profile['meta']['state'][0]),
        profile['meta']['city']==null?new Container():getRow("city",profile['meta']['city'][0]),
        profile['meta']['zipcode']==null?new Container():getRow("zipcode",profile['meta']['postcode'][0]),
        profile['meta']['address']==null?new Container():getRow("address",profile['meta']['address_1'][0]),
      ],
    );
  }

  getStoreview() {
    return  ExpansionTile(

      tilePadding: EdgeInsets.only(left: 5.0),
      leading: new InkWell(
        onTap: ()
        {
          openOtherProfile();
        },

        child: Icon(Icons.edit),),
        childrenPadding: EdgeInsets.all(0.0),
        title: Text(
          AppLocalizations.of(context).translate("Description"),
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.black54
        ),
      ),

      children: <Widget>[
        profile['meta']['_store_description']!=null?new Container(
          padding: EdgeInsets.all(10.0),
          child:  Html(
          data: profile['meta']['_store_description'][0],

    onLinkTap: (url) {
    print("Opening $url...");
    },
        )):new Container(),
      ],
    );
  }

  getPolicyview() {
    return  ExpansionTile(

      tilePadding: EdgeInsets.only(left: 5.0),
      leading: new InkWell(
        onTap: ()
        {
          openOtherProfile();
        },

        child: Icon(Icons.edit),),
        childrenPadding: EdgeInsets.all(0.0),
        title: Text(
          AppLocalizations.of(context).translate("store_poliecies"),
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.black54
        ),
      ),

      children: <Widget>[
        profile['meta']['wcfm_policy_vendor_options']!=null?new Container(
          padding: EdgeInsets.all(10.0),
          child:  Html(
          data: profile['meta']['wcfm_policy_vendor_options'][0],

    onLinkTap: (url) {
    print("Opening $url...");
    },
        )):new Container(),
      ],
    );
  }

  String TAG="ViewProfileData";
  var profile;
  void getExistData() async {

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
            profile=data1;
            setState(() {

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

  getRow(String s, String t) {
    return new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.0),
      child: new Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Row(
            children: [
              Expanded(
                child: Text(AppLocalizations.of(context).translate(s),style: TextStyle(fontSize: 16.0,color: Colors.black),),
              ),
              Expanded(
                child: Text(t,style: TextStyle(fontSize: 14.0,color: Colors.black54),textAlign:TextAlign.right,),
              ),
            ],
          )  ,
          Divider(thickness: 1.0,)
        ],
      ),
    );
  }

  getData() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height:20,
        ),
        Container(
          alignment: Alignment.center,
          child: new Text(
            GlobalFile.getCaptialize(profile['name']),
            style: TextStyle(fontSize: 22.0, color: Colors.black),
          ),
        ),

        SizedBox(
          height: 20.0,
        ),

        profile['avatar_urls']!=null?CircleAvatar(
          radius: 55,
          backgroundColor: Color(0xffFDCF09),
          child: CircleAvatar(
            radius: 55,
            backgroundImage:  NetworkImage(profile['avatar_urls']['48']),
          ),
        ):new Container(),

        SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.center,
          child: new Text(
          profile['meta']['email']==null?"": GlobalFile.getCaptialize(profile['meta']['email'][0]),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),

/*
    Container(
          alignment: Alignment.center,
          child: new Text(data['vendor_phone'].toString(),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
        SizedBox(height: 5.0,),
*/

        Container(
          alignment: Alignment.center,
          child: new Text(
    profile['meta']['phone']==null?"":GlobalFile.getCaptialize(profile['meta']['phone'][0]),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),

        SizedBox(
          height:20.0,
        ),

        SizedBox(
          height:20.0,
        ),

      ],
    );
  }

  void openEditProfile() {

    Navigator.of(context).push(new MaterialPageRoute(builder: (_)=> new  CommonDashBord("edit_bill", true)),).then((val)
    {
      FocusScope.of(context).requestFocus(new FocusNode());
      if(val!=null)
      {
        getExistData();
      }
    });
  }
  void openOtherProfile() {

    Navigator.of(context).push(new MaterialPageRoute(builder: (_)=> new  CommonDashBord("edit_oth", true)),).then((val)
    {
      FocusScope.of(context).requestFocus(new FocusNode());
      if(val!=null)
      {
        getExistData();
      }
    });
  }
}
