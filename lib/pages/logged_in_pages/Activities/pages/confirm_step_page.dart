// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/models/category.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/activity_widgets/confirm_text.dart';
import 'package:flutter/material.dart';

class ConfirmStep extends StatelessWidget {
  final String name;
  final String description;
  final String cost;
  final String dateTime;
  final String repeatFrequencySelected;
  final String location;
  final String min;
  final String max;
  final CategoryModel category;
  const ConfirmStep(
      {super.key,
      required this.name,
      required this.description,
      required this.cost,
      required this.dateTime,
      required this.location,
      required this.min,
      required this.max,
      required this.category,
      required this.repeatFrequencySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
                fontFamily: 'Roboto',
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: SizedBox(
              width: 210,
              child: Text(
                description,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ConfirmText(text: dateTime, icon: Icons.calendar_month),
          SizedBox(
            height: 10,
          ),
          ConfirmText(text: repeatFrequencySelected, icon: Icons.repeat),
          SizedBox(
            height: 10,
          ),
          ConfirmText(text: location, icon: Icons.place),
          SizedBox(
            height: 10,
          ),
          ConfirmText(text: "$cost Kr", icon: Icons.attach_money),
          SizedBox(
            height: 10,
          ),
          ConfirmText(
              text: "$min - $max Participants",
              icon: Icons.supervised_user_circle),
          SizedBox(
            height: 10,
          ),
          ConfirmText(text: category.name, icon: Icons.category),
        ],
      ),
    );
  }
}
