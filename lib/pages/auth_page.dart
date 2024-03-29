// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/pages/intro_page.dart';
import 'package:cubicle_fitness/pages/logged_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LoggedInPage();
        } else {
          return IntroPage();
        }
      },
    );
  }
}
