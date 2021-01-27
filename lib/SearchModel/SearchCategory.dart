import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'SearchModel.dart';

class SearchCategory extends StatefulWidget
{
  static String tag = 'SearchCategory';
  @override
  _SearchCategoryState createState() => new _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory>
{
//  List<SearchModel> _items = new List();
  final subject = new PublishSubject<String>();
  bool _isLoading = false;
  List<SearchModel> duplicateItems = List<SearchModel>();
  List<SearchModel> items = List<SearchModel>();
  var products;
  var listdata;

  Future<void> UpdateData() async
  {
    ApiController apiController = new ApiController.internal();
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(context,GlobalConstant.CommanUrl+"products/categories/",token)
          .then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = value;
          var data1 = json.decode(data.body);
          for (int i = 0; i < data1.length; i++)
          {
            _addBook(data1[i]);
          }
          items.addAll(duplicateItems);
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


  Future _textChanged(String text) async {
    List<SearchModel> dummySearchList = List<SearchModel>();
    dummySearchList.addAll(duplicateItems);
    if (text.isNotEmpty) {
      List<SearchModel> dummyListData = List<SearchModel>();
      dummySearchList.forEach((item) {
        if (item.title.toLowerCase().contains(text.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  void _addBook(dynamic book) {
    setState(() {

      String Name=book['name'].toString();
        print(Name);
      duplicateItems.add(new SearchModel(Name, book["id"].toString(),book));
    });
  }

  //FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    UpdateData();
    subject.stream.debounce(new Duration(milliseconds: 600)).listen(_textChanged);
    //_focusNode = FocusNode();
  }

  TextEditingController controller = new TextEditingController();
  @override
  void dispose() {
   // _focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: new Scaffold(
        body: new Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 22.0),
          child: new Column(
           // mainAxisAlignment: MainAxisAlignment.start,
            
            children: <Widget>[
              new Container(
                height: 50.0,
                color: Colors.grey[300],
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Container(
                        width: MediaQuery.of(context).size.width,
                        child:  Row(
                          children: <Widget>[
                            Expanded(flex: 1,child: new InkWell(
                                onTap: ()
                                {
                                  Navigator.of(context).pop();
                                },
                                child:  new Icon(Icons.close,color: Colors.black),
                            ),),
                             Expanded(flex: 1,child: new Container(

                              alignment: Alignment.center,
                              child:  new Icon(Icons.search,color: Colors.black),
                            ),),
                            Expanded(flex: 7,child:new Container(
                              padding: EdgeInsets.only(left: 20.0),
                              child: new TextField(
                                //focusNode: _focusNode,
                              //  autofocus: true,
                                controller: controller,
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                hintText: AppLocalizations.of(context).translate("SEARCH"), border: InputBorder.none),
                                onChanged: (value){
                                  subject.add(value);
                                },
                              ) ,
                            ),),

                            Expanded(flex: 1,child: Container(
                              alignment: Alignment.centerRight,
                              child: new IconButton(icon:Image.asset("images/clean.png",color: Colors.black,),iconSize: 20.0, onPressed: () {
                                controller.clear();

                                subject.add("");
                                // onSearchTextChanged('');
                              },),
                            ),)
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),

              _isLoading ? new Center(child: new CircularProgressIndicator(),) : new Container(),
              new Expanded(

                child: new GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio:0.8,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: new List.generate(items.length, (index)
                  {

                    return InkWell(
                      onTap: () {
                        String idValue = ": \"" + "${items[index].data['id'].toString()}" + "\"";
                        String Name_Value = ": \"" + "${items[index].data['name'].toString()}" + "\"";
                        String id = "\"id\"";
                        String name = "\"name\"";
                        var json = "{" + id + idValue +","+ name + Name_Value + "}";
                        Navigator.pop(context, json);
                       // Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new CommonDashBord("Cat_Product", true, _list[index])));
                      },
                      child: new Container(
                        margin: EdgeInsets.all(2.0),
                        alignment: Alignment.center,
                        //color: Colors.blueGrey[300],
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(height:10,),
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
                                    image: items[index].data['image']['src'].toString(),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10,),

                            Container(
                              alignment: Alignment.center,
                              child: new Text(
                                GlobalFile.getCaptialize(items[index].data['name'].toString(),),
                                style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
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
                )
                
                
                /* new ListView.builder(
                  padding: new EdgeInsets.all(10.0),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Container(padding: EdgeInsets.all(10.0),
                            child: new Text(items[index].data['name'].toString()),),
                          Divider(thickness: 2.0,)
                        ],
                      ),
                      onTap: (){
                        String idValue = ": \"" + "${items[index].data['id'].toString()}" + "\"";
                        String Name_Value = ": \"" + "${items[index].data['name'].toString()}" + "\"";
                        String id = "\"id\"";
                        String name = "\"name\"";
                        var json = "{" + id + idValue +","+ name + Name_Value + "}";
                        Navigator.pop(context, json);
                      },
                    ) ;


                  },
                )*/,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
