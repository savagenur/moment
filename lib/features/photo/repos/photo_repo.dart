import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PhotoRepo {
  static final _picker = ImagePicker();
  static  Future<File?> takePhoto(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<File?> recordVideo(ImageSource imageSource) async {
    final pickedFile = await _picker.pickVideo(source: imageSource);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
