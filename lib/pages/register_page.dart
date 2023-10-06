// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubicle_fitness/pages/log_in_page.dart';
import 'package:cubicle_fitness/services/auth_service.dart';
import 'package:cubicle_fitness/widgets/email_TF.dart';
import 'package:cubicle_fitness/widgets/form_TF.dart';
import 'package:cubicle_fitness/widgets/login_BT.dart';
import 'package:cubicle_fitness/widgets/password_TF.dart';
import 'package:cubicle_fitness/widgets/sign_in_with_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstnameController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();

  void signUpUser() async {
    //Show a loading circle
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    //Try signing in
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        addUserDetails(
            nameController.text.trim(),
            surnameController.text.trim(),
            emailController.text.trim(),
            int.parse(ageController.text.trim()));

        //Remove the loading circle
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        //Remove the loading circle
        Navigator.pop(context);
        showErrorMessage("The passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      //Remove the loading circle
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  Future addUserDetails(
      String name, String surName, String email, int age) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'name': name, 'surname': surName, 'email': email, 'age': age});
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message.toString()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withAlpha(230),
                Theme.of(context).colorScheme.primary.withAlpha(200),
                Theme.of(context).colorScheme.primary.withAlpha(170),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            )),
          ),
          SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                            fontSize: 50,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormTextField(
                        label: "Email",
                        hintText: "Enter your email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email,
                      ),
                      FormTextField(
                        label: "Password",
                        hintText: "Enter your password",
                        controller: passwordController,
                        obscureText: true,
                        icon: Icons.lock,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormTextField(
                          label: "Confirm Password",
                          hintText: "Enter your password again",
                          controller: confirmPasswordController,
                          obscureText: true,
                          icon: Icons.lock),
                      SizedBox(
                        height: 10,
                      ),
                      FormTextField(
                          label: "Firstname",
                          hintText: "Enter your firstname",
                          controller: nameController,
                          icon: Icons.short_text_outlined),
                      SizedBox(
                        height: 10,
                      ),
                      FormTextField(
                          label: "Surname",
                          hintText: "Enter your surname",
                          controller: surnameController,
                          icon: Icons.short_text_outlined),
                      SizedBox(
                        height: 10,
                      ),
                      FormTextField(
                          label: "Age",
                          hintText: "Enter your age",
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          icon: Icons.numbers),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        width: double.infinity,
                        child: LogInBT(
                          text: "REGISTER",
                          onPressed: signUpUser,
                        ),
                      ),
                      Column(
                        children: [
                          Text("- OR -",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.8),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Sign in with",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Theme.of(context).colorScheme.background,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SignInWithTile(
                                  onTap: () {},
                                  imagePath: "lib/images/facebook.png"),
                              SignInWithTile(
                                  onTap: () => AuthService().signInWithGoogle(),
                                  imagePath: "lib/images/google.png"),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(0.8),
                                    fontSize: 16,
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LogInPage()));
                                  },
                                  child: Text("Log in",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
