import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth/sign_in_provider.dart';
import '../homePage.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SingInProvider(),
      builder: (context, child) {
        return _scaffold(context);
      },
    );
  }

  Scaffold _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SingIn page"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: context.watch<SingInProvider>().emailController,
              decoration: InputDecoration(
                  hintText: "Email kiriting",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          TextField(
            controller: context.watch<SingInProvider>().passwordController,
            decoration: InputDecoration(
                hintText: "Parol kiriting",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await context.read<SingInProvider>().singIn().then((value) {
              if (value == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  HomePage(),
                    ));
              }
            });
          },
          label: !context.watch<SingInProvider>().isLoading
              ? const Text("Kirish")
              : const CircularProgressIndicator.adaptive()),
    );
  }
}
