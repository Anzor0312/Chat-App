import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram/data/local/image_picker_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../provider/chat/chat_provider.dart' show ChatProvider;

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      builder: (context, child) => _scaffold(context),
    );
  }

  Scaffold _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.menu), title: const Text("Telegram")),
      body: StreamBuilder(
          stream: context.read<ChatProvider>().productStream,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              List<Map<String, dynamic>> data = [];
              snapshot.data!.docs.map(
                (DocumentSnapshot document) {
                  data.add(document.data() as Map<String, dynamic>);
                },
              ).toList();

              if (data.isEmpty) {
          return const Center(
            child: Text("HALI MAHSULOTLAR QO'SHILMAGAN"),
          );
        } else {
          return ListView.builder(itemBuilder: (context, index) {
            return Align(
                      alignment: data[index]['token'] ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Text(
                              data[index]['message'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
          },itemCount: data.length,);
          }
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Expanded(
                    flex: 1,
                    child: IconButton(
                      iconSize: 30,
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const ImageViewWidget();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.center_focus_strong,
                        color: Colors.white,
                      ),
                    )),
              ),
              Expanded(
                  flex: 9,
                  child: TextFormField(
                    showCursor: false,
                    controller: context.watch<ChatProvider>().messageController,
                    decoration: const InputDecoration(
                      hintText: "Write message",
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 7),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://source.unsplash.com/random/$index"),
                                            fit: BoxFit.fill)),
                                  ),
                                );
                              },
                            );
                          });
                    },
                    icon: Image.asset(
                      "assets/clip.png",
                      width: 50,
                      fit: BoxFit.fill,
                    ),
                    color: Colors.black,
                  )),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      context.read<ChatProvider>().CameraIcon();
                    },
                    iconSize: 30,
                    icon: context.watch<ChatProvider>().camera
                        ?const Icon(Icons.slow_motion_video_outlined)
                        : const Icon(
                            Icons.mic_sharp,
                          ),
                  )),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      context.read<ChatProvider>().writeMessage();
                    },
                    icon: const Icon(Icons.send, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ImageViewWidget extends StatefulWidget {
  const ImageViewWidget({super.key});

  @override
  State<ImageViewWidget> createState() => _ImageViewWidgetState();
}

class _ImageViewWidgetState extends State<ImageViewWidget> {
  @override
  void initState() {
    ImagePicKerService.selectedImage = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:ImagePicKerService.selectedImage == null? Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await ImagePicKerService.selectImage(ImagePicKerService.camera);
                setState(() {});
              },
              child: const Text("Camera")),
          ElevatedButton(
              onPressed: () async {
                await ImagePicKerService.selectImage(
                    ImagePicKerService.gallery);
                setState(() {});
              },
              child: const Text("Gallery")),
        ],
      ):const SizedBox(),
      content: ImagePicKerService.selectedImage != null
          ? Image.file(ImagePicKerService.selectedImage!)
          : const SizedBox(),
          
    );
  }
}
