// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cubicle_fitness/widgets/extras_step_TF.dart';
import 'package:flutter/material.dart';

class ExtrasStep extends StatefulWidget {
  const ExtrasStep({super.key});

  @override
  State<ExtrasStep> createState() => _ExtrasStepState();
}

class _ExtrasStepState extends State<ExtrasStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExtrasTF(
          label: "Firstname",
          hintText: "Enter your firstname",
          icon: Icons.short_text,
        ),
        SizedBox(
          height: 20,
        ),
        ExtrasTF(
          label: "Lastname",
          hintText: "Enter your lastname",
          icon: Icons.short_text,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
