// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:cubicle_fitness/pages/register_page.dart";
import "package:cubicle_fitness/widgets/email_TF.dart";
import "package:cubicle_fitness/widgets/forgot_password_BT.dart";
import "package:cubicle_fitness/widgets/login_BT.dart";
import "package:cubicle_fitness/widgets/password_TF.dart";
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

  void signInUser() async {
    //Show a loading circle
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    //Try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      //Remove the loading circle
      Navigator.pop(context);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //Remove the loading circle
      Navigator.pop(context);
      showErrorMessage();
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
                child: SingleChildScrollView(
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
                      EmailTF(
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      PasswordTF(
                        label: "Password",
                        hintText: "Enter your password",
                        controller: passwordController,
                      ),
                      ForgotPWBT(),
                      Container(
                        child: Row(
                          children: [
                            Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                child: Checkbox(
                                  value: _rememberMe,
                                  checkColor:
                                      Theme.of(context).colorScheme.primary,
                                  activeColor:
                                      Theme.of(context).colorScheme.secondary,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value;
                                    });
                                  },
                                )),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
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
                                        image: AssetImage(
                                            "lib/images/google.png"))),
                              ),
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
                                                const RegisterPage()));
                                  },
                                  child: Text("Register now",
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
            ),
          )
        ],
      ),
    );
  }
}
