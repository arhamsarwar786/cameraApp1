// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_first_app/cameraPictureEdit.dart';
import 'package:my_first_app/image_list.dart';
import 'model.dart';
import 'image_helper.dart';
import 'ArDeep.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  TextEditingController imageNameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String name;
  ImageHelper helper = ImageHelper();
  File _image;
  String path;
  final picker = ImagePicker();
  ImageModel imageModel;

  // Filter Image Get Here
  // getFilterImage() {}

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
      path = pickedFile.path;
    });
    print(_image);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CameraEditor(path)));
  }

  // _save() async {
  //   int result;
  //   ImageModel image = ImageModel(image: path, name: DateTime.now().toString());
  //   result = await helper.insertImage(image);
  //   if (result != 0) {
  //     // Success
  //     Navigator.pop(context, true);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Add Image'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                // Center(
                //   child: ClipOval(
                //     child: _image == null
                //         ? Image.asset(
                //             'images/bg1.jpg',
                //             fit: BoxFit.cover,
                //             width: 150,
                //             height: 150,
                //           )
                //         : Image.file(
                //             _image,
                //             fit: BoxFit.cover,
                //             width: 150,
                //             height: 150,
                //           ),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                customRaisedButton(
                    width: MediaQuery.of(context).size.width * 0.80,
                    icon: Icon(
                      Icons.grid_view,
                      size: 70,
                      color: Colors.white,
                    ),
                    color: Colors.pink[300],
                    text: 'Gallery',
                    fontSize: 30.0,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ImageList()));
                      // getImageFromCamera();
                      print("Cliked");
                    }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customRaisedButton(
                        width: MediaQuery.of(context).size.width * 0.39,
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        color: Colors.purple[300],
                        text: 'Camera',
                        fontSize: 20.0,
                        textColor: Colors.white,
                        onPressed: () {
                          getImageFromCamera();
                        }),
                    customRaisedButton(
                        width: MediaQuery.of(context).size.width * 0.39,
                        icon: Icon(
                          Icons.filter,
                          size: 40,
                          color: Colors.white,
                        ),
                        color: Colors.blue[300],
                        text: 'Filter',
                        fontSize: 20.0,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArDeep()));
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // customRaisedButton(
                //     color: Colors.white,
                //     text: 'Save',
                //     textColor: Colors.black,
                //     onPressed: _save),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customRaisedButton(
      {var width,
      var icon,
      String text,
      var fontSize,
      Color textColor,
      Color color,
      Function onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 150,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontFamily: "RobotSlab"),
            ),
          ],
        ),
        // child: RaisedButton(
        //   color: color,
        //   child: Text(
        //     text,
        //     style: TextStyle(
        //       color: textColor,
        //     ),
        //   ),
        //   onPressed: onPressed,
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10),
        //       side: BorderSide(color: Colors.white, width: 1)),
        // ),
      ),
    );
  }
}
