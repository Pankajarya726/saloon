import 'package:flutter/material.dart';

class EditPersonalInfoClass extends StatefulWidget {
  @override
  _EditPersonalInfoClassState createState() => _EditPersonalInfoClassState();
}

class _EditPersonalInfoClassState extends State<EditPersonalInfoClass>
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
