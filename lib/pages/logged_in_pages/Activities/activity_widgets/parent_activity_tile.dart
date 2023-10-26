// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cubicle_fitness/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ParentActivityTile extends StatelessWidget {
  final ActivityModel activityData;
  const ParentActivityTile({super.key, required this.activityData});

  @override
  Widget build(BuildContext context) {
    int participantsCount = activityData.participants.length;
    int maxParticipants = activityData.maxParticipants;
    double progress = participantsCount / maxParticipants;
    DateTime eventDateTime = DateTime.parse(activityData.dateTime);
    String dayOfWeek = DateFormat('EEEE').format(eventDateTime);
    String startTime = DateFormat('HH:mm').format(eventDateTime);

    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  activityData.name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.8),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      activityData.repeated == "Never"
                          ? activityData.dateTime
                          : "${dayOfWeek}s at $startTime",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.8),
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.8),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      activityData.location,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.8),
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          activityData.repeated == "Never"
              ? Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Container(
                      width: 80,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                activityData.participants.length >=
                                        activityData.minParticipants
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.secondary),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${participantsCount} / ${maxParticipants}"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.person_2_sharp)
                            ],
                          )
                        ],
                      )),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Container(
                      height: 80,
                      width: 80,
                      child: Icon(
                        Icons.repeat,
                        size: 40,
                      )),
                ),
        ],
      ),
    );
  }
}
