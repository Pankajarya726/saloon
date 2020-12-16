import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:salon_app/BarberPackage/gallery_activity.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/SearchModel/SearchCategory.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreateProduct extends StatefulWidget
{
    var id;
    CreateProduct(this.id);
    @override
    _CreateProductState createState() => _CreateProductState();

}

class _CreateProductState extends State<CreateProduct> with SingleTickerProviderStateMixin
{

  bool valuefirst = false;
 /* final GlobalKey<FlutterSummernoteState> keyEditor = GlobalKey();
  final GlobalKey<FlutterSummernoteState> keyEditor_short_des = GlobalKey();
*/
  List <String> durationIntItems = GlobalConstant.GetIntItems();
  String durationInt = GlobalConstant.GetIntItems()[0].toString();
  List <String> durationStringItems = GlobalConstant.GetStringItems();
  String durationString = GlobalConstant.GetStringItems()[0].toString();

  List<String> PaddingTimeStringItems = GlobalConstant.GetStringItems();
  String PaddingTimeString = GlobalConstant.GetStringItems()[0].toString();
  List <String> PaddingTimeIntItems = GlobalConstant.GetIntItems();
  String PaddingTimeInt = GlobalConstant.GetIntItems()[0].toString();

  List <String> IntervalIntItems = GlobalConstant.GetIntItems();
  String IntervalInt = GlobalConstant.GetIntItems()[0].toString();
  List <String> IntervalStringItems = GlobalConstant.GetStringItems();
  String IntervalString = GlobalConstant.GetStringItems()[0].toString();

  List <String> CancelIntItems = GlobalConstant.GetIntItems();
  String CancelInt = GlobalConstant.GetIntItems()[0].toString();
  List <String> CancelStringItems = GlobalConstant.GetStringItems();
  String CancelString = GlobalConstant.GetStringItems()[0].toString();

  AnimationController _controller;
  var _formKey=GlobalKey<FormState>();

  var nameController=TextEditingController();
  var priceController=TextEditingController();
  var desController=TextEditingController();
  var srt_desController=TextEditingController();

