// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/profile/edit_profile_page.dart';
import 'package:cubicle_fitness/services/auth_service.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:cubicle_fitness/widgets/profile_menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirestoreService();
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: StreamBuilder<UserModel?>(
              stream: db.getUserStreamByEmail(currentUser.email!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data;
                  return Column(children: [
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 3),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image(image: NetworkImage(userData!.image)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${userData.name} ${userData.surname}",
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
                      userData.email,
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
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfilePage())),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: StadiumBorder(),
                            elevation: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
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
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
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
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
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
                        await _auth.signOut();
                      },
                      textColor: Colors.red,
                      showEndIcon: false,
                    ),
                  ]);
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
