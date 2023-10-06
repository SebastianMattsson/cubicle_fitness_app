import 'package:flutter/material.dart';

class LogInBT extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const LogInBT({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: Theme.of(context).colorScheme.background,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Text(
        text,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Roboto',
            letterSpacing: 2,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
