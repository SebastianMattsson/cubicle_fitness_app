import 'package:flutter/material.dart';

class CompanyButton extends StatelessWidget {
  final Function() onPress;
  final String text;
  const CompanyButton({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: StadiumBorder(),
            elevation: 6),
        onPressed: onPress,
        child: Text(text,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.tertiary)));
  }
}
