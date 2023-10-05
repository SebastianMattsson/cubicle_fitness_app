// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cubicle_fitness/widgets/email_TF.dart';
import 'package:cubicle_fitness/widgets/password_TF.dart';
import 'package:flutter/material.dart';

class UserStep extends StatelessWidget {
  const UserStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //EmailTF(),
        SizedBox(
          height: 20,
        ),
        // PasswordTF(
        //   label: "Password",
        //   hintText: "Enter your password",
        // ),
        SizedBox(
          height: 20,
        ),
        // PasswordTF(
        //   label: "Re-Enter Password",
        //   hintText: "Re-Enter your password",
        // ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
