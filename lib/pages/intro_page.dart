// ignore_for_file: prefer_const_constructors

import "package:cubicle_fitness/pages/log_in_page.dart";
import "package:flutter/material.dart";

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  void onTap(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LogInPage()));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            image: DecorationImage(
              image: isDarkMode
                  ? AssetImage("lib/images/background_app_dark.png")
                  : AssetImage("lib/images/background_app_light.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),

                //Headline for the intro page
                Text(
                  "CubicleFitness",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 48,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 400,
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(280, 80),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                textStyle: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900),
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                foregroundColor:
                                    Theme.of(context).colorScheme.secondary),
                            child: Text("Log In"),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(280, 80),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                textStyle: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900),
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                foregroundColor:
                                    Theme.of(context).colorScheme.secondary),
                            child: Text("Register"),
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                )
                //Button for log in
              ],
            ),
          ),
        )
      ],
    );
  }
}
