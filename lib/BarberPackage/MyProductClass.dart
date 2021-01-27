import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:salon_app/DrawerPackage/SideDrawer.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import '../CommonMenuClass.dart';

class MyProductActivity extends StatefulWidget
{
  MyProductActivity();
  @override
  State<StatefulWidget> createState()
  {
    return ProductView();
  }
}

class ProductView extends State<MyProductActivity> {
  List<DataModel> _list ;
  String delete_id = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: new Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: ()
            {
              Navigator.of(context)
                  .push(new MaterialPageRoute(
                  builder: (_) => new CommonDashBord("add_product", true, 0)),)
                  .then((val) {
                if (val != null) {
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (_) =>
                      new CommonDashBord("vendor_list", false)));
                }
              });
            },
            backgroundColor: Colors.black,
            label: Text(AppLocalizations.of(context).translate("add_pro")),
            icon: Icon(Icons.add),
          ),

          body: new Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            color: Colors.white,
            child: _list==null?GlobalWidget.getLoading(context):_list.length != 0 ? new GridView.count(
              crossAxisCount: 2,
              childAspectRatio:0.8,
              shrinkWrap: true,
              children: new List.generate(_list.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(new MaterialPageRoute(
                        builder: (_) => new CommonDashBord("add_product", true,
                            _list[index].data["id"].toString())),)
                        .then((val) {
                      if (val != null) {
                        Navigator.of(context).pushReplacement(new MaterialPageRoute(
                            builder: (_) => new CommonDashBord("vendor_list", false)));
                      }
                    });
                  },

                  child:new Container(
                    margin: EdgeInsets.all(2.0),
                    alignment: Alignment.center,
                    //color: Colors.blueGrey[300],
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SizedBox(height:10,),
                        Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 220,
                            width: 200,
                            padding: EdgeInsets.all(10),
                            child:  new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                SizedBox(height: 5,),
                                FadeInImage.assetNetwork(

                                  height: 100,
                                  width: 100,
                                  placeholder: 'images/logo_header.png',
                                  fit: BoxFit.fill,

                                  image:    _list[index].data['images'][0]['src'],
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  alignment: Alignment.center,
                                  child: new Text(
                                    GlobalFile.getCaptialize(GlobalFile.getCaptialize(
                                        _list[index].data['name']),),
                                    style: TextStyle(color: Colors.black, fontSize: 18.0,),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    delete_id = _list[index].data["id"].toString();
                                    DeleteProduct(context);
                                  },
                                  child: Icon(Icons.delete, color: Colors.black,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ) : GlobalWidget.getNoRecord(context),
          ),
        ),
      );
  }

  void DeleteData() async
  {
    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));
    String token = (await Utility.getStringPreference(GlobalConstant.admin_token));

    Map<String, dynamic> body =
    {
      'post_author': USER_ID
    };

    String Url = GlobalConstant.CommanUrlLogin + "wcfmmp/v1/products/" + delete_id;
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.DeleteWithMyToken(Url, token).then((
          value) {
        var data1 = json.decode(value.body);
         print(data1);
        try {
          Dialogs.hideProgressDialog(context);
          if (value.statusCode == 200) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (_) => new CommonDashBord("vendor_list", false)));
          }
        } catch (e) {
          GlobalWidget.showMyDialog(context, "", data1);
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  Future<bool> _onBackPressed() {

    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(AppLocalizations.of(context).translate("sure")),
        content: new Text(AppLocalizations.of(context).translate("exit_msg")),
        actions: <Widget>[

          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context).translate("NO")),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).translate("YES")),
          ),
        ],
      ),
    ) ?? false;
  }

  Future<bool> DeleteProduct(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(AppLocalizations.of(context).translate("del_title")),
          content: new Text(AppLocalizations.of(context).translate("del_msg")),
          actions: <Widget>[

            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text(AppLocalizations.of(context).translate("NO")),
            ),

            new FlatButton(
              onPressed: ()
              { Navigator.of(context).pop(false);
                DeleteData();
              },
              child: new Text(AppLocalizations.of(context).translate("YES")),
            ),
          ],
        );
      },
    ) ??
        false;
  }

  String TAG = "ProductView";
  String MyProductsID = "";

  void SubmitData() async
  {
    String store_id = (await Utility.getStringPreference(GlobalConstant.store_id));
    String Url = GlobalConstant.CommanUrl + "store-vendors/" + store_id + "/products/";
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.Get(context,Url).then((value) {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = value;
          var data1 = json.decode(data.body);

         // Utility.log(TAG, data1);
          _list=new List();
          if (data1.length != 0) {
            for (int i = 0; i < data1.length; i++)
            {
              Utility.log(TAG, data1[i]["id"].toString());
               MyProductsID+=data1[i]["id"].toString()+",";
              _list.add(new DataModel(data1[i]));

            }
            setState(() {

            });
            Utility.log(TAG, MyProductsID);
            Utility.setStringPreference(GlobalConstant.MyProductsId, MyProductsID);
          } else {
            //GlobalWidget.showMyDialog(context, "Error", data1.toString());
          }
        } catch (e) {
          // GlobalWidget.showMyDialog(context, "Error", ""+e.toString());
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  @override
  void initState() {
    SubmitData();
  }
}

class DataModel
{
  var data;
  DataModel(this.data);
}