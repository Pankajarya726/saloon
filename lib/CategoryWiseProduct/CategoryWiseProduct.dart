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

class CategoryWiseProductActivity extends StatefulWidget
{
  String id;

  CategoryWiseProductActivity(this.id);

  @override
  State<StatefulWidget> createState()
  {
    return ProductView();
  }
}

class ProductView extends State<CategoryWiseProductActivity> {
  List<DataModel> _list = new List();
  String delete_id = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: new Scaffold(

          body: new Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            color: Colors.white,
            child: _list.length != 0 ? new GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: new List.generate(_list.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (_) => new CommonDashBord("Product_dtl", true, _list[index].data["id"].toString())));
                  },

                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: new Row(
                      children: [
                        new Text(GlobalFile.getCaptialize(
                            _list[index].data['name']), style: TextStyle(
                            color: Colors.white, fontSize: 14.0),)
                      ],
                    ),
                    margin: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
                    padding: EdgeInsets.only(bottom: 5.0, right: 5.0, left: 5.0),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(Colors.black
                                .withOpacity(0.6), BlendMode.dstATop),
                            image: new NetworkImage(
                                _list[index].data['images'][0]['src']
                            ),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                );
              }),
            ) : GlobalWidget.getNoRecord(context),
          ),

        ),
      );
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


  String TAG = "ProductView";

  void SubmitData() async
  {
    /*
    Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };
    print("body$body");
   */
    String store_id = (await Utility.getStringPreference(GlobalConstant.store_id));
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrl + "products?category="+widget.id.toString()+"&status=publish";
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(Url,token).then((value) {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = value;
          var data1 = json.decode(data.body);
          Utility.log(TAG, data1);
          if (data1.length != 0) {
            for (int i = 0; i < data1.length; i++) {
              _list.add(new DataModel(data1[i]));
            }
            setState(() {

            });
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