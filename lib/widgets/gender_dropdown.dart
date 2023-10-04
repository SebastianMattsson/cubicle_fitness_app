// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class GenderDropDown extends StatefulWidget {
  final Function(String) onGenderSelected;
  const GenderDropDown({super.key, required this.onGenderSelected});

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> drop_down_items = [
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

    String _dropdownvalue = "Male";

    void dropdownCallBack(String? selectedValue) {
      print(selectedValue);
      if (selectedValue is String) {
        setState(() {
          _dropdownvalue = selectedValue;
        });
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
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
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: drop_down_items,
                iconEnabledColor: Theme.of(context).colorScheme.secondary,
                iconSize: 42,
                value: _dropdownvalue,
                isExpanded: true,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    _dropdownvalue = value;
                    widget.onGenderSelected(_dropdownvalue);
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
