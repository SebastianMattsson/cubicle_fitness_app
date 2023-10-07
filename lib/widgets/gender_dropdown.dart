// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final Function(dynamic) onGenderSelected;
  final String genderSelected;
  GenderDropdown(
      {super.key,
      required this.onGenderSelected,
      required this.genderSelected});

  List<DropdownMenuItem> dropdownItems = [
    DropdownMenuItem(
      value: "Male",
      child: Text("Male"),
    ),
    DropdownMenuItem(
      value: "Female",
      child: Text("Female"),
    ),
    DropdownMenuItem(
      value: "Other",
      child: Text("Other"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      )
                    ]),
                height: 60,
                child: DropdownButtonFormField(
                  items: dropdownItems,
                  value: genderSelected,
                  onChanged: onGenderSelected,
                  iconEnabledColor: Theme.of(context).colorScheme.background,
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.background),
                  decoration: InputDecoration(
                    filled:
                        true, // Set to true to enable filling the container color
                    fillColor: Theme.of(context)
                        .colorScheme
                        .primary, // Background color of the TextField
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.transgender,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
