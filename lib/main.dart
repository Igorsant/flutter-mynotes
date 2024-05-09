import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/email_verified_view.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView()
    },
  ));
}

enum MenuItems { logout }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          final user = FirebaseAuth.instance.currentUser;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(title: const Text("Loading...")),
              body: const CircularProgressIndicator(),
            );
          }
          if (user == null) {
            return const RegisterView();
          }
          if (!user.emailVerified) {
            return const EmailVerifiedView();
          }
          if (user.emailVerified) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Main UI'),
                  actions: [
                    PopupMenuButton<MenuItems>(
                        itemBuilder: (context) => <PopupMenuEntry<MenuItems>>[
                              const PopupMenuItem<MenuItems>(
                                  value: MenuItems.logout,
                                  child: Text("logout"))
                            ])
                  ],
                ),
                body: const Text('home page'));
          }
          return const LoginView();
        });
  }
}
