// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cubicle_fitness/pages/logged_in_pages/Activities/activity_widgets/activities_list.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/activity_widgets/categories_list.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/pages/create_new_activity_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/pages/create_new_category_page.dart';
import 'package:flutter/material.dart';

class ActivitiesPage extends StatefulWidget {
  ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  bool activitiesSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          foregroundColor: Theme.of(context).colorScheme.tertiary,
          elevation: 8,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => activitiesSelected
                      ? CreateActivityPage()
                      : CreateCategoryPage()),
            );
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!activitiesSelected) {
                            setState(() {
                              activitiesSelected = true;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                              color: activitiesSelected
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Icon(
                                Icons.run_circle_outlined,
                                size: 40,
                              ),
                              Text("Activities",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (activitiesSelected) {
                            setState(() {
                              activitiesSelected = false;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                              color: !activitiesSelected
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Icon(
                                Icons.category_outlined,
                                size: 40,
                              ),
                              Text("Categories",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: activitiesSelected
                          ? ActivitiesList()
                          : CategoriesList()),
                ],
              ),
            ),
          ),
        ));
  }
}
