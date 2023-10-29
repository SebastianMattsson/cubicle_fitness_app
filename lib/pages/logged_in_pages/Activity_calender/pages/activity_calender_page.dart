// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:cubicle_fitness/models/activity.dart';
import 'package:cubicle_fitness/models/category.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activity_calender/Widgets/activity_tile.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activity_calender/Widgets/category_horizontal_tile.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activity_calender/Widgets/date_tile.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activity_calender/pages/activity_details_page.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyActivitiesPage extends StatefulWidget {
  MyActivitiesPage({super.key});

  @override
  State<MyActivitiesPage> createState() => _MyActivitiesPageState();
}

class _MyActivitiesPageState extends State<MyActivitiesPage> {
  final DateTime today = DateTime.now();
  DateTime? _selectedDate;
  CategoryModel? _selectedCategory;
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirestoreService();

  List<DateTime> generateDates() {
    List<DateTime> dates = [];
    for (int i = 0; i < 15; i++) {
      dates.add(today.add(Duration(days: i)));
    }
    return dates;
  }

  void _handleDateSelection(DateTime selectedDate) {
    if (_selectedDate == null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    } else if (selectedDate == _selectedDate) {
      setState(() {
        _selectedDate = null;
      });
    } else {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  void _handleCategorySelection(CategoryModel selectedCategory) {
    if (_selectedCategory == null) {
      setState(() {
        _selectedCategory = selectedCategory;
      });
    } else if (_selectedCategory!.name == selectedCategory.name) {
      setState(() {
        _selectedCategory = null;
      });
    } else {
      setState(() {
        _selectedCategory = selectedCategory;
      });
    }
  }

  List<ActivityModel> _filterActivities(List<ActivityModel> activitiesData) {
    var filteredActivities = activitiesData.where((activity) {
      // Parse activity.dateTime string into a DateTime object
      DateTime activityDateTime = DateTime.parse(activity.dateTime);

      // Check if the activity is in the past
      bool isActivityInPast = activityDateTime.isBefore(today);

      // Format activity's DateTime object to match selected date format
      bool isSameDate = true;
      if (_selectedDate != null) {
        String activityDateString =
            DateFormat('yyyy-MM-dd').format(activityDateTime);

        String selectedDateString =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);

        isSameDate = activityDateString == selectedDateString;
      }

      bool hasSelectedCategory = _selectedCategory == null ||
          activity.categoryId == _selectedCategory!.id;
      return !isActivityInPast && isSameDate && hasSelectedCategory;
    }).toList();

    return filteredActivities;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedDate = today;
  // }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = generateDates();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(left: 24, top: 10, right: 24),
              child: StreamBuilder<UserModel>(
                  stream: db.getUserStreamByEmail(currentUser.email!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Loading indicator while fetching user data
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      var userData = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello ${userData.name}!",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 22,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Which activity are you interested in today?",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 60,
                            child: ListView.builder(
                                itemCount: dates.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  bool isSelected = false;
                                  if (_selectedDate != null) {
                                    isSelected = dates[index]
                                        .isAtSameMomentAs(_selectedDate!);
                                  }
                                  return DateTile(
                                    date: dates[index],
                                    isSelected: isSelected,
                                    onTap: () =>
                                        _handleDateSelection(dates[index]),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Categories",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 22,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          StreamBuilder<List<CategoryModel>>(
                              stream: db.getCategoryStream(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // Loading indicator while fetching user data
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  var categoryData = snapshot.data!;
                                  return Column(
                                    children: [
                                      Container(
                                        height: 100,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: categoryData.length,
                                          itemBuilder: (context, index) {
                                            bool isSelected = false;
                                            if (_selectedCategory != null) {
                                              isSelected =
                                                  _selectedCategory!.name ==
                                                      categoryData[index].name;
                                            }
                                            return HorizontalCategoryTile(
                                                category: categoryData[index],
                                                isSelected: isSelected,
                                                onTap: () =>
                                                    _handleCategorySelection(
                                                        categoryData[index]));
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  SizedBox(
                                            width: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Activities",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 22,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          userData.companyId != null
                              ? StreamBuilder<List<ActivityModel>>(
                                  stream: db.getCompaniesActivitiesStream(
                                      userData.companyId!),
                                  builder: ((context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // Loading indicator while fetching user data
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      var activitiesData = snapshot.data!;

                                      // Filter activities based on selected date and category
                                      var filteredActivities =
                                          _filterActivities(activitiesData);

                                      return Expanded(
                                          child: filteredActivities.length == 0
                                              ? Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 30),
                                                    child: Text(
                                                      "No Activities available, head to the activities tab to create a new activity",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .tertiary,
                                                        fontSize: 18,
                                                        fontFamily: 'Roboto',
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : ListView.separated(
                                                  itemCount:
                                                      filteredActivities.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ActivityDetailsPage(
                                                                          activityData:
                                                                              filteredActivities[index],
                                                                          user:
                                                                              userData,
                                                                        )));
                                                      },
                                                      child: ActivityTile(
                                                          activityData:
                                                              filteredActivities[
                                                                  index]),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, int index) =>
                                                          SizedBox(
                                                    height: 20,
                                                  ),
                                                ));
                                    }
                                  }))
                              : Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      child: Text(
                                        "Oops! It looks like you're not currently affiliated with any company. As a result, there are no activities available to show. Join a company to stay updated with exciting activities and events!",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      );
                    }
                  })),
        ));
  }
}
