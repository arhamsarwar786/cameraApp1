import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/ArDeepShow.dart';
import 'package:my_first_app/image_helper.dart';

const apikey =
    "cea53c67181a34023bea21ed4620964fa3f28d021046b45a9014865f6be3dc170debacecd217234f";

class ArDeep extends StatefulWidget {
  @override
  _ArDeepState createState() => _ArDeepState();
}

class _ArDeepState extends State<ArDeep> {
  CameraDeepArController cameraDeepArController;
  int effectCount = 0;
  var getPath;
  var currentPage;

  ImageHelper helper = ImageHelper();

  List cartoon = [
    "images/teddy1.png",
    "images/teddy2.jpg",
    "images/teddy3.png",
    "images/teddy4.jpg",
    "images/teddy5.png",
    "images/teddy6.jpg",
    "images/teddy7.png"
  ];

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
                print(
                    "this is the path of Pic $path 66666666666666666666666666666666666666666666666666666");
                setState(() {
                  getPath = path;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArDeepShow(path)));
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
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 100),
              child: IconButton(
                icon: Icon(Icons.toggle_off),
                onPressed: () {
                  cameraDeepArController.switchCamera();
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 110),
              child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    // bool active = currentPage == i;
                    return InkWell(
                      onTap: () {
                        print(i);
                        setState(() {
                          // currentPage = i;
                          cameraDeepArController.changeMask(i);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: ExactAssetImage("${cartoon[i]}"),
                                fit: BoxFit.scaleDown),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.red, width: 5)),
                        alignment: Alignment.bottomCenter,
                      ),
                    );
                  }),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
              child: Icon(
                Icons.camera,
                size: 100,
                color: Colors.red,
              ),
              onPressed: () async {
                var image = await cameraDeepArController.snapPhoto();
                setState(() {
                  print(
                      "***********************************Clicked and image image $image ");
                  print(
                      "***********************************Clicked and  Getimage $getPath ");
                });
                // cameraDeepArController.dispose();
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
