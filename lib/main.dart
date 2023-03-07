import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram/provider/chat/chat_provider.dart';

import 'provider/add/add_product_provider.dart';
import 'provider/auth/sign_in_provider.dart';
import 'provider/auth/sign_up_provider.dart';
import 'provider/home/home_provider.dart';
import 'view/pages/splash_screen.dart';

void main(List<String> args)async {

 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SignUpProvider(),),
        ChangeNotifierProvider(create:   (context) => SingInProvider(), ),
         ChangeNotifierProvider(create:   (context) => HomeProvider(), ),
         ChangeNotifierProvider(create: (context) => AddProductProvider()),
           ChangeNotifierProvider(create: (context) => ChatProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScrenn(),
    );
  }
}

