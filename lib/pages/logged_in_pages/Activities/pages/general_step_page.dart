// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/pages/logged_in_pages/Activities/activity_widgets/repeat_drop_down.dart';
import 'package:cubicle_fitness/widgets/form_TF.dart';
import 'package:cubicle_fitness/widgets/text_field_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralStep extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController costController;
  final TextEditingController dateTimeController;
  final TextEditingController locationController;
  final String repeatFrequencySelected;
  final Function(dynamic) onFrequencyChanged;
  const GeneralStep(
      {super.key,
      required this.nameController,
      required this.descriptionController,
      required this.costController,
      required this.dateTimeController,
      required this.locationController,
      required this.repeatFrequencySelected,
      required this.onFrequencyChanged});

  @override
  State<GeneralStep> createState() => _GeneralStepState();
}

class _GeneralStepState extends State<GeneralStep> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  void _showDateTimePicker() async {
    DateTime currentDate = DateTime.now();
    DateTime lastDate = currentDate.add(Duration(days: 45));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: currentDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          selectedTime = pickedTime;

          String formattedDateTime =
              DateFormat('yyyy-MM-dd HH:mm').format(selectedDate);
          widget.dateTimeController.text = formattedDateTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TextFieldForm(
          hintText: "Enter the name",
          label: "Name",
          icon: Icons.text_fields,
          controller: widget.nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "The name cant be empty";
            }
            return null;
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextFieldForm(
            hintText: "Enter the description",
            label: "Description",
            icon: Icons.description,
            controller: widget.descriptionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "The description cant be empty";
              }
              return null;
            }),
        SizedBox(
          height: 15,
        ),
        TextFieldForm(
            hintText: "Enter cost",
            label: "Cost",
            keyBoardType: TextInputType.number,
            icon: Icons.attach_money_outlined,
            controller: widget.costController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "The cost cant be empty";
              }
              return null;
            }),
        SizedBox(
          height: 15,
        ),
        TextFieldForm(
            hintText: "Choose date and time",
            onTap: _showDateTimePicker,
            label: "Date and time",
            icon: Icons.calendar_month,
            controller: widget.dateTimeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "The date cant be empty";
              }
              return null;
            }),
        SizedBox(
          height: 15,
        ),
        RepeatDropDown(
          label: "Repeat",
          repeatFrequencySelected: widget.repeatFrequencySelected,
          onFrequencyChanged: widget.onFrequencyChanged,
          icon: Icons.repeat,
        ),
        SizedBox(
          height: 15,
        ),
        TextFieldForm(
            hintText: "Enter location",
            label: "Location",
            icon: Icons.near_me,
            controller: widget.locationController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "The location cant be empty";
              }
              return null;
            }),
      ],
    );
  }
}
