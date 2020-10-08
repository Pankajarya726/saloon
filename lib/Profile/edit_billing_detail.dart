import 'package:flutter/material.dart';

class EditBillingDetail extends StatefulWidget {
  @override
  _EditBillingDetailState createState() => _EditBillingDetailState();
}

class _EditBillingDetailState extends State<EditBillingDetail>
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
