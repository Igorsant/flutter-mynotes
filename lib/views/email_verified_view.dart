import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerifiedView extends StatelessWidget {
  const EmailVerifiedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Email Verification"),),
      body: Column(children: [
        const Text("Verify your email here"),
        TextButton(onPressed: () { 
          final user = FirebaseAuth.instance.currentUser;
          user?.sendEmailVerification();
        }, child: const Text("Verify email"))
      ],),
    );
  }
}