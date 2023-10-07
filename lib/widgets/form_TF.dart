// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final Function()? onTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData icon;
  const FormTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.onTap,
    this.obscureText = false,
    this.keyboardType,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   label,
          //   style: TextStyle(
          //       color: Theme.of(context).colorScheme.background,
          //       fontFamily: 'Roboto',
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold),
          // ),
          // SizedBox(
          //   height: 5,
          // ),
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
              onTap: onTap,
              keyboardType: keyboardType,
              controller: controller,
              obscureText: obscureText,
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
                    icon,
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
      ),
    );
  }
}
