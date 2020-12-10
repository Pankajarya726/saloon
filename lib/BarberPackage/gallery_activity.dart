import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_app/Appointment/AppointmentClass.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:io';

import 'package:toast/toast.dart';
class GalleryActivity extends StatefulWidget
{
  @override
  _GalleryActivityState createState() => _GalleryActivityState();
}

class _GalleryActivityState extends State<GalleryActivity> with SingleTickerProviderStateMixin
{
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
   /*
    _list.add(new ImageModel("http://demo.woothemes.com/woocommerce/wp-content/uploads/sites/56/2013/06/T_2_front.jpg",false));
    _list.add(new ImageModel("http://salon.microband.site/wp-content/uploads/2020/10/download-1.jpeg",false));
    _list.add(new ImageModel("http://salon.microband.site/wp-content/uploads/2018/02/team-member-4.jpg",false));
    _list.add(new ImageModel("http://salon.microband.site/wp-content/uploads/2018/03/contact-title-img.jpg",false));
    _list.add(new ImageModel("http://salon.microband.site/wp-content/uploads/2018/03/services-title-img.jpg",false));
    _list.add(new ImageModel("http://salon.microband.site/wp-content/uploads/2018/03/about-title-img.jpg",false));
   */

     super.initState();
     GetData();
  }

  void GetData() async
  {

    _list=new List();
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrlLogin+"wp/v2/media/";
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(Url,token).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data = json.decode(value.body);
          for(int i=0;i<data.length;i++)
          {
             print(data[i]["source_url"]);
             _list.add(new ImageModel(data[i]["source_url"].toString(),false));
             setState(()
             {

             });
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

   Future<bool> SelectPhotoOption(BuildContext context)
   {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Row(
            children:
            [
              Expanded(
                child:  new Text(AppLocalizations.of(context).translate("select")),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child:  new Container(
                    alignment: Alignment.topRight,
                    child: new Icon(Icons.close),
                  ),
                ),
              ),
            ],
          ),
          content: new Container(
            height: 200,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(thickness: 10.0,),
                InkWell(
                  onTap: ()
                  {
                     Navigator.of(context).pop();
                    _imgFromCamera();
                  },
                  child: new Container(
                    padding: EdgeInsets.only(top: 20,bottom: 20.0),
                    child:  new Row(
                      children: [
                        Expanded(flex: 2,
                          child: Icon(Icons.camera_alt,color: Colors.black,),),
                        Expanded(flex: 8,
                          child:  new Container(
                            alignment: Alignment.centerLeft,
                            child: new Text('From Camera',style: TextStyle(fontSize: 18.0),),
                          ),),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: ()
                  {
                    Navigator.of(context).pop();
                    _imgFromGallery();
                  },
                  child: new Container(
                    padding: EdgeInsets.only(top: 20,bottom: 20.0),
                    child:  new Row(
                      children: [

                        Expanded(flex: 2,
                          child: Icon(Icons.image,color: Colors.black,),),

                        Expanded(flex: 8,
                          child:  new Container(
                            alignment: Alignment.centerLeft,
                            child: new Text('From Gallery',style: TextStyle(fontSize: 18.0),),
                          ),),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ) ?? false;
  }

    asyncFileUpload(File imageFile) async
    {

      Dialogs.showProgressDialog(context);
      String token = (await Utility.getStringPreference(GlobalConstant.token));
      String Url = GlobalConstant.CommanUrlLogin+"wp/v2/media/";

      String fileName = imageFile.path.split("/").last;

      Map<String, String> requestHeaders = {
        'Content-type': 'multipart/form-data',
        'charset': 'UTF-8',
        'Authorization': 'Bearer $token',
        'Content-Disposition':"attachment; filename=$fileName"
      };


      var request = http.MultipartRequest("POST", Uri.parse(Url));
      request.headers.addAll(requestHeaders);
      // open a bytestream
      var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: fileName);

      // add file to multipart
      request.files.add(multipartFile);


      print(request.files);
      print(request.toString());
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      //GlobalFile.Showsnackbar(_globalKey, "Document Uploaded");
      print(responseString);
      print(response.statusCode);


      //var data=json.decode(responseString);

      if(response.statusCode==201)
      {
        GetData();
      }else{
      }
    }

    Future<bool> UploadImageOption(BuildContext context,File path)
    {

     return showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Row(
              children: [

                Expanded(
                  child:  new Text(AppLocalizations.of(context).translate("upload_image"),style: TextStyle(color: Colors.red[400]),),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child:  new Container(
                      alignment: Alignment.topRight,
                      child: new Icon(Icons.close),
                    ),
                  ),
                ),

              ],
          ),
          content: new Container(
            height: 250,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Divider(thickness: 2.0,),
                SizedBox(height: 10,),
                Text(AppLocalizations.of(context).translate("upload_txt"),style: TextStyle(color: Colors.black),),
                SizedBox(height: 20,),
                Container(
                  height: 180,
                  width: 180,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image:FileImage(path),
                      )
                  ),
                )

              ],
            ),
          ),

          actions: <Widget>[
            new FlatButton(
              onPressed: ()
              {
                Navigator.of(context).pop(false);
                asyncFileUpload(path);
              },
              child: new Text(AppLocalizations.of(context).translate("YES")),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: new Text(AppLocalizations.of(context).translate("NO")),
            ),
          ],

        );
      },
    ) ?? false;
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
      uploadImage(_image);
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
      uploadImage(_image);
    });
  }

  File _image;
  List<ImageModel> _list=new List();

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Column(
        children: [
          Expanded(flex: 1,
          child: new Row(
            children: [
              Expanded(
               child: new SizedBox(
                   child: new Container(
                     alignment: Alignment.center,
                     color: Colors.grey[200],
                     child: new IconButton(icon:Icon(Icons.add_photo_alternate),color: Colors.black,iconSize: 40.0,
                       onPressed: ()
                       {
                         SelectPhotoOption(context);
                       },
                     ),
                   )
               ),
              ),
              SizedBox(width: 10.0),
              Expanded(
               child:
               new SizedBox(
                   child: new Container(
                     alignment: Alignment.center,
                     color: Colors.grey[200],

                     child: new IconButton(icon:Icon(Icons.check),color: Colors.black,iconSize: 60.0,
                       onPressed: ()
                       {
                         List l1=new List();
                         for(int i=0;i<_list.length;i++)
                           {
                             if(_list[i].check==true)
                               {
                                 l1.add(_list[i].image);
                               }
                           }
                         Navigator.pop(context, l1);
                       },
                     ),
                   )
               ),
              ),
            ],
          ),),

          Expanded(flex: 9,
          child: new Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: _list.length!=0?new GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: new List.generate(_list.length, (index)
              {
                return InkWell(

                  onTap:()
                  {
                    _list[index].check=!_list[index].check;
                    setState(()
                    {
                      Utility.log("CheckVal", _list[index].check);
                    });
                  },

                  child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 2.0,right: 5.0,left: 2.0),
                    child: _list[index].check==true?Icon(Icons.check,color: Colors.green,size: 60,):new Container(),
                   // padding: EdgeInsets.only(bottom: 5.0,right: 5.0,left: 5.0),
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                        image: DecorationImage(
                            image: new NetworkImage(
                                _list[index].image.toString()
                            ),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                );
              }),
            ):GlobalWidget.getNoRecord(context),
          ),),
        ],
      ),
    );
  }

  void uploadImage(File image) {
    Utility.log(TAG, image.path.toString());
    UploadImageOption(context,image);
  }
  String TAG="Gallery Image";
}

class ImageModel
{
  String image;
  bool check;

  ImageModel(this.image, this.check);
}
