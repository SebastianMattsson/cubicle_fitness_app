import 'package:flutter/material.dart';

class LogInBT extends StatelessWidget {
  const LogInBT({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Text(
        "LOGIN",
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
