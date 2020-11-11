import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/VendorList/ZoomImageActivity.dart';
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

class DetailView extends State<ProductDetailActivity>
{
  var data;
/*
   List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
     'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
     'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
     'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
     'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80'
   ];
*/

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: data != null ? new Container(
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

  getFulldata()
  {
    List<Widget> imageSliders = _list.map((item) => Container(
      child: InkWell(
        child:Container(
          height: 200.0,
          margin: EdgeInsets.all(1.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child:  Image.network(item, fit: BoxFit.fill, width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,),
          ),
        ) ,
        onTap: ()
        {
          var index = _list.indexOf(item);
          Utility.log(TAG, item.toString());
          Utility.log(TAG, index);
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (_) => new ZoomImageActivity(item.toString())));
        },
      ),
    )).toList();

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

        InkWell(
          onTap: (){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) => new ZoomImageActivity(data['images'][0]['src'].toString())));
          },

          child: Container(
            alignment: Alignment.bottomLeft,
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
        ),

        SizedBox(
          height: 10.0,
        ),


        GetPurches(),
        SizedBox(
          height: 10.0,
        ),
      //  GetBackToShop(),

        new Column(
          children: [
            _list.length>1?Divider(thickness: 15.0,):new Container(),
            _list.length>1?ExpansionTile(
              initiallyExpanded: true,
              tilePadding: EdgeInsets.only(left: 5.0),
              childrenPadding: EdgeInsets.all(0.0),

              children: <Widget>[
                Column(
                    children: [
                      CarouselSlider(
                        items: imageSliders,
                        options: CarouselOptions(
                            autoPlay: true,
                            //height: 250.0,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;

                              });
                            }
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _list.map((url) {
                          int index = _list.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ]
                ),
              ],
            ):new Container(),


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

                Html(
                  data: data['description'],
                  onLinkTap: (url) {
                  },
                ),

                Divider(thickness: 15.0,),
                ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 5.0),
                  childrenPadding: EdgeInsets.all(0.0),
                  title: Text(
                    AppLocalizations.of(context).translate("srt_des"),
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54
                    ),
                  ),

                  children: <Widget>[
                    Html(
                      data: data['short_description'],
                      onLinkTap: (url) {
                      },
                    )
                  ],
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

  List<String> _list=new List();
  void SubmitData() async
  {
    String token = (await Utility.getStringPreference(GlobalConstant.admin_token));
    Utility.setStringPreference(GlobalConstant.Product_ID, widget.data.toString());
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
          for(int i=0;i<data['images'].length;i++)
            {
              _list.add(data['images'][i]['src']);
            }
         // _list=data['images'];
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
          Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new CommonDashBord("vendor_avail",true,data)));
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
