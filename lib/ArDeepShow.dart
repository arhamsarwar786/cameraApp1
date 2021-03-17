import 'package:flutter/material.dart';
import 'dart:io';

class ArDeepShow extends StatefulWidget {
  final path;
  ArDeepShow(this.path);
  @override
  _ArDeepShowState createState() => _ArDeepShowState();
}

class _ArDeepShowState extends State<ArDeepShow> {
  var imageGet = "";
  @override
  Widget build(BuildContext context) {
    setState(() {
      imageGet = widget.path;
    });
    return Scaffold(
      body: Container(
        child: Image.file(File(imageGet)),
      ),
    );
  }
}
