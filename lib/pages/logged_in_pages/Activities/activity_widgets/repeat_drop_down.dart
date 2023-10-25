// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class RepeatDropDown extends StatelessWidget {
  final String label;
  final String repeatFrequencySelected;
  final Function(dynamic) onFrequencyChanged;
  final IconData icon;
  RepeatDropDown(
      {super.key,
      required this.label,
      required this.repeatFrequencySelected,
      required this.onFrequencyChanged,
      required this.icon});

  List<DropdownMenuItem> dropdownItems = [
    DropdownMenuItem(
      value: "Never",
      child: Text("Never"),
    ),
    DropdownMenuItem(
      value: "Weekly",
      child: Text("Weekly"),
    ),
    DropdownMenuItem(
      value: "Monthly",
      child: Text("Monthly"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: dropdownItems,
      onChanged: onFrequencyChanged,
      value: repeatFrequencySelected,
      decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIconColor: Theme.of(context).colorScheme.tertiary,
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.6))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
          prefixIcon: Icon(icon)),
    );
  }
}
