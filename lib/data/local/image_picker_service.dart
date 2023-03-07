import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telegram/helpers/show_message_widget.dart';

class ImagePicKerService {
  static ImageSource camera = ImageSource.camera;
  static ImageSource gallery = ImageSource.gallery;

  static File? selectedImage;
  static XFile? image;

  static Future<void> selectImage(ImageSource sourse) async {
    try {
      image = await ImagePicker().pickImage(source: sourse);
      File? img = File(image!.path);
      selectedImage = img;
    } catch (e) {
      showErrorMessage(e.toString());
    }
  }
}
