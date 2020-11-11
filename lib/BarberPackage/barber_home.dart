import 'package:flutter/material.dart';
import '../CommonMenuClass.dart';
class BarberHome extends StatefulWidget {
  @override
  _BarberHomeState createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> with SingleTickerProviderStateMixin {
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
        child: Center(

          child: RaisedButton(
            onPressed: ()
            {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommonDashBord("add_product", true)));
            },
            child: Text("Create Product",style: TextStyle(color: Colors.black,fontSize: 30.0),),
          ),
        ),
      ),
    );
  }
}
