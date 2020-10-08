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

import '../CommonMenuClass.dart';

class ProductDetailActivity extends StatefulWidget {
  var data;

  ProductDetailActivity(this.data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailView();
  }
}

class DetailView extends State<ProductDetailActivity> {
  var data;

  @override
  Widget build(BuildContext context) {
   // TODO: implement build
    return new Scaffold(
      body: data != null
          ? new Container(
              color: Colors.grey.shade200,
              height: MediaQuery.of(context).size.height,
              child: getFulldata(),
            )
          : GlobalWidget.getNoRecord(context),
    );
  }

  String TAG = "VendorDetail";



  @override
  void initState() {
    SubmitData();
  }

  getFulldata() {
    return new ListView(
      padding: EdgeInsets.all(10.0),
      shrinkWrap: true,
      children: [
        SizedBox(
          height:20,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: new Text(
            GlobalFile.getCaptialize(data['name']),
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),

       /* Container(
          alignment: Alignment.center,
          child: new Text(
            GlobalFile.getCaptialize(data['slug']),
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        SizedBox(height: 5.0,),*/

        Container(
          alignment: Alignment.center,
          child: new Center(
            child: SingleChildScrollView(
              child: Html(
                data: data['price_html'],

                onLinkTap: (url) {
                  print("Opening $url...");
                },

              ),
            ),
          ),
        ),


        SizedBox(height: 5.0,),
       /* Container(
          width: MediaQuery.of(context).size.width,
          height: 260.0,
          alignment: Alignment.center,
          child: FadeInImage(
              image: NetworkImage(data['images'][0]['src']),
              fit: BoxFit.fitWidth,
              placeholder: GlobalWidget.getPlaceHolder()),
        ),
       */
        Container(
          alignment: Alignment.bottomLeft,
          child: new Text(GlobalFile.getCaptialize(data['name']),style: TextStyle(color: Colors.white,fontSize: 14.0),),

          padding: EdgeInsets.only(bottom: 5.0,right: 5.0,left: 5.0),
          height: MediaQuery.of(context).size.height/3,
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.99), BlendMode.dstIn),

                  image: new NetworkImage(
                      data['images'][0]['src']
                  ),
                  fit: BoxFit.fill
              )
          ),
        ),
        SizedBox(
          height: 10.0,
        ),


       /* new Center(
          child: SingleChildScrollView(
            child: Html(
              data: data['description'],

              onLinkTap: (url) {
                print("Opening $url...");
              },

            ),
          ),
        ),


        SizedBox(
          height: 10.0,
        ),
*/


        GetPurches(),
        SizedBox(
          height: 10.0,
        ),
      //  GetBackToShop(),

        new Column(
          children: [

            Divider(thickness: 15.0,),
            ExpansionTile(
              tilePadding: EdgeInsets.only(left: 5.0),
              childrenPadding: EdgeInsets.all(0.0),
              title: Text(
                AppLocalizations.of(context).translate("Description"),
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),
              children: <Widget>[
                new Center(
                  child: SingleChildScrollView(
                    child: new Column(
                      children: [
                        Html(
                          data: data['description'],

                          onLinkTap: (url) {
                          },

                        ),
                        Html(
                          data: data['short_description'],

                          onLinkTap: (url) {
                          },

                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 15.0,),
            ExpansionTile(
              tilePadding: EdgeInsets.only(left: 5.0),
              childrenPadding: EdgeInsets.all(0.0),
              title: Text(
               AppLocalizations.of(context).translate("review"),
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),

              children: <Widget>[
                new Center(
                  child: SingleChildScrollView(
                    child: Html(
                      data: "",

                      onLinkTap: (url) {
                      },

                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 15.0,),
            ExpansionTile(
              tilePadding: EdgeInsets.only(left: 5.0),
              childrenPadding: EdgeInsets.all(0.0),
              title: Text(
                AppLocalizations.of(context).translate("more_offers"),
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),

              children: <Widget>[
                new Center(
                  child: SingleChildScrollView(
                    child: Html(
                      data:"",

                      onLinkTap: (url) {
                      },

                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 15.0,),
ExpansionTile(
              tilePadding: EdgeInsets.only(left: 5.0),
              childrenPadding: EdgeInsets.all(0.0),
              title: Text(
                AppLocalizations.of(context).translate("store_poliecies"),
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),

              children: <Widget>[


                ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 5.0),
                  childrenPadding: EdgeInsets.all(0.0),
                  title: Text(
                    data['wcfm_product_policy_data']['shipping_policy_heading'],
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54
                    ),
                  ),
                  children: <Widget>[
                    new Center(
                      child: SingleChildScrollView(
                        child: Html(
                          data: data['wcfm_product_policy_data']['shipping_policy'],

                          onLinkTap: (url) {
                          },

                        ),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 15.0,),
                ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 5.0),
                  childrenPadding: EdgeInsets.all(0.0),
                  title: Text(
                    data['wcfm_product_policy_data']['refund_policy_heading'],
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54
                    ),
                  ),

                  children: <Widget>[
                    new Center(
                      child: SingleChildScrollView(
                        child: Html(
                          data: data['wcfm_product_policy_data']['refund_policy'],

                          onLinkTap: (url) {
                          },

                        ),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 15.0,),
                ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 5.0),
                  childrenPadding: EdgeInsets.all(0.0),
                  title: Text(
                    data['wcfm_product_policy_data']['cancellation_policy_heading'],
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54
                    ),
                  ),

                  children: <Widget>[
                    new Center(
                      child: SingleChildScrollView(
                        child: Html(
                          data: data['wcfm_product_policy_data']['cancellation_policy'],

                          onLinkTap: (url) {
                          },

                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(thickness: 15.0,),

          ],
        ),
      ],
    );
  }


  void SubmitData() async
  {
    String token = (await Utility.getStringPreference(GlobalConstant.admin_token));

    String Url = GlobalConstant.CommanUrl+"products/"+widget.data.toString();


    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(Url,token).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          data = json.decode(value.body);
          setState(() {
          });
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

  GetPurches() {
    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: ()
        {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (_) => new CommonDashBord("vendor_avail",true,data)));
        },
        child: Text(AppLocalizations.of(context).translate("purches"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }
  GetBackToShop() {

    return new Container(
      height: 50.0,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(AppLocalizations.of(context).translate("back_shop"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }
}
