import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth/sign_up_provider.dart';
import '../homePage.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      builder: (context, child) {
        return _scaffold(context);
      },
    );
  }

  Scaffold _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "Ismingizni kiriting",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                controller: context.watch<SignUpProvider>().emailController,
                decoration: InputDecoration(
                    hintText: "Email kiriting",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            TextField(
              controller: context.watch<SignUpProvider>().passwordController,
              decoration: InputDecoration(
                  hintText: "Parol kiriting",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(children: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>const SignInPage(),
                  ));
                  
            },
            child:const Text(" Sing")),
        FloatingActionButton.extended(
            onPressed: () async {
              await context.read<SignUpProvider>().singUp().then((value) {
                if (value == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  HomePage(),
                      ));
                }
              });
            },
            label: !context.watch<SignUpProvider>().isLoading
                ? const Text("Ro'yhatdan o'tish")
                : const CircularProgressIndicator.adaptive()),
      ]),
    );
  }
}