  @override
  void initState()
  {
       // keyEditor.currentState.getTextJavascriptChannel.call(null).toString();
       // keyEditor_short_des.currentState.getTextJavascriptChannel.call(null).toString();

      _controller = AnimationController(vsync: this);
      Utility.log(TAG, widget.id);
      if(widget.id.toString()!="0")
      {
        GetData();
      }
      super.initState();
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

  WebViewController _controller_web;
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        print('JavascriptMessage: ${message.message}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child:Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(10.0),
            shrinkWrap: true,
            children: [
              new Column(
                //padding: EdgeInsets.all(10.0),
                children: [
                  new SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: new Container(
                        alignment: Alignment.center,
                        color: Colors.grey[200],
                        child: new IconButton(icon:Icon(Icons.add_photo_alternate),color: Colors.black,iconSize: 80.0,
                          onPressed: ()
                          {
                            Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>GalleryActivity()),).then((val)
                            {
                              if(val!=null)
                              {
                                for(int i=0;i<val.length;i++)
                                  {
                                    _list.add(val[i]);
                                  }
                                  setState(() {
                                    Utility.log(TAG, _list.length);
                                  });
                               // Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) => new CommonDashBord("vendor_list",false)));
                              }
                            });
                          },
                        ),
                      )
                  ),

                  _list.length>0?getListingData():new Container(),

                  new Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(AppLocalizations.of(context).translate("add_product"),textAlign: TextAlign.center,),
                  ),
                  ProductName(),
                  SizedBox(height: 20.0,),
                  ProductPrice(),
                  SizedBox(height: 20.0,),
                  CategoryClickFeild(),
                  SizedBox(height: 20.0,),
                  ProductDescription(),

                  //add customer id in order api and get customer order

                  /*FlutterSummernote(
                    hint: AppLocalizations.of(context).translate("des").toString(),
                    value:widget.id.toString()!="0"?data['description'].toString():"",
                    key: keyEditor,

                    height: 400,
                  ),
*/
                 // Divider(thickness:10.0,),

                  SizedBox(height: 20.0,),
                  ProductSrtDescription(),
/*
                 FlutterSummernote(
                    hint: AppLocalizations.of(context).translate("srt_des"),
                    value: widget.id.toString()!="0"?data['short_description'].toString():"",
                    key: keyEditor_short_des,
                    height: 350,
                  ),
*/

                  Divider(thickness: 10.0,),
                  SizedBox(height: 20.0,),

                  new Row(
                    children: [
                      Expanded(flex: 1,
                      child: GlobalConstant.getDurationString(AppLocalizations.of(context).translate("duration")),),
                      Expanded(flex: 1,
                      child:  getDurationInt(),),
                      SizedBox(width: 20,),
                      Expanded(flex: 1,
                      child:  getDurationString(),),
                    ],
                  ),

                  SizedBox(height: 20.0,),

                  new Row(
                    children: [
                      Expanded(flex: 1,
                      child: GlobalConstant.getDurationString(AppLocalizations.of(context).translate("Interval")),),
                      Expanded(flex: 1,
                      child:  getIntervalInt(),),
                      SizedBox(width: 20,),
                      Expanded(flex: 1,
                      child:  getIntervalString(),),
                    ],
                  ),

                  SizedBox(height: 20.0,),

                  new Row(
                    children: [
                      Expanded(flex: 1,
                        child: GlobalConstant.getDurationString(AppLocalizations.of(context).translate("PaddingTime")),),
                      Expanded(flex: 1,
                        child:  getPaddingTimeInt(),),
                      SizedBox(width: 20,),
                      Expanded(flex: 1,
                        child:  getPaddingTimeString(),),

                    ],
                  ),

                  SizedBox(height: 20.0,),
                  new Row(
                    children: [
                    Expanded(flex:1,child: getCancelCheck(),),
                      Expanded(flex: 9,
                        child: GlobalConstant.getDurationStringText(AppLocalizations.of(context).translate("canbecanceltext")),),
                    ],
                  ),

                  SizedBox(height: 5.0,),
                  valuefirst==true? new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          Expanded(flex: 1,
                            child: GlobalConstant.getDurationString(AppLocalizations.of(context).translate("canbecancel")),),
                          Expanded(flex: 1,
                            child:  getCancelInt(),),
                          SizedBox(width: 20,),
                          Expanded(flex: 1,
                            child:  getCancelString(),),
                        ],
                      ),
                      SizedBox(height: 20.0,),
                    ],
                  ):new Container(),
                  GetSubmitButton(),
                  SizedBox(height: 20.0,),
                  GetBackToHome(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  var data;
  List _list=new List();

  void GetData() async
  {
    String token = (await Utility.getStringPreference(GlobalConstant.admin_token));
    String Url = GlobalConstant.CommanUrl+"products/"+widget.id.toString();
    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(Url,token).then((value)
      {
        try
        {

          Dialogs.hideProgressDialog(context);
          data = json.decode(value.body);
          nameController.text=data['name'];
          priceController.text=data['price'];
          desController.text=data['description'];
          srt_desController.text=data['short_description'];
          Category_Id=data['categories'][0]['id'].toString();
          categoryController.text=data['categories'][0]['name'].toString();
          List l1=data['images'];
          for(int i=0;i<l1.length;i++)
          {
            _list.add(l1[i]['src']);
          }
          setState(() {
          });
        }catch(e)
        {
        }
      });

    }else
    {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  void GetDataNew() async
  {
    String token = (await Utility.getStringPreference(GlobalConstant.admin_token));
    String Url ="https://api.smartdatasystem.es/v1/sensors?apiKey=5ad97dec969a5d8c6f87d647601828bafebf1208f13d78e5c060ad4c3595a293";
    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.getsNewData(Url).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
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

  GetBackToHome() {
    return new Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolor(),
        textColor: GlobalWidget.getBtnTextColor(),
        onPressed: ()
        {
          Navigator.of(context).pop();
        },
        child: Text(AppLocalizations.of(context).translate("back_shop"),style: GlobalWidget.textbtnstyle(),),
      ),
    );
  }

  GetSubmitButton() {
    return new Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        shape: GlobalWidget.getButtonTheme(),
        color: GlobalWidget.getBtncolorDark(),
        textColor: GlobalWidget.getBtnTextColorDark(),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // getShareddata();
            SubmitData();
          }
        },
        child: Text(
          AppLocalizations.of(context).translate("Submit").toUpperCase(),
          style: GlobalWidget.textbtnstyleDark(),
        ),
      ),
    );
  }

  ProductName()
  {
    return TextFormField(
      style: TextStyle(fontSize: 18.0, color: Colors.black),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: nameController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("pro_name") ),
      validator: (value) {
        if (value.isEmpty)
        {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  ProductDescription()
  {
    return TextFormField(
      style: TextStyle(fontSize: 18.0, color: Colors.black),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: desController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("des") ),
      validator: (value)
      {
        if (value.isEmpty)
        {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  ProductWeb()
  {
    return Container(
      height: 20,
      child: WebView(
        initialUrl: 'https://www.google.com',
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: [_toasterJavascriptChannel(context)].toSet(),
        onWebViewCreated: (WebViewController container) {
          _controller_web = container;
        },
        onPageFinished: (url) {
          _controller_web.evaluateJavascript('User Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 12_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148');
        },
      ),
    );
  }

  ProductSrtDescription()
  {
    return TextFormField(
      style: TextStyle(fontSize: 18.0, color: Colors.black),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: srt_desController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("srt_des") ),
      validator: (value) {
        if (value.isEmpty)
        {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  _toggle1() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new SearchCategory()),).then((val)
    {
      FocusScope.of(context).requestFocus(new FocusNode());
      if(val!=null)
      {
        setState(()
        {
          var data=json.decode(val);
          String name="${data['name']}";
          String Id = "${data['id']}";
          categoryController.text=name;
          Category_Id=Id;
          setState(() {});
        });
      }
    });
  }

  var categoryController=TextEditingController();
  String Category_Id="";
  CategoryClickFeild() {

    return GestureDetector(
      child: TextFormField(
        style: TextStyle(fontSize: 18.0, color: Colors.black),
        readOnly: true,
        onTap: () {
          _toggle1();
        },
        controller: categoryController,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          contentPadding:GlobalWidget.getContentPadding(),
          hintText: AppLocalizations.of(context).translate("fetch_cat"),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(left: 20.0),
            // onPressed: () => _toggle1(),
            icon: Icon(Icons.arrow_drop_down),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return AppLocalizations.of(context).translate("Please_Enter");
          }
          return null;
        },
      ),
      onTap: ()
      {
        _toggle1();
      },);
  }

  String TAG="Create Product";
  void SubmitData() async
  {
      List a1=new List();
      List a2=new List();
      List category_list=new List();

     /* String description_text_data =  keyEditor.currentState.text.toString();
      String  srt_description_text_data =  keyEditor_short_des.currentState.text.toString();*/

      String description_text_data = desController.text.toString();
      String  srt_description_text_data =  srt_desController.text.toString();

      //final txt = await keyEditor.currentState.getText();
      // print("txt---$txt");

      print("descrip");
      print(description_text_data);
      print(srt_description_text_data);

      Map<String, String> mapobj_data2() => {'src': "http://demo.woothemes.com/woocommerce/wp-content/uploads/sites/56/2013/06/T_2_front.jpg"};

      for(int i=0;i<_list.length;i++)
      {
        Map<String, String> mapobj_data1() => {'src': _list[i].toString()};
        a1.add(mapobj_data1());
      }

          a2.add(mapobj_data2());
          category_list.add(Category_Id);

          String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));
          String token = (await Utility.getStringPreference(GlobalConstant.token));
          List meta_data_a1=new List();
          Map<String, String> meta_data() => {'_wcfm_product_author': USER_ID};
          Map<String, String> meta_data2() => {'_regular_price': priceController.text.toString()};
          Map<String, String> meta_data3() => {'total_sales': "49"};
          Map<String, String> meta_data4() => {'_tax_status': "taxable"};
          Map<String, String> meta_data5() => {'_manage_stock': "no"};
          Map<String, String> meta_data6() => {'_backorders': "no"};
          Map<String, String> meta_data7() => {'_sold_individually': "no"};
          Map<String, String> meta_data8() => {'_virtual': "yes"};
          Map<String, String> meta_data9() => {'_downloadable': "no"};
          Map<String, String> meta_data10() => {'_download_limit': "-1"};
          Map<String, String> meta_data11() => {'_download_expiry': "-1"};
          Map<String, String> meta_data12() => {'_stock': ""};
          Map<String, String> meta_data13() => {'_wc_average_rating': "0"};
          Map<String, String> meta_data14() => {'_wc_review_count': "0"};
          Map<String, String> meta_data15() => {'_has_additional_costs': ""};
          Map<String, String> meta_data16() => {'_wc_appointment_has_price_label': ""};
          Map<String, String> meta_data17() => {'_wc_appointment_has_pricing': ""};
          Map<String, String> meta_data18() => {'_wc_appointment_pricing': "a:0:{}"};
          Map<String, String> meta_data19() => {'_wc_appointment_qty': "1"};
          Map<String, String> meta_data20() => {'_wc_appointment_qty_min': "1"};
          Map<String, String> meta_data21() => {'_wc_appointment_duration_unit': durationString};
          Map<String, String> meta_data22() => {'_wc_appointment_duration': durationInt};
          Map<String, String> meta_data23() => {'_wc_appointment_interval_unit': IntervalString};
          Map<String, String> meta_data24() => {'_wc_appointment_interval': IntervalInt};
          Map<String, String> meta_data25() => {'_wc_appointment_padding_duration_unit': PaddingTimeString};
          Map<String, String> meta_data26() => {'_wc_appointment_padding_duration': PaddingTimeInt};
          Map<String, String> meta_data27() => {'_wc_appointment_min_date_unit': "day"};
          Map<String, String> meta_data28() => {'_wc_appointment_min_date': "0"};
          Map<String, String> meta_data29() => {'_wc_appointment_max_date_unit': "month"};
          Map<String, String> meta_data30() => {'_wc_appointment_max_date': "12"};
          Map<String, String> meta_data31() => {'_wc_appointment_user_can_cancel': ""};
          Map<String, String> meta_data32() => {'_wc_appointment_cancel_limit_unit': CancelString};
          Map<String, String> meta_data33() => {'_wc_appointment_cancel_limit': CancelInt};
          Map<String, String> meta_data34() => {'_wc_appointment_requires_confirmation': ""};
          Map<String, String> meta_data35() => {'_wc_appointment_customer_timezones': "1"};
          Map<String, String> meta_data36() => {'_wc_appointment_cal_color': "#0073aa"};

    meta_data_a1.add(meta_data());
    meta_data_a1.add(meta_data2());
    meta_data_a1.add(meta_data3());
    meta_data_a1.add(meta_data4());
    meta_data_a1.add(meta_data5());
    meta_data_a1.add(meta_data6());
    meta_data_a1.add(meta_data7());
    meta_data_a1.add(meta_data8());
    meta_data_a1.add(meta_data9());
    meta_data_a1.add(meta_data10());
    meta_data_a1.add(meta_data11());
    meta_data_a1.add(meta_data12());
    meta_data_a1.add(meta_data13());
    meta_data_a1.add(meta_data14());
    meta_data_a1.add(meta_data15());
    meta_data_a1.add(meta_data16());
    meta_data_a1.add(meta_data17());
    meta_data_a1.add(meta_data18());
    meta_data_a1.add(meta_data19());
    meta_data_a1.add(meta_data20());
    meta_data_a1.add(meta_data21());
    meta_data_a1.add(meta_data22());
    meta_data_a1.add(meta_data23());
    meta_data_a1.add(meta_data24());
    meta_data_a1.add(meta_data25());
    meta_data_a1.add(meta_data26());
    meta_data_a1.add(meta_data27());
    meta_data_a1.add(meta_data28());
    meta_data_a1.add(meta_data29());
    meta_data_a1.add(meta_data30());
    meta_data_a1.add(meta_data31());
    meta_data_a1.add(meta_data32());
    meta_data_a1.add(meta_data33());
    meta_data_a1.add(meta_data34());
    meta_data_a1.add(meta_data35());
    meta_data_a1.add(meta_data36());
    Utility.log(TAG, meta_data_a1);

    var now1 = new DateTime.now();
    String dateval=now1.toString().replaceAll(" ", "T");
    Utility.log(TAG, now1.toString());

    Map<String, dynamic> body =
    {
      'name': nameController.text.toString(),
      'type': "appointment",
      'status':"publish",
      'regular_price': priceController.text.toString(),
      'description':description_text_data,
      'short_description': srt_description_text_data,
      'gallery_images': a1,
      'featured_images': a2,
      'categories': category_list,
      'post_author': USER_ID,
      'meta_data': meta_data_a1
    };

      String id="";
      if(widget.id.toString()!="0")
      {
        id=widget.id.toString();
      }
    String Url=GlobalConstant.CommanUrlLogin+"wcfmmp/v1/products/"+id;
    ApiController apiController = new ApiController.internal();
    if(await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.PostsNewWithToken(Url,json.encode(body),token).then((value)
      {
        var data1 = json.decode(value.body);
        try
        {
          Dialogs.hideProgressDialog(context);
          if(value.statusCode==200)
            {
              Navigator.pop(context, "done");
            }
        } catch (e) {
           GlobalWidget.showMyDialog(context, "", data1);
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  ProductPrice() {
    return TextFormField(
      style: TextStyle(fontSize: 18.0, color: Colors.black),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: priceController,
      decoration: GlobalWidget.TextFeildDecoration(AppLocalizations.of(context).translate("pro_price") ),
      validator: (value)
      {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
    );
  }

  getListingData() {
    return  new Container(height: 100,
      child:  new ListView.builder
        (
          scrollDirection: Axis.horizontal,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _list.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Container(
              width: 100.0,
              child: InkWell(child: Icon(Icons.close,color: Colors.white,),onTap: (){
                _list.removeAt(index);
                setState(() {

                });
              },),
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 5.0,right: 5.0,left: 5.0),
            //  padding: EdgeInsets.only(bottom: 5.0,right: 5.0,left: 5.0),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
                      image: new NetworkImage(
                          _list[index]
                      ),
                      fit: BoxFit.fill
                  )
              ),
            );
          }
      ),);
  }

  getDurationInt() {
    return
      new Theme(
        data: GlobalConstant.getSpinnerTheme(context),
        child: DropdownButton<String>(
        value: durationInt,
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: GlobalConstant.getTextStyle(),
        underline:GlobalConstant.getUnderline(),
        onChanged: (String data) {
          setState(() {
            durationInt = data;
          });
        },
        items: durationIntItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ));
  }
  getDurationString() {
    return
      new Theme(
        data: GlobalConstant.getSpinnerTheme(context),
        child: DropdownButton<String>(
        value: durationString,
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: GlobalConstant.getTextStyle(),
        underline:GlobalConstant.getUnderline(),
        onChanged: (String data) {
          setState(() {
            durationString = data;
          });
        },
        items: durationStringItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ));
  }

  getIntervalInt() {
    return
      new Theme(
          data: GlobalConstant.getSpinnerTheme(context),
          child: DropdownButton<String>(
            value: IntervalInt,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: GlobalConstant.getTextStyle(),
            underline:GlobalConstant.getUnderline(),
            onChanged: (String data) {
              setState(() {
                IntervalInt = data;
              });
            },
            items: IntervalIntItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ));
  }
  getIntervalString() {
    return
      new Theme(
          data: GlobalConstant.getSpinnerTheme(context),
          child: DropdownButton<String>(
            value: IntervalString,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: GlobalConstant.getTextStyle(),
            underline:GlobalConstant.getUnderline(),
            onChanged: (String data) {
              setState(() {
                IntervalString = data;
              });
            },
            items: IntervalStringItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ));
  }

  getPaddingTimeInt() {
    return
      new Theme(
          data: GlobalConstant.getSpinnerTheme(context),
          child: DropdownButton<String>(
            value: PaddingTimeInt,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: GlobalConstant.getTextStyle(),
            underline:GlobalConstant.getUnderline(),
            onChanged: (String data) {
              setState(() {
                PaddingTimeInt = data;
              });
            },
            items: PaddingTimeIntItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ));
  }
  getPaddingTimeString() {
    return
      new Theme(
          data: GlobalConstant.getSpinnerTheme(context),
          child: DropdownButton<String>(
            value: PaddingTimeString,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: GlobalConstant.getTextStyle(),
            underline:GlobalConstant.getUnderline(),
            onChanged: (String data) {
              setState(() {
                PaddingTimeString = data;
              });
            },
            items: PaddingTimeStringItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ));
  }


  getCancelInt() {
    return
      new Theme(
          data: GlobalConstant.getSpinnerTheme(context),
          child: DropdownButton<String>(
            value: CancelInt,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: GlobalConstant.getTextStyle(),
            underline:GlobalConstant.getUnderline(),
            onChanged: (String data) {
              setState(() {
                CancelInt = data;
              });
            },
            items: CancelIntItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ));
  }
  getCancelString() {
    return
      new Theme(
          data: GlobalConstant.getSpinnerTheme(context),
          child: DropdownButton<String>(
            value: CancelString,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: GlobalConstant.getTextStyle(),
            underline:GlobalConstant.getUnderline(),
            onChanged: (String data) {
              setState(() {
                CancelString = data;
              });
            },
            items: CancelStringItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ));
  }

  getCancelCheck() {
    return   Checkbox(
      checkColor: Colors.white,
      activeColor: Colors.black54,

      value: this.valuefirst,
      onChanged: (bool value) {
        setState(() {
          this.valuefirst = value;
        });
      },
    );
  }

}
