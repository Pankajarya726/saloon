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
class VendoeDetailActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState()
  {
    return DetailView();
  }
}

class DetailView extends State<VendoeDetailActivity> {
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

  void SubmitData() async {
    /*
     Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };
    print("body$body");
   */

    String Verder_Id = (await Utility.getStringPreference(GlobalConstant.Verder_Id));
    String Url = GlobalConstant.CommanUrl + "store-vendors/"+Verder_Id;

    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.Get(Url).then((value) {
        try {
          Dialogs.hideProgressDialog(context);
          var data1 = json.decode(value.body);
          data = data1;
          Utility.log(TAG, data1);
          if (data1.length != 0) {
            setState(() {});
          } else {
            GlobalWidget.showMyDialog(context, "Error", data1.toString());
          }
        } catch (e) {
          GlobalWidget.showMyDialog(context, "Error", "" + e.toString());
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

  getFulldata() {
    return new ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(10.0),
      children: [
        SizedBox(
          height:20,
        ),
        Container(
          alignment: Alignment.center,
          child: new Text(
            GlobalFile.getCaptialize(data['vendor_display_name']),
            style: TextStyle(fontSize: 22.0, color: Colors.black),
          ),
        ),

        SizedBox(
          height: 20.0,
        ),

        data['vendor_shop_logo']!=null?CircleAvatar(
          radius: 55,
          backgroundColor: Color(0xffFDCF09),
          child: CircleAvatar(
            radius: 55,
            backgroundImage:  NetworkImage(data['vendor_shop_logo']),
          ),
        ):new Container(),

        SizedBox(
          height: 20.0,
        ),

        Container(
          alignment: Alignment.center,
          child: new Text(
            GlobalFile.getCaptialize(data['vendor_email']),
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
            GlobalFile.getCaptialize(data['vendor_shop_name']),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),

        SizedBox(
          height:20.0,
        ),

        Container(
          alignment: Alignment.center,
          child: new Text(
            "10:00 AM to 8:00 PM ",
            style: TextStyle(fontSize: 16.0, color: Colors.blue),
          ),
        ),

        Container(
          alignment: Alignment.center,
          child: new Text(GlobalFile.getCaptialize(data['vendor_address'])),
        ),

        SizedBox(
          height:20.0,
        ),

       new Container(
         height: 100.0,
         child:  new Row(
           children: [
             Expanded(
               child:new InkWell(
                 onTap: (){
                   createNewMessage(data['vendor_banner']);
                 },
                 child:  data['vendor_banner']!=null?Container(
                   alignment: Alignment.bottomLeft,
                   height: 200,
                   decoration: BoxDecoration(

                       borderRadius: BorderRadius.circular(5),
                       color: Colors.black,
                       image: DecorationImage(
                           colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),

                           image: new NetworkImage(
                               data['vendor_banner']
                           ),
                           fit: BoxFit.fill
                       )
                   ),
                 ):new Container(),
               ),
               /* FadeInImage(
                   image: NetworkImage(data['vendor_banner']),
                   fit: BoxFit.fill,
                   placeholder: GlobalWidget.getPlaceHolder()),*/
             ),
             SizedBox(
               width: 10.0,
             ),
             Expanded(
               child: InkWell(
                 onTap: ()
                 {
                   createNewMessage( data['mobile_banner']);
                 },
                 child: data['mobile_banner']!=null?Container(
                   alignment: Alignment.bottomLeft,
                   height: 200,
                   decoration: BoxDecoration(

                       borderRadius: BorderRadius.circular(5),
                       color: Colors.black,
                       image: DecorationImage(
                           colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),

                           image: new NetworkImage(
                               data['mobile_banner']
                           ),
                           fit: BoxFit.fill
                       )
                   ),
                 ):new Container(),
               )



             ),
             SizedBox(
               width: 10.0,
             ),

             Expanded(
               child: new InkWell(
                 onTap: ()
                 {
                   createNewMessage(data['vendor_list_banner']);
                 },
                 child: data['vendor_list_banner']!=null?Container(
                   alignment: Alignment.bottomLeft,
                   height: 200,
                   decoration: BoxDecoration(

                       borderRadius: BorderRadius.circular(5),
                       color: Colors.black,
                       image: DecorationImage(
                           colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),

                           image: new NetworkImage(
                               data['vendor_list_banner']
                           ),
                           fit: BoxFit.fill
                       )
                   ),
                 ):new Container(),
               )
),
           ],
         ),
       ),

        new Column(
          children: [

            new Center(
              child: SingleChildScrollView(
                child: Html(
                  data: data['store_tab_headings']['reviews'],

                  onLinkTap: (url) {
                    print("Opening $url...");
                  },

                ),
              ),
            ),
            new Center(
              child: SingleChildScrollView(
                child: Html(
                  data: data['store_tab_headings']['followers'],

                  onLinkTap: (url) {
                    print("Opening $url...");
                  },
                ),
              ),
            ),
          ],
        ),

   /*     GlobalFile.getStringValue(data['store_tab_headings'])!=""?  new Column(
          children: [

            new Center(
              child: SingleChildScrollView(
                child: Html(
                  data: data['store_tab_headings']['reviews'],

                  onLinkTap: (url) {
                    print("Opening $url...");
                  },

                ),
              ),
            ),
            new Center(
              child: SingleChildScrollView(
                child: Html(
                  data: data['store_tab_headings']['followers'],

                  onLinkTap: (url) {
                    print("Opening $url...");
                  },

                ),
              ),
            ),
          ],
        ):new Container(),
*/

        new Column(
          children: [
            Divider(thickness: 15.0,),
            ExpansionTile(
              tilePadding: EdgeInsets.only(left: 5.0),
              childrenPadding: EdgeInsets.all(0.0),
              title: Text(
                data['vendor_policies']['shipping_policy_heading'],
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),
              children: <Widget>[
                new Center(
                  child: SingleChildScrollView(
                    child: Html(
                      data: data['vendor_policies']['shipping_policy'],

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
                data['vendor_policies']['refund_policy_heading'],
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),

              children: <Widget>[
                new Center(
                  child: SingleChildScrollView(
                    child: Html(
                      data: data['vendor_policies']['refund_policy'],

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
                data['vendor_policies']['cancellation_policy_heading'],
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),

              children: <Widget>[
                new Center(
                  child: SingleChildScrollView(
                    child: Html(
                      data: data['vendor_policies']['cancellation_policy'],

                      onLinkTap: (url) {
                      },

                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 15.0,),

          ],
        ),
      /* GlobalFile.getStringValue(data['vendor_policies'])!=""? new Column(
          children: [

            Divider(thickness: 15.0,),
            ExpansionTile(
              tilePadding: EdgeInsets.only(left: 5.0),
              childrenPadding: EdgeInsets.all(0.0),
              title: Text(
                data['vendor_policies']['shipping_policy_heading'],
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),
              children: <Widget>[
                new Center(
                  child: SingleChildScrollView(
                    child: Html(
                      data: data['vendor_policies']['shipping_policy'],

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
                data['vendor_policies']['refund_policy_heading'],
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),

              children: <Widget>[
                new Center(
                  child: SingleChildScrollView(
                    child: Html(
                      data: data['vendor_policies']['refund_policy'],

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
                data['vendor_policies']['cancellation_policy_heading'],
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54
                ),
              ),

              children: <Widget>[
                new Center(
                  child: SingleChildScrollView(
                    child: Html(
                      data: data['vendor_policies']['cancellation_policy'],

                      onLinkTap: (url) {
                      },

                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 15.0,),

          ],
        ):new Container(),
      */  SizedBox(height: 20.0,),

       GlobalFile.getStringValue(data['vendor_description'])!=""? new Center(
          child: SingleChildScrollView(
            child: Html(
              data: data['vendor_description'],

              onLinkTap: (url) {
                print("Opening $url...");
              },

            ),
          ),
        ):new Container(),

      ],
    );
  }

  createNewMessage(String image) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return WillPopScope(
                onWillPop: () {
                  return Future.value(true);
                },
                child: Material(
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.only(top: 100,left: 10,right: 10.0,bottom: 50.0),
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[

                            new Container(
                              width: 40.0,
                              margin: EdgeInsets.only(right: 10.0),
                              alignment: Alignment.topRight,
                              child: FlatButton(

                                  child: Icon(Icons.clear,color: Colors.white,size: 35.0,),
                                  onPressed: () {

                                    Navigator.of(context).pop();
                                  }),
                            ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: MediaQuery.of(context).size.height/1.5,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black,
                              image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),

                                  image: new NetworkImage(
                                      data['vendor_list_banner']
                                  ),
                                  fit: BoxFit.fill
                              )
                          ),
                        )
                          ],

                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}
