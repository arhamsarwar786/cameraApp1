import 'dart:typed_data';

class ImageModel {
  Uint8List image;
  String name;
  int id;

  ImageModel({
    this.image,
    this.name,
  });

  int get imageid => id;

  Uint8List get images => image;

  String get imageName => name;

  set images(Uint8List newImage) {
    this.image = newImage;
  }

  set imageName(String newName) {
    this.name = newName;
  }

  Map<String, dynamic> toMap() {
    var imageMap = Map<String, dynamic>();
    if (id != null) {
      imageMap['id'] = id;
    }
    imageMap['image'] = image;
    imageMap['name'] = name;
    return imageMap;
  }

  ImageModel.fromMap(Map<String, dynamic> imageMap) {
    id = imageMap['id'];
    image = imageMap['image'];
    name = imageMap['name'];
  }
}
