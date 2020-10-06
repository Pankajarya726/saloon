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

class ProductActivity extends StatefulWidget
{
  var data_pro;

  ProductActivity(this.data_pro);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductView();
  }

}

class ProductView extends State<ProductActivity>
{
  List<DataModel> _list=new List();

  @override
  Widget build(BuildContext context) {
   return new Scaffold(

      body:
        new Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child:  new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: getFulldata(),
                ),),
              Expanded(
                flex: 7,
                child:
                _list.length!=0?new GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: new List.generate(_list.length, (index)
                  {
                    return InkWell(
                      onTap:()
                        {
                          Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new CommonDashBord("Product_dtl",true,_list[index].data)));
                        },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: new Text(GlobalFile.getCaptialize(_list[index].data['name']),style: TextStyle(color: Colors.white,fontSize: 14.0),),
                        margin: EdgeInsets.only(top: 5.0,right: 5.0,left: 5.0),
                        padding: EdgeInsets.only(bottom: 5.0,right: 5.0,left: 5.0),
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black,
                            image: DecorationImage(
                                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),

                                image: new NetworkImage(
                                    _list[index].data['images'][0]['src']
                                ),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    );
                  }),
                ):GlobalWidget.getNoRecord(context))
            ],
          ),
        ),
    );

  }


  String TAG="ProductView";

  void SubmitData() async
  {
   /* Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };

    print("body$body");
   */
    String Verder_Id = (await Utility.getStringPreference(GlobalConstant.Verder_Id));

    String Url = GlobalConstant.CommanUrl+"store-vendors/"+Verder_Id+"/products/";


    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.Get(Url).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = value;
          var data1 = json.decode(data.body);
          Utility.log(TAG, data1);
          if (data1.length != 0)
          {
            for(int i=0;i<data1.length;i++)
              {
                _list.add(new DataModel(data1[i]));
              }
            setState(() {

            });
          } else {
            //GlobalWidget.showMyDialog(context, "Error", data1.toString());
          }
        }catch(e)
        {
         // GlobalWidget.showMyDialog(context, "Error", ""+e.toString());
        }
      });

    }else
    {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  @override
  void initState() {
    SubmitData();
  }

  getFulldata() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height:20,
        ),
        Container(
          alignment: Alignment.center,
          child: new Text(
            GlobalFile.getCaptialize(widget.data_pro['vendor_display_name']),
            style: TextStyle(fontSize: 22.0, color: GlobalConstant.getTextColor()),
          ),
        ),

        SizedBox(
          height: 5.0,
        ),
        new InkWell(
          child: new Container(
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          widget.data_pro['vendor_shop_logo'])
                  )
              )),
            onTap: ()
          {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) => new CommonDashBord("vendor_dtl",true)));
          },
        ),
        SizedBox(height: 20.0,),
        Text( AppLocalizations.of(context).translate('barber_essential'),style: TextStyle(fontSize: 20.0),),
      ],
    );
  }
}

class DataModel
{
  var data;

  DataModel(this.data);
}