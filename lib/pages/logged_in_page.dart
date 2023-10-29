// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cubicle_fitness/pages/logged_in_pages/Activities/pages/activities_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Notifications/pages/notifications_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/pages/company_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activity_calender/pages/activity_calender_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/profile/profile_page.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:badges/badges.dart' as badges;

class LoggedInPage extends StatefulWidget {
  const LoggedInPage({super.key});

  @override
  State<LoggedInPage> createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirestoreService();
  int _page = 0;
  final pages = [
    MyActivitiesPage(),
    ActivitiesPage(),
    CompanyPage(),
    ProfilePage()
  ];

  void changePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        elevation: 0,
        actions: [
          StreamBuilder(
              stream: db.getUserStreamByEmail(currentUser.email!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Loading indicator while fetching user data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var userData = snapshot.data!;
                  return Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text.rich(TextSpan(
                                    text: "Cubicle",
                                    style: TextStyle(
                                        fontSize: 36,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "Fitness",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary))
                                    ])))),
                        StreamBuilder(
                            stream:
                                db.getUnreadNotificationsCount(userData.id!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Loading indicator while fetching user data
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                var unreadNotificationCount = snapshot.data!;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NotificationsPage())),
                                      child: badges.Badge(
                                        badgeStyle: badges.BadgeStyle(
                                            badgeColor: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        showBadge: unreadNotificationCount > 0,
                                        badgeContent: Text(
                                            unreadNotificationCount.toString()),
                                        child: Icon(Icons.notifications),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            })
                      ],
                    ),
                  );
                }
              })
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            gap: 12,
            backgroundColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.tertiary,
            activeColor: Theme.of(context).colorScheme.tertiary,
            tabBackgroundColor: Theme.of(context).colorScheme.background,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.calendar_month,
                text: "Calender",
              ),
              GButton(
                icon: Icons.sports_tennis,
                text: "Activities",
              ),
              GButton(
                icon: Icons.supervised_user_circle,
                text: "Company",
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
              ),
            ],
            selectedIndex: _page,
            onTabChange: (value) => changePage(value),
          ),
        ),
      ),
      body: pages[_page],
    );
  }
}
