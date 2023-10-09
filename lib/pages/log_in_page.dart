// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:cubicle_fitness/pages/register_page.dart";
import "package:cubicle_fitness/services/auth_service.dart";
import "package:cubicle_fitness/widgets/email_TF.dart";
import "package:cubicle_fitness/widgets/forgot_password_BT.dart";
import "package:cubicle_fitness/widgets/form_TF.dart";
import "package:cubicle_fitness/widgets/login_BT.dart";
import "package:cubicle_fitness/widgets/password_TF.dart";
import "package:cubicle_fitness/widgets/sign_in_with_tile.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool? _rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = AuthService();

  void signInUser() async {
    //Show a loading circle
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    //Try signing in
    try {
      dynamic result = await _auth.signInWithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());
      //Remove the loading circle
      Navigator.pop(context);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //Remove the loading circle
      Navigator.pop(context);
      showErrorMessage();
    } catch (e) {
      print("error" + e.toString());
    }
    //Remove the loading circle
    //Navigator.pop(context);
  }

  void showErrorMessage() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Wrong Credentials, try again"),
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
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.primary
              ],
              stops: [0.3, 1.2],
            )),
          ),
          SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 50,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      FormTextField(
                          hintText: "Enter your email",
                          label: "Email",
                          controller: emailController,
                          icon: Icons.email),
                      FormTextField(
                          hintText: "Enter your password",
                          label: "Password",
                          obscureText: true,
                          controller: passwordController,
                          icon: Icons.lock),
                      ForgotPWBT(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        child: LogInBT(
                          text: "LOGIN",
                          onPressed: signInUser,
                        ),
                      ),
                      Column(
                        children: [
                          Text("- OR -",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
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
                                color: Theme.of(context).colorScheme.tertiary,
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
                                  onTap: () => _auth.signInWithGoogle(),
                                  imagePath: "lib/images/google.png"),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Dont have an account?",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.8),
                                    fontSize: 16,
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage()));
                                  },
                                  child: Text("Register now",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
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
