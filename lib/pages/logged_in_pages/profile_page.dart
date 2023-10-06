// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cubicle_fitness/widgets/profile_menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(children: [
            Stack(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(image: AssetImage("lib/images/google.png")),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).colorScheme.primary),
                    child: Icon(Icons.edit_outlined,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Sebastian Mattsson",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              user.email!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: StadiumBorder(),
                    elevation: 6),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            ProfileMenuItem(
              title: "Settings",
              icon: Icons.settings,
              onPress: () {},
            ),
            ProfileMenuItem(
              title: "Billing Details",
              icon: Icons.wallet,
              onPress: () {},
            ),
            ProfileMenuItem(
              title: "User Management",
              icon: Icons.lock_person_rounded,
              onPress: () {},
            ),
            Divider(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            ProfileMenuItem(
              title: "Information",
              icon: Icons.info_outline,
              onPress: () {},
            ),
            ProfileMenuItem(
              title: "Logout",
              icon: Icons.logout,
              onPress: () async {
                await FirebaseAuth.instance.signOut();
              },
              textColor: Colors.red,
              showEndIcon: false,
            ),
          ]),
        ),
      ),
    );
  }
}
