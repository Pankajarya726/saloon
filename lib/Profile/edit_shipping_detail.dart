import 'package:flutter/material.dart';

class EditShippingDetail extends StatefulWidget {
  @override
  _EditShippingDetailState createState() => _EditShippingDetailState();
}

class _EditShippingDetailState extends State<EditShippingDetail>
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
    return Container();
  }
}
