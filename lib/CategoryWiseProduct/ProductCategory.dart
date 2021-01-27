import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import '../CommonMenuClass.dart';

class ProductCategory extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
   return new ProductView();
  }
}

class ProductView extends State<ProductCategory>
{
  List _list;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: _list==null?GlobalWidget.getLoading(context):_list.length != 0 ?
      new GridView.count(
          crossAxisCount: 1,
          childAspectRatio:1.9,
          physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: new List.generate(_list.length, (index)
        {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new CommonDashBord("Cat_Product", true, _list[index])));
            },
            child: new Container(
              height: 200,
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              //color: Colors.blueGrey[300],
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width:20,),
                  Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child:   Container(
                      padding: EdgeInsets.all(30),
                      height: 150,
                      width: 150,
                      child:  ClipRRect(
                        //borderRadius: BorderRadius.circular(40.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'images/logo_header.png',
                          fit: BoxFit.fill,
                          image: _list[index]['image']['src'].toString(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(

                    height: 150,
                    alignment: Alignment.center,
                    child: new Text(
                      GlobalFile.getCaptialize(_list[index]['name'].toString(),),
                      style: TextStyle(color: Colors.black, fontSize:35.0),
                      textAlign: TextAlign.center,
                    ),
                    margin: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
                    padding: EdgeInsets.only(bottom: 5.0, right: 5.0, left: 5.0),

                  )
                ],
              ),
            ),
          );
        }),
      ) : GlobalWidget.getNoRecord(context),
    );
  }


  Future<void> UpdateData() async
  {
    String login = (await Utility.getStringPreference(GlobalConstant.login));
    if(login=="")
      {
        return;
      }
    ApiController apiController = new ApiController.internal();
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(context,GlobalConstant.CommanUrl+"products/categories/",token).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = value;
          var data1 = json.decode(data.body);
          _list=new List();
          for (int i = 0; i < data1.length; i++)
          {
            _list.add(data1[i]);
            Utility.log("TAG", _list[i]["name"]);
          }
          setState(()
          {
          });
        }catch(e)
        {
          //GlobalWidget.showMyDialog(context, "Error", ""+e.toString());
        }
      });
    }else
    {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  @override
  void initState() {
    UpdateData();
  }
}