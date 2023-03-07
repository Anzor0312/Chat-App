import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:telegram/helpers/show_message_widget.dart';

class FirebaseStorageServise {
  static String uploadedFilePath = "";

  static Future<void> uploadFile(File file, String folderName) async {
    try {
      String fileName = basename(file.path);
      var snapshot = await FirebaseStorage.instance
          .ref()
          .child("$folderName/$fileName")
          .putFile(file);
      uploadedFilePath = await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      showErrorMessage(e.message.toString());
    }
  }
}
