import 'package:cubicle_fitness/widgets/text_field_form.dart';
import 'package:flutter/material.dart';

class ParticipantsStep extends StatelessWidget {
  final TextEditingController minController;
  final TextEditingController maxController;
  const ParticipantsStep(
      {super.key, required this.minController, required this.maxController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TextFieldForm(
            hintText: "Enter minimum participants",
            label: "Min Participants",
            icon: Icons.group_remove,
            controller: minController),
        SizedBox(
          height: 20,
        ),
        TextFieldForm(
            hintText: "Enter maximum participants",
            label: "Max Paricipants",
            icon: Icons.group_add,
            controller: maxController),
      ],
    );
  }
}
