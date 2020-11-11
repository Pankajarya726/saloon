import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salon_app/BarberPackage/gallery_activity.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/SearchModel/SearchCategory.dart';
import 'package:salon_app/language/AppLocalizations.dart';
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

class CreateProduct extends StatefulWidget {
  var id;

  CreateProduct(this.id);

   @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> with SingleTickerProviderStateMixin
{

  AnimationController _controller;
  var _formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var priceController=TextEditingController();
  var desController=TextEditingController();
  var srt_desController=TextEditingController();

  @override
  void initState()
  {
      _controller = AnimationController(vsync: this);
      Utility.log(TAG, widget.id);
      if(widget.id.toString()!="0")
      {
        GetData();
      }
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
                      height: 100,
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
                  SizedBox(height: 20.0,),
                  ProductSrtDescription(),
                  SizedBox(height: 20.0,),
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
          // Validate returns true if the form is valid, otherwise false.
          if (_formKey.currentState.validate()) {
            // getShareddata();
            SubmitData();
            //

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
      validator: (value) {
        if (value.isEmpty)
        {
          return AppLocalizations.of(context).translate("Please_Enter");
        }
        return null;
      },
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
          String Id="${data['id']}";
          categoryController.text=name;
          Category_Id=Id;
          setState(() {

          });
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

    var now1 = new DateTime.now();
    String dateval=now1.toString().replaceAll(" ", "T");
    Utility.log(TAG, now1.toString());
    Map<String, dynamic> body =
    {
      'name': nameController.text.toString(),
      'type': "simple",
      'status':"publish",
      'regular_price':priceController.text.toString(),
      'description':desController.text.toString(),
      'short_description':srt_desController.text.toString(),
      'gallery_images':a1,
      'featured_images':a2,
      'categories':category_list,
      'post_author':USER_ID
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
      //  print(data1);
        try {
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
      decoration: GlobalWidget.TextFeildDecoration(
          AppLocalizations.of(context).translate("pro_price") ),
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

}
