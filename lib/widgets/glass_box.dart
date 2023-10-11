import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget {
  const GlassBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Theme.of(context).colorScheme.background.withOpacity(0.8),
                  Theme.of(context).colorScheme.background.withOpacity(0.4)
                ])),
          )
        ],
      ),
    );
  }
}
