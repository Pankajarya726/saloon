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
  List _list=new List();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      backgroundColor: Colors.white,
      body: _list.length != 0 ? new GridView.count(
        crossAxisCount: 2,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: new List.generate(_list.length, (index)
        {
          
          return InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new CommonDashBord("Cat_Product", true, _list[index])));
            },

            child: new Container(
              margin: EdgeInsets.all(2.0),
              alignment: Alignment.center,
              color: Colors.blueGrey[300],
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'images/confirm.png',
                        fit: BoxFit.fitWidth,
                        image: _list[index]['image'].toString(),
                      ),
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: new Text(
                      GlobalFile.getCaptialize(_list[index]['name'].toString(),),
                      style:
                      TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                    margin: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
                    padding: EdgeInsets.only(bottom: 5.0, right: 5.0, left: 5.0),
                    // height: MediaQuery.of(context).size.height,
                    /* decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.6),
                          BlendMode.dstATop),
                      image: new NetworkImage(
                          _list[index]['image']),
                      fit: BoxFit.fill)
              ),*/
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
    ApiController apiController = new ApiController.internal();
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(GlobalConstant.CommanUrl+"products/categories/",token).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = value;
          var data1 = json.decode(data.body);
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
          GlobalWidget.showMyDialog(context, "Error", ""+e.toString());
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