// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;
  Future<void> signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: signUserOut,
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
              gap: 12,
              backgroundColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).colorScheme.secondary,
              activeColor: Theme.of(context).colorScheme.background,
              tabBackgroundColor: Theme.of(context).colorScheme.secondary,
              padding: EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: Icons.dashboard,
                  text: "Dashboard",
                ),
                GButton(
                  icon: Icons.sports_tennis,
                  text: "Activities",
                ),
                GButton(
                  icon: Icons.people,
                  text: "Company",
                ),
                GButton(
                  icon: Icons.settings,
                  text: "Profile",
                ),
              ]),
        ),
      ),
      body: Center(child: Text("Welcome ${user?.email}")),
    );
  }
}
