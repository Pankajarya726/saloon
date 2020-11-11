import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImageActivity extends StatefulWidget
{

  String ImagePath;
  ZoomImageActivity(this.ImagePath);
  @override
  State<StatefulWidget> createState() {
   return ZoomViewData();
  }
}

class ZoomViewData extends State<ZoomImageActivity>
{
  @override
  Widget build(BuildContext context) {
   return new Scaffold(
    appBar: new AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      actions: [
        InkWell(
          onTap: ()
          {
            Navigator.of(context).pop();
          },
          child:
          Icon(Icons.close),
        )
      ],
    ),
    body: PhotoView(
      imageProvider:new NetworkImage(
        widget.ImagePath
      ),
    ),
  );
  }

}