// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cubicle_fitness/pages/logged_in_pages/activities_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/dashboard_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/my_activities.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/profile/profile_page.dart';
import 'package:cubicle_fitness/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LoggedInPage extends StatefulWidget {
  const LoggedInPage({super.key});

  @override
  State<LoggedInPage> createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  final user = FirebaseAuth.instance.currentUser;
  final _auth = AuthService();
  int _page = 0;
  final pages = [
    MyActivitiesPage(),
    ActivitiesPage(),
    DashboardPage(),
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.secondary,
              ))
        ],
      ),
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
                icon: Icons.favorite,
                text: "My Activities",
              ),
              GButton(
                icon: Icons.sports_tennis,
                text: "Activities",
              ),
              GButton(
                icon: Icons.dashboard,
                text: "Dashboard",
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
