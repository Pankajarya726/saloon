import 'package:flutter/material.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
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
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: new ListView(
          children: [
            new Column(
              children: [

                Divider(thickness: 15.0,),
                ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 5.0),
                  childrenPadding: EdgeInsets.all(0.0),
                  title: Text(
                    "PERSONAL INFO",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54
                    ),
                  ),
                  children: <Widget>[
                    new Center(
                      child: SingleChildScrollView(
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 15.0,),
                ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 5.0),
                  childrenPadding: EdgeInsets.all(0.0),
                  title: Text(
                    "Billing ADDRESS",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54
                    ),
                  ),

                  children: <Widget>[

                  ],
                ),
                Divider(thickness: 15.0,),
                ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 5.0),
                  childrenPadding: EdgeInsets.all(0.0),
                  title: Text(
                    "SHIPPING ADDRESS",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54
                    ),
                  ),

                  children: <Widget>[

                  ],
                ),
                Divider(thickness: 15.0,),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
