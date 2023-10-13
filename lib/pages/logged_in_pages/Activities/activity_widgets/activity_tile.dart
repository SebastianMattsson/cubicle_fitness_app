// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
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
                  "Activity",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Another data",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Third Data",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Image(
                height: 100,
                width: 120,
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1552674605-db6ffd4facb5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80")),
          )
        ],
      ),
    );
  }
}
