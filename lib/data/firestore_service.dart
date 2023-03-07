import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/show_message_widget.dart';

class ChatagramFirestoreService {
  static CollectionReference products =
      FirebaseFirestore.instance.collection("products");

  static Future<bool> writeData(
      {required String title,
      required String desc,
      required String img}) async {
    try {
      await products.add({
        "title": title,
        "desc": desc,
        "image": img,
        "created_at": FieldValue.serverTimestamp(),
      });
      return true;
    } on FirebaseException catch (e) {
      showErrorMessage(e.message.toString());
      return false;
    }
  }
}
