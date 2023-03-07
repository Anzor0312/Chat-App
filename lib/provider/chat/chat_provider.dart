import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../data/chat_servise.dart';

class ChatProvider extends ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
      .collection('message')
      .orderBy('created_at')
      .snapshots();

  void writeMessage() async {
    if (messageController.text.isNotEmpty) {
       await ChatagramChatService.writeMessage(message: messageController.text);
    
    messageController.clear();
    }
  }

  bool camera = false;
  void CameraIcon() {
    if (camera == true) {
      camera = false;
      notifyListeners();
    } else {
      camera = true;
      notifyListeners();
    }
  }
}
