import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'image_helper.dart';
import 'dart:typed_data' show utf;

class ImageDetail extends StatefulWidget {
  final Uint8List imageGet;
  final String name;
  final int index;

  const ImageDetail({this.imageGet, this.name, this.index});

  @override
  _ImageDetailState createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  List<ImageModel> imageList;
  bool result;
  int count = 0;

  ImageHelper databaseHelper = ImageHelper();

  void _delete(BuildContext context, ImageModel image) async {
    // ImageModel image = myImage ;
    int result = await databaseHelper.deleteImage(image.id);
    if (result != 0) {
      _showSnackBar(context, 'Image Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ImageModel>> imageListFuture = databaseHelper.getImageList();
      imageListFuture.then((contactList) {
        setState(() {
          this.imageList = contactList;
          this.count = contactList.length;
        });
      });
    });
  }

  shareImage() async {
    // String myImage = utf8.decode(widget.imageGet);

    // var my = Image.memory(widget.imageGet);
    // my.
    // var base64Image = base64Encode(widget.imageGet);
    // var my = base64Decode(base64Image);
    // print(my.toString());
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/image1.jpg').create();

    file.writeAsBytesSync(widget.imageGet);
    print(file);
    // final channel = const MethodChannel('channel:me.albie.share/share');
    // channel.invokeMethod('shareFile', 'image.jpg');

    Share.shareFiles(['${tempDir.path}/image1.jpg']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Image.memory(
                widget.imageGet,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.name,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    icon: Icon(Icons.share),
                    onPressed: shareImage,
                  ),
                  IconButton(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        // _delete(context, imageList[widget.index].image);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
