import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/ArDeepShow.dart';
import 'package:my_first_app/image_helper.dart';

import 'model.dart';

const apikey =
    "cea53c67181a34023bea21ed4620964fa3f28d021046b45a9014865f6be3dc170debacecd217234f";

class ArDeep extends StatefulWidget {
  @override
  _ArDeepState createState() => _ArDeepState();
}

class _ArDeepState extends State<ArDeep> {
  CameraDeepArController cameraDeepArController;
  int effectCount = 0;
  var getPath = "";

  ImageHelper helper = ImageHelper();

  // @override
  // void deactivate() {
  //   cameraDeepArController.dispose();

  //   super.deactivate();
  // }

  // @override
  // void dispose() {
  //   cameraDeepArController.dispose();

  //   super.dispose();
  // }

  // @override
  // void initState() {
  //  cameraDeepArController.;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CameraDeepAr(
              onCameraReady: (isReady) {
                setState(() {});
              },
              onImageCaptured: (path) {
                print("this is the path of Pic $path");
                setState(() {
                  getPath = path;
                });
              },
              onVideoRecorded: (path) {
                setState(() {});
              },
              androidLicenceKey: apikey,
              iosLicenceKey: apikey,
              cameraDeepArCallback: (c) async {
                cameraDeepArController = c;
                setState(() {});
              }),
          Container(
            margin: EdgeInsets.only(top: 400),
            child: ListView.builder(
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        cameraDeepArController.changeMask(i);
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image.network(
                          "https://proofmart.com/wp-content/uploads/2020/09/mark-symball-icon-3-product.png"),
                    ),
                  );
                }),
          ),
          Positioned(
            bottom: 10,
            left: 110,
            child: MaterialButton(
              child: Icon(
                Icons.camera,
                size: 100,
              ),
              onPressed: () async {
                setState(() {});
                // cameraDeepArController.dispose();
                var image = await cameraDeepArController.snapPhoto();
                // print(
                // "***********************************Clicked and get image $image ");
                print(
                    "***********************************Clicked and get image $getPath ");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArDeepShow(getPath)));

                int result;
                ImageModel image1 =
                    ImageModel(image: getPath, name: DateTime.now().toString());
                result = await helper.insertImage(image);
                if (result != 0) {
                  // Success
                  Navigator.pop(context, true);
                }
              },
              onLongPress: () {
                print("LONGGGGG");
              },
            ),
          ),
        ],
      ),
    );
  }
}
