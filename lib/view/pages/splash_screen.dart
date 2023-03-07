import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../homePage.dart';
import 'sign_up.dart';

class SplashScrenn extends StatefulWidget {
  const SplashScrenn({super.key});

  @override
  State<SplashScrenn> createState() => _SplashScrennState();
}

class _SplashScrennState extends State<SplashScrenn> {
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) => {
      chekUser()
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  
       Center(
         child: Container(
          
          child: Image.asset("assets/telegram.png",fit: BoxFit.fill,)),
       
       )
          
        
      
    );
  }

  void chekUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  HomePage(),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUpPage(),
            ));
      }
    });
  }
}
