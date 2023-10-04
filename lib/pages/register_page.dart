// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cubicle_fitness/pages/log_in_page.dart';
import 'package:cubicle_fitness/widgets/email_TF.dart';
import 'package:cubicle_fitness/widgets/login_BT.dart';
import 'package:cubicle_fitness/widgets/password_TF.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.primary,
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
                      "Sign Up",
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
                    PasswordTF(
                      label: "Password",
                      hintText: "Enter your password",
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    PasswordTF(
                      label: "Confirm Password",
                      hintText: "Enter your password again",
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      child: LogInBT(
                        text: "REGISTER",
                      ),
                    ),
                    Column(
                      children: [
                        Text("- OR -",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
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
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6)
                                  ],
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "lib/images/facebook.png"))),
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6)
                                  ],
                                  image: DecorationImage(
                                      image:
                                          AssetImage("lib/images/google.png"))),
                            ),
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
                                      .secondary
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
                                          .secondary,
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
          )
        ],
      ),
    );
  }
}