import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("My First App Bar")
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _email.text, password: _password.text);
                    print(userCredential);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      print("Email already in use");
                      return;
                    }
                    if (e.code == 'weak-password') {
                      print('weak password!');
                      return;
                    }
                    if (e.code == 'invalid-email') {
                      print('invalid email!');
                      return;
                    }
                    
                    print(e.code);
                  }
                },
                child: const Text("Register")),
          ],
        ),
      ),
    );
  }
}
