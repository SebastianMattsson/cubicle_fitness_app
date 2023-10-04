import 'package:cubicle_fitness/pages/intro_page.dart';
import 'package:cubicle_fitness/providers/register_provider.dart';
import 'package:cubicle_fitness/themes/dark_theme.dart';
import 'package:cubicle_fitness/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterProvider())
      ],
      child: MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: IntroPage()),
    );
  }
}
