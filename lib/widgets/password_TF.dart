// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PasswordTF extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  const PasswordTF(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Theme.of(context).colorScheme.background,
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ]),
          height: 60,
          child: TextField(
            controller: controller,
            obscureText: true,
            style: TextStyle(color: Theme.of(context).colorScheme.background),
            decoration: InputDecoration(
                filled:
                    true, // Set to true to enable filling the container color
                fillColor: Theme.of(context)
                    .colorScheme
                    .primary, // Background color of the TextField
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.background,
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.6))),
          ),
        )
      ],
    );
  }
}
