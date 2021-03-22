import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_first_app/ColorMatrix/colorMatrixFile.dart';
import 'package:my_first_app/image_list.dart';
import 'model.dart';
import 'image_helper.dart';
import 'dart:io';
import 'dart:ui' as ui;

class ArDeepShow extends StatefulWidget {
  final path;
  ArDeepShow(this.path);
  @override
  _ArDeepShowState createState() => _ArDeepShowState(path);
}

class _ArDeepShowState extends State<ArDeepShow> {
  final path;
  int indexGet = 0;

  /////////////   Colors    ///////////////////////
  var myColors = [
    colors1,
    colors2,
    colors3,
    colors4,
    colors5,
    colors6,
    colors7,
    colors8,
    colors9,
    colors10,
  ];
  _ArDeepShowState(this.path);
  List color = [
    Colors.transparent,
    Colors.red,
    Colors.green,
    Colors.pink,
    Colors.blue,
  ];
  @override
  Widget build(BuildContext context) {
    var data = path;

    ImageHelper helper = ImageHelper();

    var _globalKey = GlobalKey();

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              icon: Icon(
                Icons.check,
                size: 30,
              ),
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
              }),
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
                    height: size.height * 0.70,
                    width: size.width,
                    child: Image.file(
                      File(data),
                      colorBlendMode: BlendMode.modulate,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: myColors.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          indexGet = i;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red, width: 3),
                        ),
                        height: 120,
                        width: 120,
                        child: RepaintBoundary(
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.matrix(myColors[i]),
                              child: Container(
                                child: Image.asset(
                                  "images/filterDemo.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
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
