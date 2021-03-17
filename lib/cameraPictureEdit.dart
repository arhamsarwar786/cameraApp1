import 'package:flutter/material.dart';
import 'package:my_first_app/image_list.dart';
import 'model.dart';
import 'image_helper.dart';
import 'dart:io';

class CameraEditor extends StatefulWidget {
  final path;
  CameraEditor(this.path);
  @override
  _CameraEditorState createState() => _CameraEditorState(path);
}

class _CameraEditorState extends State<CameraEditor> {
  final path;
  _CameraEditorState(this.path);
  List color = [
    Colors.transparent,
    Colors.red,
    Colors.green,
    Colors.pink,
    Colors.blue,
  ];
  var _opacity = 1.0, change = 0;
  @override
  Widget build(BuildContext context) {
    var data = File(path);
    ImageHelper helper = ImageHelper();

    var size = MediaQuery.of(context).size;
    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${widget.path}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          InkWell(
            onTap: () async {
              int result;
              ImageModel image = ImageModel(
                  image: widget.path, name: DateTime.now().toString());
              result = await helper.insertImage(image);
              if (result != 0) {
                // Success
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ImageList()));
              }
            },
            child: Image.network(
              "https://proofmart.com/wp-content/uploads/2020/09/mark-symball-icon-3-product.png",
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          // fit: StackFit.expand,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                color: color[change],
                height: size.height * 0.60,
                width: size.width,
                child: Opacity(
                  opacity: _opacity,
                  child: Image.file(
                    data,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 500),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: color.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _opacity = 0.4;
                        change = i;
                      });
                    },
                    child: Container(
                      color: color[i],
                      height: size.height * 0.30,
                      width: 150,
                      child: Opacity(
                        opacity: 0.3,
                        child: Container(
                          // color: Colors.red,
                          child: Image.network(
                            "https://proofmart.com/wp-content/uploads/2020/09/mark-symball-icon-3-product.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
