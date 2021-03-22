import 'package:flutter/material.dart';
import 'dart:typed_data';

class SecondScreen extends StatefulWidget {
  final Uint8List image;
  SecondScreen(this.image);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.memory(widget.image),
      ),
    );
  }
}

