import 'package:flutter/material.dart';

class ForgotPWBT extends StatelessWidget {
  const ForgotPWBT({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Forgot your password?",
          style: TextStyle(
              color: Theme.of(context).colorScheme.background,
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
