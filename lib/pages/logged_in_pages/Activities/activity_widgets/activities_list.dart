import 'package:cubicle_fitness/pages/logged_in_pages/Activities/activity_widgets/activity_tile.dart';
import 'package:flutter/material.dart';

class ActivitiesList extends StatelessWidget {
  ActivitiesList({super.key});

  List<String> list = [
    "Yoga",
    "Padel",
    "Tennis",
    "Football",
    "Running",
    "Spinning",
    "Rugby",
    "Swimming"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => ActivityTile(),
        separatorBuilder: (context, index) => SizedBox(
              height: 20,
            ),
        itemCount: list.length);
  }
}
