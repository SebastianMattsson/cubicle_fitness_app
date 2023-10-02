// ignore_for_file: prefer_const_constructors

import "package:cubicle_fitness/widgets/email_TF.dart";
import "package:cubicle_fitness/widgets/password_TF.dart";
import "package:flutter/material.dart";

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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
                Theme.of(context).colorScheme.background,
              ],
              stops: [0.1, 0.4],
            )),
          ),
          SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                height: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 40,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    EmailTF(),
                    SizedBox(
                      height: 25,
                    ),
                    PasswordTF(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
