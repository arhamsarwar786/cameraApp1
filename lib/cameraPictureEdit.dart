import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_first_app/ColorMatrix/colorMatrixFile.dart';
import 'package:my_first_app/image_list.dart';
import 'forTest.dart';
import 'model.dart';
import 'image_helper.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:convert' show utf8;

class CameraEditor extends StatefulWidget {
  final path;
  CameraEditor(this.path);
  @override
  _CameraEditorState createState() => _CameraEditorState(path);
}

class _CameraEditorState extends State<CameraEditor> {
  final path;
  int indexGet = 0;

  /////////////   Colors    ///////////////////////
  var myColors = [colors1, colors2, colors3];
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
    var data = path;

    ImageHelper helper = ImageHelper();

    var _globalKey = GlobalKey();

    void convertWidgetToImage() async {
      // RenderRepaintBoundary repaintBoundary =
      //     _globalKey.currentContext.findRenderObject();
      // ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
      // ByteData byteData =
      //     await boxImage.toByteData(format: ui.ImageByteFormat.png);
      // Uint8List uint8list = byteData.buffer.asUint8List();

      // Navigator.of(_globalKey.currentContext).push(MaterialPageRoute(
      //     builder: (context) => SecondScreen(
      //           uint8list,
      //         )));
    }

    var size = MediaQuery.of(context).size;
    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${widget.path}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () async {
                RenderRepaintBoundary repaintBoundary =
                    _globalKey.currentContext.findRenderObject();
                ui.Image boxImage =
                    await repaintBoundary.toImage(pixelRatio: 1);
                ByteData byteData =
                    await boxImage.toByteData(format: ui.ImageByteFormat.png);
                var uint8list = byteData.buffer.asUint8List();

                int result;
                ImageModel image = ImageModel(
                  image: uint8list,
                  name: DateTime.now().toString(),
                );
                result = await helper.insertImage(image);
                if (result != 0) {
                  // Success
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ImageList()));
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondScreen(uint8list)));
                // var gettingData = Uint8List.fromList(uint8list);
                // print("this is uit8List : $uint8list");
                // var getData = utf8.encode(uint8list.toString());
                // var data = utf8.decode(getData);
                // print("this is data i get : $data");
              }),
          InkWell(
            onTap: () async {
              // convertWidgetToImage();

              RenderRepaintBoundary repaintBoundary =
                  _globalKey.currentContext.findRenderObject();
              ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
              ByteData byteData =
                  await boxImage.toByteData(format: ui.ImageByteFormat.png);
              var uint8list = byteData.buffer.asUint8List();

              int result;
              ImageModel image = ImageModel(
                image: uint8list,
                name: DateTime.now().toString(),
              );
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
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                alignment: Alignment.topCenter,
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(myColors[indexGet]),
                  child: Container(
                    // color: color[change],
                    height: size.height * 0.60,
                    width: size.width,
                    child: Image.file(
                      File(data),
                      // color: Color.fromRGBO(255, 255, 255, 0.5),
                      colorBlendMode: BlendMode.modulate,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              // margin: EdgeInsets.only(top: 500),
              child: Container(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: color.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          indexGet = i;
                          // _opacity = 0.4;
                          // change = i;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.red, width: 3),
                          color: color[i],
                        ),
                        height: size.height * 0.10,
                        width: 150,
                        child: Container(
                          child: Center(
                              child: Text(
                            "${i + 1}",
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
