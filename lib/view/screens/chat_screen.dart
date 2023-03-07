import 'package:flutter/material.dart';

import '../pages/chat_page.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat Page"),
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/telegram.png"),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
         
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ChatPage()));
              },
              child: const Text("Chatga o'tish"),
            ),
          ],
        ));
  }
}
