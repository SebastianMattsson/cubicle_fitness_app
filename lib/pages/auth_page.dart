// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/pages/home_page.dart';
import 'package:cubicle_fitness/pages/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the authentication state is still loading, show a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // If user is logged in, navigate to the home page
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          });
          // Return an empty container while the navigation is in progress
          return Container();
        } else {
          // If user is not logged in, navigate to the intro page
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => IntroPage()));
          });
          // Return an empty container while the navigation is in progress
          return Container();
        }
      },
    ));
  }
}
