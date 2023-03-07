import 'package:flutter/cupertino.dart';

import '../../data/firestore_service.dart';
import '../../helpers/show_message_widget.dart';

class AddProductProvider extends ChangeNotifier {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  bool isLoading = false;

  void writeData() async {
    isLoading = true;
    notifyListeners();
    await ChatagramFirestoreService.writeData(
            title: productNameController.text,
            desc: productDescController.text,
            img:
                "https://avatars.mds.yandex.net/i?id=16732348b271365c217b51211129da7bd0fb2c36-8199228-images-thumbs&n=13")
        .then((value) {
      if (value == true) {
        isLoading = false;
        notifyListeners();
        showErrorMessage("Mahsulot muvoffaqiyatli qo'shildi");
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}