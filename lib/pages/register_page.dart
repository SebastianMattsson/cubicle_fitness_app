// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cubicle_fitness/pages/log_in_page.dart';
import 'package:cubicle_fitness/services/auth_service.dart';
import 'package:cubicle_fitness/widgets/form_TF.dart';
import 'package:cubicle_fitness/widgets/gender_dropdown.dart';
import 'package:cubicle_fitness/widgets/login_BT.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final dateOfBirthController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String genderSelected = "Male";
  final _auth = AuthService();

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
        await _auth.createUserWithEmailAndPassword(
            emailController.text.trim(),
            passwordController.text.trim(),
            nameController.text.trim(),
            surnameController.text.trim(),
            dateOfBirthController.text.trim(),
            genderSelected,
            genderSelected == "Male"
                ? "https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?w=1380&t=st=1696794516~exp=1696795116~hmac=094bcefae9a099aa60b875b644de31f0654710a6c5050b95204b182e757021ef"
                : genderSelected == "Female"
                    ? "https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5908.jpg?w=1060&t=st=1696794637~exp=1696795237~hmac=f8412c7dc44f40dad0d7ad94a9dc7cee07bae2d175cecaf923d70972bc802bbb"
                    : "https://img.freepik.com/free-vector/thoughtful-woman-with-laptop-looking-big-question-mark_1150-39362.jpg?w=1060&t=st=1696794703~exp=1696795303~hmac=eadfb6de66d08fad02974fdeace111c6658b83d54682d84a2eba23d3f4f0d63f");

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

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message.toString()),
            ));
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        dateOfBirthController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
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
                      FormTextField(
                          label: "Confirm Password",
                          hintText: "Enter your password again",
                          controller: confirmPasswordController,
                          obscureText: true,
                          icon: Icons.lock),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: FormTextField(
                                label: "Firstname",
                                hintText: "Firstname",
                                controller: nameController,
                                icon: Icons.person),
                          ),
                          Flexible(
                            child: FormTextField(
                                label: "Surname",
                                hintText: "Surname",
                                controller: surnameController,
                                icon: Icons.person),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: FormTextField(
                                label: "Age",
                                hintText: "Date of birth",
                                onTap: _showDatePicker,
                                controller: dateOfBirthController,
                                keyboardType: TextInputType.datetime,
                                icon: Icons.calendar_month),
                          ),
                          Flexible(
                              child: GenderDropdown(
                            onGenderSelected: (value) {
                              setState(() {
                                genderSelected = value;
                              });
                            },
                            genderSelected: genderSelected,
                          )),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        width: double.infinity,
                        child: LogInBT(
                          text: "REGISTER",
                          onPressed: signUpUser,
                        ),
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
