import 'package:flutter/material.dart';

class NotificationText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  const NotificationText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: fontSize,
          fontWeight: fontWeight,
          color:
              color == null ? Theme.of(context).colorScheme.tertiary : color),
    );
  }
}
