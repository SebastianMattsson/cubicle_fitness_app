// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.blue!,
    secondary: Colors.blue[200]!,
    background: Color(0xFFFFFFFF),
    tertiary: Colors.black,
    // background: Color.fromARGB(255, 6, 109, 211),
    // primary: Color.fromARGB(255, 35, 126, 217),
    // secondary: Color.fromARGB(255, 255, 255, 255),
  ),
);
